pred noConfirmation {
	#AccidentType = 0
	#SuggestionType = 0
	#LicensePlate = 1
	#Picture = 2
	#ViolationReport = 2
	#Accident = 0
	#Ticket = 0
	#Suggestion = 0
	#RequestOCR = 2
	#UserConfirmation = 1
	#RequestMTS = 0
	#AccidentUpdate = 0
	#ReportQuery = 0
	#SuperReportQuery = 0
	#TicketQuery = 0
	#SuggestionQuery = 0
	#Authority = 0
	#MunicipalityUser = 0
	#CommonUser = 2
	(one disj v1,v2:ViolationReport | v1.position = 1 and v2.position = 2) and
	one u:UserConfirmation | u.reply = NEGATIVE_REPLY
}

run noConfirmation for 3 but exactly 4 String
