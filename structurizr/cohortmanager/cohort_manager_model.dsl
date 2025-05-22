    cm = softwareSystem "Cohort Manager" {
        !docs docs
        caasIntegration = container "CaaS Integration Service" {
            tags "microService"
            technology "Azure functions written in C#"
            retrieveMeshFile = component "RetrieveMESHFile"
            ReceiveCaaSFile = component "ReceiveCaasFile"
        }
        addQueue = container "AddParticipantQueue" {
            tags "queue"
        }
        cohortQueue = container "CohortDistributionQueue" {
            tags "queue"
        }
        updateQueue = container "UpdateParticipantQueue" {
            tags "queue"
        }
        participantManagement = container "Participant Management Service" {
            tags "microService"

            addParticipant = component "AddParticipant"
            updateParticipant = component "UpdateParticipant"
            removeParticipant = component "RemoveParticipant"
            blockParticipant = component "BlockParticipant"
            deleteParticipant = component "DeleteParticipant"
        }
        demographicServices = container "Demographic Services" {
            tags "microService"

            demographicDurable = component "DemographicDurableFunction"
            demographicData = component "DemographicDataFunction"
            NEMSSub = component "NEMSSubscribe"
            NEMSUnsub = component "NEMSUnsubscribe"
            pdsGet = component "GetPDSDemographic"
        }

        screeningData = container "ScreeningDataService" {
            tags "microService"

            createParticipant = component "CreateParticipant"
            updateParticipantDetails = component "UpdateParticipantDetails"
            markEligible = component "MarkParticipantAsEligible"
            markIneligible = component "MarkParticipantAsInEligible"

            participantManagementService = component "ParticipantManagementDataService" {
                tag "dataService"
            }
            demographicDataService = component "DemographicDataService" {
                tag "dataService"
            }
            exceptionManagement = component "ExceptionManagementDataService" {
                tag "dataService"
            }
            getValidationExceptions = component "GetValidationExceptions" 
        }

        cohortDistribution = container "Cohort Distribution Service" {
            tags "microService"

            createCohort = component "CreateCohort"
            serviceProvider = component "ServiceProviderAllocation"
            validateCohort = component "ValidateCohortDistributionData"
            transform = component "Transformations"
            addCohort = component "AddCohortDistributionData"
        }

        snowIntegration = container "ServiceNowIntegration" {
            tags "microService"

            receiveMessage = component "ReceiveSnowMessage"
            sendMessage = component "SendSnowMessage"
        }

        screeningValidation = container "ScreeningValidationService" {
            tags "microService"

            staticValidation = component "StaticValidation"
            lookupValidation = component "LookupValidation"
            removeException = component "RemoveException"
        }

        NEMSIntegration = container "NEMSIntegration" {
            tags "microService"
        }

        exceptionWA = container "Exception UI" {
            tags "webapp"
        }


        // Database and storage
        blobCaaS = container "CaaS File blob storage" {
            tags "Database"
        }
        blobNems = container "NEMS File blob storage" {
            tags "Database"
        }
        blobBadFile = container "Failed file blob storage" {
            tags "Database"
        }
        databaseParticipantManagement = container "Participant Management table" {
            tags "Database"
        }
        databaseDemographic = container "Demographics Table" {
            tags "Database"
        }
        databaseCohortDistribution = container "Cohort Distribution Table" {
            tags "Database"
        }
        databaseScreenLkp = container "Screening ID lookup" {
            tags "Database"
        }
        databaseBSSAudit = container "BSS Request Audit" {
            tags "Database"
        }
        databaseCurrentPosting = container "Current Posting Lookup" {
            tags "Database"
        }
        databaseLanguageCodes = container "Language Codes Lookup" {
            tags "Database"
        }
        databaseGPPractices = container "GP Practices" {
            tags "Database"
        }
        databaseSMULookup = container "Excluded SMU Lookup" {
            tags "Database"
            technology "SQL Table"
        }
        databaseBSSOutcode = container "BSS Outcode Mapping Lookup"{
            tags "Database"
        }
    }