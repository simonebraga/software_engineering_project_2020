abstract sig Quality {}
one sig GoodQuality extends Quality {}
one sig BadQuality extends Quality {}

sig Picture{
	quality: Quality
}

sig LicensePlate {}

sig ViolationType {}

// This is the complete report stored by SafeReports
sig ViolationReport {
	picture: Picture,
	licensePlate: lone LicensePlate,
	violationType: ViolationType,
	position: Int,
	timestamp: Int
}

// This is the anonymous report sent to common users
sig AnonymousViolationReport {
	violationType: ViolationType,
	position: Int,
	timestamp: Int
}

// This fact ensures that every anonymous report is generated from an existing complete report
fact AnonymousViolationReportsAlwaysReferredToStoredReports {
	all a: AnonymousViolationReport |
		some v: ViolationReport |
			v.violationType = a.violationType and
			v.position = a.position and
			v.timestamp = a.timestamp
			// v stored in safestreets
}

// No good quality without license plate
// No license plate with bad quality

// The position interval is determined by a central point and a range
sig PositionFilter {
	position: Int,
	range: Int
} {
	all p: PositionFilter |
		some f: Filter | f.positionFilter = p
}

// The time interval is determined by a certain time and a range
sig TimeFilter {
	time: Int,
	range: Int
} {
	all t: TimeFilter |
		some f:Filter | f.timeFilter = t
}

// This is the filter of the queries accessible to common users
sig Filter {
	positionFilter: PositionFilter,
	timeFilter: TimeFilter,
	violationTypeFilter: ViolationType
}

// This is the filter of the queries accessible to authorities
sig SuperFilter extends Filter {
	licensePlate: LicensePlate
}

// This is a set of anonymous violation reports sent to common users after a query
sig Reply {
	violation : set AnonymousViolationReport
} {
	no r: Reply |
		no q: Query | q.reply = r
}

// This is a set of violation reports sent to authorites after a query
sig SuperReply {
	violation : set ViolationReport
} {
	no r: SuperReply |
		no q: SuperQuery | q.reply = r
}

// This is the query that common users can make
sig Query {
	filter: Filter,
	reply: Reply
}

// This is the query that authorities can make
sig SuperQuery {
	filter: SuperFilter,
	reply: SuperReply
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

// This fact ensures that replies to a query are coherent with the selected filters
fact RepliesSatisfyFilters {
	all q: Query |
		all r: Reply |
			all v: AnonymousViolationReport |
				(v in r.violation and r = q.reply) implies
					( PositionFilterSatisfaction[q.filter.positionFilter,v.position] and
					TimeFilterSatisfaction[q.filter.timeFilter,v.timestamp] and
					ViolationTypeFilterSatisfaction[q.filter.violationTypeFilter,v.violationType] )
}

fact RepliesSatisfyFilters {
	all q: SuperQuery |
		all r: SuperReply |
			all v: ViolationReport |
				(v in r.violation and r = q.reply) implies
					( PositionFilterSatisfaction[q.filter.positionFilter,v.position] and
					TimeFilterSatisfaction[q.filter.timeFilter,v.timestamp] and
					ViolationTypeFilterSatisfaction[q.filter.violationTypeFilter,v.violationType] and
					LicensePlateFilterSatisfaction[q.filter.licensePlate,v.licensePlate] )
}

pred showQuery {
	#SuperQuery = 0
}

//run showQuery

pred showSuperQuery {
	#Query = 0
}

run showSuperQuery
