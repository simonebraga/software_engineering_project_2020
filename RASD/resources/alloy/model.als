abstract sig Service {}

one sig SafeStreets {
	storedAccidents: set Accident
}

one sig SafeTickets extends Service {
	storedTickets: set Ticket,
	isProvidedBy: one SafeStreets
}

one sig SafeReports extends Service {
	storedViolationReports: set ViolationReport,
	isProvidedBy: one SafeStreets
}

one sig SafeSuggestions extends Service {
	storedSuggestions: set Suggestion,
	isProvidedBy: one SafeStreets
}

abstract sig User {}
one sig CommonUser extends User {}
one sig Authority extends User {}
one sig MunicipalityUser extends User {}
one sig Municipality {}

sig ViolationType {}
sig AccidentType {}
sig SuggestionType {}
sig LicensePlate {}

abstract sig Quality {}
one sig GOOD_QUALITY extends Quality {}
one sig BAD_QUALITY extends Quality {}

sig Picture {
	quality: Quality
}

sig ViolationReport {
	picture: one Picture,
	licensePlate: lone LicensePlate,
	violationType: one ViolationType,
	position: one Int,
	timestamp: one Int,
	creator:CommonUser
}

sig Accident {
	licensePlate: one LicensePlate,
	accidentType: one AccidentType,
	position: one Int,
	timestamp: one Int
}

sig Ticket {
	id: one Int,
	violationReport: one ViolationReport
} {
	id > 0
}

sig Suggestion {
	position: Int,
	violation: lone ViolationType,
	accident: lone AccidentType,
	suggestionType: one SuggestionType
} {
	(some violation) or (some accident)
}

abstract sig Reply {}

/******************************************************************************/

one sig POSITIVE_REPLY extends Reply {}
one sig NEGATIVE_REPLY extends Reply {}

//Represents the request for the OCR
sig RequestOCR{
	violationReport:ViolationReport,
	reply: Reply
}

sig UserConfirmation{
	violationReport : ViolationReport,
	reply:Reply,
}

sig RequestMTS{
	violationReport:ViolationReport,
	reply:Reply,
}

sig AccidentUpdate{
	municipality:Municipality,
	newAccidents:set Accident,
}

fact differentViolationsDifferentPictures{
	no disj v1,v2 :ViolationReport| v1.picture = v2.picture
}

fact differentRequestOCRDifferentVIolations{
	no disj r1,r2:RequestOCR |  r1.violationReport = r2.violationReport
}

fact allViolationsHasRequestOCR{
	all v:ViolationReport | one r:RequestOCR | v = r.violationReport 
}

fact notEmptyAndPositive
{
	no v:ViolationReport, r:RequestOCR | (v.licensePlate = none) and (r.violationReport = v )and ( r.reply = POSITIVE_REPLY )
}

fact notFullAndNegative{
		no v:ViolationReport, r:RequestOCR | (v.licensePlate != none) and (r.violationReport = v )and ( r.reply = NEGATIVE_REPLY )
}

fact noNegativeNGOOD{
	no r:RequestOCR | r.reply = NEGATIVE_REPLY and r.violationReport.picture.quality = GOOD_QUALITY
}

fact noPositiveNBAD{
	no r:RequestOCR | r.reply = POSITIVE_REPLY and r.violationReport.picture.quality = BAD_QUALITY
}

fact noConfirmationSameReport{
	no disj c1,c2:UserConfirmation | c1.violationReport = c2.violationReport
}

fact noConfirmationWithoutPlate{
	no c:UserConfirmation, v:ViolationReport | v.licensePlate = none and v = c.violationReport 
}

fact allPlatesHasConfirmation{
	all v:ViolationReport |
			(v.licensePlate != none ) implies 
					one c:UserConfirmation | v = c.violationReport
}

fact storedViolations{
	all v:ViolationReport |
		v in SafeReports.storedViolationReports iff 
			one c:UserConfirmation | c.reply = POSITIVE_REPLY and c.violationReport = v
}

fact noEquivalentViolation{
	no disj v1,v2:ViolationReport | 
		v1 in SafeReports.storedViolationReports and  v2 in SafeReports.storedViolationReports and
		equivalence[v1,v2]
}

// MTS part 

fact differentMTSDifferentViolation{
	no disj r1,r2:RequestMTS | r1.violationReport = r2.violationReport
}

