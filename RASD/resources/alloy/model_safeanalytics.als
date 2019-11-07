/***********************************************************************/

abstract sig Quality {}
one sig GoodQuality extends Quality {}
one sig BadQuality extends Quality {}

sig Picture{
	quality: one Quality
}

sig LicensePlate {}

sig ViolationType {}

sig ViolationReport {
	picture: one Picture,
	licensePlate: lone LicensePlate,
	violationType: one ViolationType,
	position: one Int,
	timestamp: one Int
}

sig AnonymousViolationReport {
	relatedTo: one ViolationReport
}

sig PositionFilter {
	position: one Int,
	range: one Int
}

sig TimeFilter {
	time: one Int,
	range: one Int
}

sig Filter {
	positionFilter: lone PositionFilter,
	timeFilter: lone TimeFilter,
	violationTypeFilter: lone ViolationType
} {
	(some positionFilter) or
	(some timeFilter) or
	(some violationTypeFilter)
}

sig SuperFilter {
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

sig Reply {
	violation: set AnonymousViolationReport
}

sig SuperReply {
	violation: set ViolationReport
}

sig Query {
	filter: one Filter,
	reply: one Reply
}

sig SuperQuery {
	filter: one SuperFilter,
	reply: one SuperReply
}

/***********************************************************************/

// This fact ensures that reports have license plate if and only if the quality of the picture is good
fact OnlyGoodPicturesHaveLicensePlate {
	all v: ViolationReport | ( v.picture.quality = BadQuality ) iff ( no v.licensePlate )
}

// This fact ensures that reports in replies are always good quality reports
fact OnlyGoodReportsInReplies {
	( all r: Reply |
		no p: Picture | (p in r.violation.relatedTo.picture) and (p.quality = BadQuality) )
	and
	( all sr: SuperReply |
		no p: Picture | (p in sr.violation.picture) and (p.quality = BadQuality) )
}

// This fact ensures that no position or time filter exists alone
fact NoUnrelatedSubFilters {
	( all p: PositionFilter |
		( some sf: SuperFilter | sf.positionFilter = p ) or ( some f: Filter | f.positionFilter = p ) )
	and
	( all t: TimeFilter |
		( some sf: SuperFilter | sf.timeFilter = t ) or ( some f: Filter | f.timeFilter = t ) )
}

// This fact ensures that no filter exists alone
fact NoUnrelatedFilters {
	( all f: Filter |
		some q: Query | q.filter = f )
	and
	( all sf: SuperFilter |
		some sq: SuperQuery | sq.filter = sf )
}

// This fact ensures that no reply exists alone
fact NoUnrelatedReplies {
	( all r: Reply |
		some q: Query | q.reply = r )
	and
	( all sr: SuperReply |
		some sq: SuperQuery | sq.reply = sr )
}

// This fact ensured that no anonymous violation report is generated alone
fact NoUnrelatedAnonymousViolationReport {
	all v: AnonymousViolationReport |
		some r: Reply | v in r.violation
}

/***********************************************************************/

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

// This fact ensures that replies to a query are coherent with the selected filters
fact RepliesSatisfyFilters {
	all q: Query |
		all r: Reply |
			all v: AnonymousViolationReport |
				(v in r.violation and r = q.reply) implies
					( PositionFilterSatisfaction[q.filter.positionFilter,v.relatedTo.position] and
					TimeFilterSatisfaction[q.filter.timeFilter,v.relatedTo.timestamp] and
					ViolationTypeFilterSatisfaction[q.filter.violationTypeFilter,v.relatedTo.violationType] )
}

// This fact ensures that replies to a super query are coherent with the selected filters
fact SuperRepliesSatisfyFilters {
	all q: SuperQuery |
		all r: SuperReply |
			all v: ViolationReport |
				(v in r.violation and r = q.reply) implies
					( PositionFilterSatisfaction[q.filter.positionFilter,v.position] and
					TimeFilterSatisfaction[q.filter.timeFilter,v.timestamp] and
					ViolationTypeFilterSatisfaction[q.filter.violationTypeFilter,v.violationType] and
					LicensePlateFilterSatisfaction[q.filter.licensePlate,v.licensePlate] )
}

/***********************************************************************/

pred showQuery {
	no v: ViolationReport | v.picture.quality = BadQuality
	#SuperQuery = 0
}

// run showQuery for 2

pred showSuperQuery {
	no v: ViolationReport | v.picture.quality = BadQuality
	#Query = 0
}

// run showSuperQuery for 2
