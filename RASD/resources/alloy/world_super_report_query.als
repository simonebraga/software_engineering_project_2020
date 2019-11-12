pred showSuperReportQuery {
	#ViolationType = 2
	#AccidentType = 0
	#SuggestionType = 0
	#LicensePlate = 2
	#Picture = 2
	#ViolationReport = 2
	#Accident = 0
	#Ticket = 0
	#Suggestion = 0
	#AccidentUpdate = 0
	#SuperReportFilter = 1
	#SuperReportReply = 1
	#ReportQuery = 0
	#SuperReportQuery = 1
	#TicketQuery = 0
	#SuggestionQuery = 0
	#MunicipalityUser = 0
	#SafeReports.storedViolationReports = 2
	#SuperReportReply.violation > 0
}

run showSuperReportQuery for 3 but exactly 4 String