fact allMTSinSafeReports{
	all r:RequestMTS | r.violationReport in SafeReports.storedViolationReports
}

fact allStoredVIolationMustHaveMTS
{
	all v:ViolationReport |
		v in SafeReports.storedViolationReports implies 
			one r:RequestMTS |
				v = r.violationReport 
}

fact disjointTickets
{
	no disj t1,t2:Ticket | t1.violationReport = t2.violationReport 
}

fact ticketsStoredIfPositiveMTS
{
	all t:Ticket |
		one r:RequestMTS |
			t.violationReport = r.violationReport and r.reply = POSITIVE_REPLY
}

fact ifPositiveMTSthenTicket
{
	all r:RequestMTS |
		r.reply = POSITIVE_REPLY implies
			one t:Ticket |
				t.violationReport = r.violationReport 
}

fact allTicketsAreStoredInSafeTickets
{
	all t:Ticket |
		t in SafeTickets.storedTickets
}

//SAFESUGGESTION

fact allSuggestionsInSafeSuggestions{
	all s:Suggestion |
		s in SafeSuggestions.storedSuggestions
}

fact allSuggestionsAreDifferent{
	no disj s1,s2 :Suggestion | s1.position = s2.position and s1.suggestionType = s2.suggestionType
}

/*The probabily of our internal algorithm to generate suggestions in a position is more than 0
if there is at least one violation or accident in that position*/

fact suggestionsExistIfOnlyAccidentInThatPosition
{
	all s:Suggestion |
		( some v:ViolationReport |
			s.position = v.position  and v in SafeReports.storedViolationReports ) 		
		or 
		( some a:Accident |
			s.position = a.position )
}

//ACCIDENTS
fact noSameAccidents{
	no disj a1,a2:Accident | sameAccident[a1,a2]
}

fact allAccidentsAreStored
{
	all a:Accident | a in SafeStreets.storedAccidents
}

fact allAccidentsHaveAccidentUpdate
{
	all a:Accident | 
		one  au:AccidentUpdate | 
			a in au.newAccidents
}

fact allAccidentUpdateAreStored{
	all au:AccidentUpdate |
		au.newAccidents in SafeStreets.storedAccidents
}

fact allAccidentUpdateHaveSomeAccidents
{
	all au:AccidentUpdate |
		au.newAccidents != none 
}

//PRED

pred equivalence[ v1,v2 : ViolationReport ]
{
	 samePlate[v1,v2] and samePosition[v1,v2] and sameTimestamp[v1,v2] and sameViolationType[v1,v2]
}

//The define of the integer must be changed
pred samePosition[v1,v2:ViolationReport]
{
	v1.position - v2.position < 2 or  v2.position -  v1.position < 2
}

pred sameTimestamp[v1,v2:ViolationReport]
{
	v1.timestamp - v2.timestamp < 2 or v2.timestamp - v1.timestamp < 2
}

pred samePlate[v1,v2:ViolationReport]
{
	v1.licensePlate != none and v1.licensePlate = v2.licensePlate
}

pred sameViolationType[v1,v2:ViolationReport]
{
	v1.violationType = v2.violationType
}

pred sameAccident[a1,a2:Accident]
{
	a1.position = a2.position and a1.timestamp = a2.timestamp and a1.accidentType = a2.accidentType
}

/******************************************************************************/

sig AnonymousViolationReport {
	relatedTo: one ViolationReport
}

abstract sig Filter {}

sig PositionFilter extends Filter {
	position: one Int,
	range: one Int
} {
	range > 0
}

sig TimeFilter extends Filter{
	time: one Int,
	range: one Int
} {
	range > 0
}

sig ReportFilter extends Filter {
	positionFilter: lone PositionFilter,
	timeFilter: lone TimeFilter,
	violationTypeFilter: lone ViolationType
} {
	(some positionFilter) or
	(some timeFilter) or
	(some violationTypeFilter)
}

sig SuperReportFilter extends Filter {
	positionFilter: lone PositionFilter,
	timeFilter: lone TimeFilter,
	violationTypeFilter: lone ViolationType,
	licensePlate: lone LicensePlate
} {
	(some positionFilter) or
	(some timeFilter) or
	(some violationTypeFilter) or
	(some licensePlate)
}

sig TicketFilter extends Filter {
	id: lone Int,
	licensePlate: lone LicensePlate,
	violation: lone ViolationType
} {
	(some id implies id > 0) and
		( (some id) or
		(some licensePlate) or
		(some violation) )
}

