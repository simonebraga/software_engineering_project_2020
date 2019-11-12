pred acceptedViolations {
	#ViolationType = 2
	#AccidentType = 0
	#SuggestionType = 0
	#LicensePlate = 2
	#Picture = 2
	#ViolationReport = 2
	#Accident = 0
	#Ticket = 0
	#Suggestion = 0
	#RequestOCR = 2
	#UserConfirmation = 2
	#RequestMTS = 2
	#AccidentUpdate = 0
	#ReportQuery = 0
	#SuperReportQuery = 0
	#TicketQuery = 0
	#SuggestionQuery = 0
	#Authority = 0
	#MunicipalityUser = 0
	#CommonUser = 2
	no disj v1,v2:ViolationReport | v1.licensePlate = v2.licensePlate
}

run acceptedViolations for 4 but exactly 3 String
