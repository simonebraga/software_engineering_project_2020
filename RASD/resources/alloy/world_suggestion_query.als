pred showSuggestionQuery {
	#Suggestion = 3
	#SuggestionFilter = 1
	#SuggestionReply = 1
	#ReportQuery = 0
	#SuperReportQuery = 0
	#TicketQuery = 0
	#SuggestionQuery = 1
	#CommonUser = 0
	#Authority = 0
	#SuggestionReply.suggestion > 0
}

run showSuggestionQuery  for 3 but exactly 3 String