sig SuggestionPositionFilter extends Filter{
	position: one Int,
	range: one Int
} {
	range > 0
}

sig SuggestionFilter extends Filter {
	positionFilter: lone SuggestionPositionFilter,
	violationFilter: lone ViolationType,
	accidentFilter: lone AccidentType
} {
	(some positionFilter) or
	(some violationFilter) or
	(some accidentFilter)
}

abstract sig QueryReply {}

sig ReportReply extends QueryReply {
	violation: set AnonymousViolationReport
}

sig SuperReportReply extends QueryReply {
	violation: set ViolationReport
}

sig TicketReply extends QueryReply {
	ticket: set Ticket
}

sig SuggestionReply extends QueryReply {
	suggestion: set Suggestion
}

abstract sig Query {}

sig ReportQuery extends Query {
	filter: one ReportFilter,
	reply: one ReportReply,
	madeBy: one CommonUser
}

sig SuperReportQuery extends Query {
	filter: one SuperReportFilter,
	reply: one SuperReportReply,
	madeBy: one Authority
}

sig TicketQuery extends Query{
	filter: one TicketFilter,
	reply: one TicketReply,
	madeBy: one Authority
}

sig SuggestionQuery extends Query {
	filter: one SuggestionFilter,
	reply: one SuggestionReply,
	madeBy: one MunicipalityUser
}

// This fact ensured that no AnonymousViolationReport exists alone
fact NoUnrelatedAnonymousViolationReport {
	all v: AnonymousViolationReport |
		some r: ReportReply | v in r.violation
}

// This fact ensures that no PositionFilter or TimeFilter exists alone
fact NoUnrelatedSubFilters {
	( all p: PositionFilter |
		( some sf: SuperReportFilter | sf.positionFilter = p ) or ( some f: ReportFilter | f.positionFilter = p ) )
	and
	( all t: TimeFilter |
		( some sf: SuperReportFilter | sf.timeFilter = t ) or ( some f: ReportFilter | f.timeFilter = t ) )
}

// This fact ensures that no ReportFilter or SuperReportFilter exists alone
fact NoUnrelatedFilters {
	( all f: ReportFilter |
		some q: ReportQuery | q.filter = f )
	and
	( all sf: SuperReportFilter |
		some sq: SuperReportQuery | sq.filter = sf )
}

// This fact ensures that no TicketFilter exists alone
fact NoUnrelatedTicketFilter {
	all f: TicketFilter |
		some q: TicketQuery | q.filter = f
}

// This fact ensures that no SuggestionFilter exists alone
fact NoUnrelatedSuggestionFilter {
	all f: SuggestionFilter |
		some q: SuggestionQuery | q.filter = f
}

// This fact ensures that no ReportReply or SuperReportReply exists alone
fact NoUnrelatedReplies {
	( all r: ReportReply |
		some q: ReportQuery | q.reply = r )
	and
	( all sr: SuperReportReply |
		some sq: SuperReportQuery | sq.reply = sr )
}

// This fact ensures that no TicketReply exists alone
fact NoUnrelatedTicketReply {
	all r: TicketReply |
		some q: TicketQuery | q.reply = r
}

// This fact ensures that no SuggestionReply exists alone
fact NoUnrelatedSuggestionReply {
	all r: SuggestionReply |
		some q: SuggestionQuery | q.reply = r
}

pred PositionFilterSatisfaction[f: PositionFilter, p:Int] {
	p < f.position + f.range and p > f.position - f.range
}

pred TimeFilterSatisfaction[f: TimeFilter, t: Int] {
	t < f.time + f.range and t > f.time - f.range
}

pred ViolationTypeFilterSatisfaction[f: ViolationType, t: ViolationType] {
	f = t
}

pred LicensePlateFilterSatisfaction[f: LicensePlate, t: LicensePlate] {
	f = t
}

// This fact ensures that replies to a ReportQuery are coherent with the filters
fact RepliesSatisfyFilters {
	all q: ReportQuery |
		all r: ReportReply |
			all v: AnonymousViolationReport |
				(v in r.violation and r = q.reply) implies
					( PositionFilterSatisfaction[q.filter.positionFilter,v.relatedTo.position] and
					TimeFilterSatisfaction[q.filter.timeFilter,v.relatedTo.timestamp] and
					ViolationTypeFilterSatisfaction[q.filter.violationTypeFilter,v.relatedTo.violationType] )
}

