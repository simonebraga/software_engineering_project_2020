pred showReportQuery {
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
	#AnonymousViolationReport = 1
	#ReportFilter = 1
	#ReportReply = 1
	#ReportQuery = 1
	#SuperReportQuery = 0
	#TicketQuery = 0
	#SuggestionQuery = 0
	#Authority = 0
	#MunicipalityUser = 0
	#SafeReports.storedViolationReports = 2
	#ReportReply.violation > 0
}

run showReportQuery for 3 but exactly 2 String
