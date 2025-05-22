#BI & Data Analysis
s -> biandDataAnalysis.analyticsWeb "Queries data using"
s -> biandDataAnalysis "Analyses screening data using"
biandDataAnalysis.analyticsWeb -> biandDataAnalysis.participantManagerDb "Reads data from"
biandDataAnalysis.analyticsWeb -> biandDataAnalysis.businessAuditDb "Reads data from"