// This fact ensures that replies to a SuperReportQuery are coherent with the filters
fact SuperRepliesSatisfyFilters {
	all q: SuperReportQuery |
		all r: SuperReportReply |
			all v: ViolationReport |
				(v in r.violation and r = q.reply) implies
					( PositionFilterSatisfaction[q.filter.positionFilter,v.position] and
					TimeFilterSatisfaction[q.filter.timeFilter,v.timestamp] and
					ViolationTypeFilterSatisfaction[q.filter.violationTypeFilter,v.violationType] and
					LicensePlateFilterSatisfaction[q.filter.licensePlate,v.licensePlate] )
}

pred TicketFilterSatisfaction[f: TicketFilter, i: Ticket] {
	( (some f.id) implies (f.id = i.id) ) and
	( (some f.licensePlate) implies (f.licensePlate = i.violationReport.licensePlate) ) and
	( (some f.violation) implies (f.violation = i.violationReport.violationType) )
}

// This fact ensures that replies to a TicketQuery are coherent with the filters
fact TicketRepliesSatisfyFilters {
	all q: TicketQuery |
		all r: TicketReply |
			all i: Ticket |
				(i in r.ticket and r = q.reply) implies TicketFilterSatisfaction[q.filter, i]
}

pred SuggestionFilterSatisfaction[f: SuggestionFilter, i: Suggestion] {
	(some f.positionFilter) implies
		( i.position < f.positionFilter.position + f.positionFilter.range and 
		i.position > f.positionFilter.position - f.positionFilter.range ) and
	(some f.violationFilter) implies (i.violation = f.violationFilter) and
	(some f.accidentFilter) implies (i.accident = f.accidentFilter)
}

// This fact ensures that replies to a SuggestionQuery are coherent with the filters
fact SuggestionRepliesSatisfyFilters {
	all q: SuggestionQuery |
		all r: SuggestionReply |
			all s: Suggestion |
				(s in r.suggestion and r = q.reply) implies SuggestionFilterSatisfaction [q.filter, s]
}

//TODO Review the following facts

/* // This fact ensures that no picture exists alone
fact NoUnrelatedPictures {
	all p: Picture |
		some v: ViolationReport | v.picture = p
}

// This fact ensures that reports have license plate if and only if the quality of the picture is good
fact OnlyGoodPicturesHaveLicensePlate {
	all v: ViolationReport | ( v.picture.quality = BAD_QUALITY ) iff ( no v.licensePlate )
}

// This fact ensures that reports in replies are always good quality reports
fact OnlyGoodReportsInReplies {
	( all r: ReportReply |
		no p: Picture | (p in r.violation.relatedTo.picture) and (p.quality = BAD_QUALITY) )
	and
	( all sr: SuperReportReply |
		no p: Picture | (p in sr.violation.picture) and (p.quality = BAD_QUALITY) )
} */

/******************************************************************************/

// This is the minimum show predicate. It is used as reference to list all the cardinalities that can be restricted
pred show {
	#ViolationType = 0
	#AccidentType = 0
	#SuggestionType = 0
	#LicensePlate = 0
	#Picture = 0
	#ViolationReport = 0
	#Accident = 0
	#Ticket = 0
	#Suggestion = 0

	#RequestOCR = 0
	#UserConfirmation = 0
	#RequestMTS = 0
	#AccidentUpdate = 0

	#AnonymousViolationReport = 0
	#PositionFilter = 0
	#TimeFilter = 0
	#ReportFilter = 0
	#SuperReportFilter = 0
	#TicketFilter = 0
	#SuggestionPositionFilter = 0
	#SuggestionFilter = 0
	#ReportReply = 0
	#SuperReportReply = 0
	#TicketReply = 0
	#SuggestionReply = 0
	#ReportQuery = 0
	#SuperReportQuery = 0
	#TicketQuery = 0
	#SuggestionQuery = 0
}

run show

pred showReportQuery {
	//TODO Conditions
}

// run showReportQuery for 3

pred showSuperReportQuery {
	//TODO Conditions
}

// run showSuperReportQuery for 3

pred showTicketQuery {
	//TODO Conditions
}

// run showTicketQuery for 3

pred showSuggestionQuery {
	//TODO Conditions
}

//run showSuggestionQuery for 3
