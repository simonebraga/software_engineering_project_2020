pred showTicketQuery {
	#ViolationType = 2
	#AccidentType = 0
	#SuggestionType = 0
	#LicensePlate = 2
	#Picture = 2
	#ViolationReport = 2
	#Accident = 0
	#Ticket = 1
	#Suggestion = 0
	#AccidentUpdate = 0
	#TicketFilter = 1
	#TicketReply = 1
	#ReportQuery = 0
	#SuperReportQuery = 0
	#TicketQuery = 1
	#SuggestionQuery = 0
	#MunicipalityUser = 0
	#SafeReports.storedViolationReports = 2
	#TicketReply.ticket > 0
}

run showTicketQuery  for 3 but exactly 4 String
