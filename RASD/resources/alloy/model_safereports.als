sig ViolationReport {
	picture:Picture,
	licensePlate: lone LicensePlate,
	violationType:ViolationType,
	creator:CommonUser,
	position:Int,
	timestamp:Int,
}

one sig SafeReports{
	storedViolationReports : set ViolationReport
}

sig Picture {
	quality:Quality
}

sig CommonUser{}

sig LicensePlate{}

abstract sig Quality{}
one sig GOOD extends Quality{}
one sig BAD extends Quality{}

//Represents the request for the OCR
sig RequestOCR{
	violationReport:ViolationReport,
	reply: Reply
}

abstract sig Reply{}
one sig POSITIVE_REPLY extends Reply{}
one sig NEGATIVE_REPLY extends Reply{}

sig UserConfirmation{
	violationReport : ViolationReport,
	reply:Reply,
}

sig ViolationType{}

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
	no r:RequestOCR | r.reply = NEGATIVE_REPLY and r.violationReport.picture.quality = GOOD
}

fact noPositiveNBAD{
	no r:RequestOCR | r.reply = POSITIVE_REPLY and r.violationReport.picture.quality = BAD
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



pred a{
	c and
	some disj v1,v2,v3:ViolationReport | 
		v1.picture.quality = GOOD and v2.picture.quality = GOOD and v3.picture.quality = GOOD 
}

pred c{
	 all c:UserConfirmation | c.reply = POSITIVE_REPLY
}

pred d{
	one v:ViolationReport | v.picture.quality = GOOD 
}

pred b{
	#ViolationReport = 2
}

run a
