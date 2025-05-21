#BI & Data Analysis
s -> biandDataAnalysis.biandDataAnalysis_analytics "Queries data using"
s -> biandDataAnalysis "Analyses screening data using"
biandDataAnalysis.biandDataAnalysis_analytics -> biandDataAnalysis.biandDataAnalysis_participantManager "Reads data from"
biandDataAnalysis.biandDataAnalysis_analytics -> biandDataAnalysis.biandDataAnalysis_businessAudit "Reads data from"
