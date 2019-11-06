//Check the equivalence between reports
//How to represent the relationship between a user and the sends reports to the service 
//What does it mean seq 

abstract sig User{
	email:Email,
	password:Password,
}

//2 different user must have different emails 
fact noUsersWithSameEmail{
	no disj u1,u2 : User | u1.email = u2.email
}

//To expand and change in string 
sig Email{}
sig Password{}

//I could use the relationship with the photo only
sig CommonUser extends User{
	//sendReport : set ViolationReport->SafeReports
}

sig Authority extends User{}
sig MunicipalityUser extends User{}

sig ViolationReport {
	picture:Picture,
	licensePlate: lone LicensePlate,
	violationType: ViolationType,
	postition:Position,
	timestamp: TimeStamp,
	//reportStatus : Status,  Could be useful later
	author: CommonUser  //This is the creates relationship. Could be deleted 
}

//What about the case in which we have a photo with multiple violations?.NO we only can choose one violation type per picture
fact differentPictureDifferentViolations{
	no disj v1,v2:ViolationReport | v1.picture = v2.picture
}

//The plate is present only if it was read by the OCR. Maybe uncorrect
fact hasPlateIfOCRReadIt{
	all v:ViolationReport | one ocr:RequestOCR | (ocr.picture = v.picture and ocr.reply = PositiveReply) iff v.licensePlate != none
}

fact noEquivalenceViolation{
	no disj v1,v2:ViolationReport | v1.licensePlate = v2.licensePlate and 
	v1.violationType = v2.violationType // samePosition(v1.position, v2.position) and sameDate(v1.timestamp,v2.timestamp)

}

sig Picture{
	quality : Int //Quality is a number that represents the quality of a picture with a range 0-10
}
fact noPictureWithoutViolation{
	all p:Picture | one v:ViolationReport | p in v.picture
}

sig LicensePlate{}
sig ViolationType{}
sig Position{
	//coordinate : Int //In the final release it has long and lat coordinates
}
sig TimeStamp{
	//time : Int //In the final release it has different parameters : day, month ,year, hour ecc..
}

/*If the OCR hasn't read the plate then the violation is still waiting for confirmation
fact noConfirmedStatusWithoutLicensePlate{
	all v:ViolationReport | #(v.licensePlate) = 0 implies v.reportStatus = PENDING
}*/

/*
abstract sig Status {}

one sig CONFIRMED extends Status{}
one sig PENDING extends Status{}*/

// Components for the confirmation of the user to a read report 

//There are no refuse warning that are not associated with the refuseWarnings set in SafeReport

abstract sig AbstractRequest{
	author : SafeReports,
	reply: RequestReply
}

fact allRequestsHaveAReply{
	all r:AbstractRequest | one rep:RequestReply | r.reply = rep
}

sig Request extends AbstractRequest{
	receiver : CommonUser,
	violation : ViolationReport,
}
fact requestHaveDifferentViolations{
	no disj r1,r2:Request | r1.violation = r2.violation
}


fact allViolationsHaveARequest{
	//all v:ViolationReport | v.licensePlate != none implies ( one r:Request | v in r.violation ) 
	all vr:ViolationReport | one r:Request | vr = r.violation and vr.author = r.receiver 
}

sig RequestOCR extends AbstractRequest{
	receiver : OCR,
	picture : Picture,
}
fact requestOCRHaveDifferentPictures{
	no disj r1,r2:RequestOCR | r1.picture = r2.picture
}
//OCR sends the result if the the picture is readable ( has good quality )
fact OCRService{
	all rq:RequestOCR | rq.picture.quality >= 0 iff rq.reply = PositiveReply
}
fact everyViolationHasARequestOCR{
	all p:Picture | one ocr:RequestOCR | p = ocr.picture
}

one sig OCR{}

abstract sig RequestReply{}

one sig PositiveReply extends RequestReply{}
one sig NegativeReply extends RequestReply{}

//TODO remeber to say that a request reply unique relationship

//-------------------END components for confirmation

abstract sig Service{}

one sig SafeReports{
	storedReports : set ViolationReport
}

//We store if ocr read it and user confirmed it

fact onlyValideAndConfirmedReportsAreStored{
	all v:ViolationReport | v in SafeReports.storedReports iff v.licensePlate != none and 
	(one r:Request | v = r.violation and r.reply = PositiveReply )
}

/*
//This is going to change
fact allPositiveRepliesAreStored{
	all v:ViolationReport |( one r:Request, positiveReply:PositiveReply | v = r.violation and positiveReply in r.reply )
	implies v in SafeReports.storedReports 
}*/


one sig SafeTickets{}
one sig SafeAnalytics{}
one sig SafeSuggestions{}

/*Check if the the violation
assert prova {
	no v:ViolationReport | #(v.licensePlate) = 0 and v.reportStatus = CONFIRMED
}*/

pred random{
	#ViolationReport = 1
}

run random 

assert requestForSameViolation{
	no disj r1,r2:Request | r1.violation = r2.violation
}

check requestForSameViolation




