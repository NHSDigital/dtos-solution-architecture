        biandDataAnalysis = softwareSystem "BI and Data Analysis" "Service for analysing Screening data"{
            !docs docs
            biandDataAnalysis_analytics = container "Web interface for running queries" "Web portal used to access analysis and queries" "Web App" "Web Browser"
            biandDataAnalysis_participantManager = container "Read replica of participant database" "Copy of participant dataset containing episode information" "Database" "Database"
            biandDataAnalysis_businessAudit = container "Read replica of audit database" "Copy of audit database for analytics purposes" "Database" "Database"
        }