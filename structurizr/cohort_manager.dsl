workspace "Cohort Manager" "Description" {

    !identifiers hierarchical

    model {
        cm = softwareSystem "Cohort Manager" {
            caasIntegration = container "CaaS Integration Service" {
                tags "microService"

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

                demographicDurable = component "demographicDurableFunction"
                demographicData = component "demographicDataFunction"
                NEMSSub = component "NEMSSubscribe"
                NEMSUnsub = component "NEMSUnsubscribe"
                pdsGet = component "GetPDSDemographic"
            }

            screeningData = container "ScreeningDataService" {
                tags "microService"

                createParticipant = component "createParticipant"
                updateParticipantDetails = component "updateParticipantDetails"
                markEligible = component "MarkParticipantAsEligible"
                markIneligible = component "MarkParticipantAsInEligible"

                participantManagementService = component "participantManagementDataService" {
                    tag "dataService"
                }
                demographicDataService = component "demographicDataService" {
                    tag "dataService"
                }
                exceptionManagement = component "exceptionManagementDataService" {
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

        // Users
        admin = person "Admin"
        nsd = person "National Service Desk"

        // External Systems
        bss = softwareSystem "BS Select" {
            tags "externalSystem"
        }
        snow = softwareSystem "Service Now" {
            tags "externalSystem"
        }
        pds = softwareSystem "PDS FHIR API" {
            tags "externalSystem"
        }
        nems = softwareSystem "NEMS" {
            tags "externalSystem"
        }
        nemssub = softwareSystem "NEMS subscription service" {
            tags "externalSystem"
        }
        caas = softwareSystem "CaaS" {
            tags "externalSystem"
        }
        //MESH boxes
        caasMESH = softwareSystem "CaaS MESH box " {
            tags "externalSystem"
        }
        NEMSMESH = softwareSystem "NEMS MESH box " {
            tags "externalSystem"
        }

        //Relationships
        
        //external systems
        admin -> cm 
        nsd -> cm
        cm -> bss "Data via API"
        snow -> cm "HTTP request"
        pds -> cm pds "HTTP request"
       // nems -> cm "Deposit file in MESH"
        cm -> nemssub "Un/Subscribe HTTP Request"
       // CaaS -> cm "Deposit file in MESH"

        //CaaS Integration
        caasMESH -> cm.caasIntegration.retrieveMeshFile
        cm.caasIntegration.retrieveMeshFile -> cm.caasIntegration.ReceiveCaaSFile
        cm.caasIntegration.ReceiveCaaSFile -> cm.addQueue
        cm.caasIntegration.ReceiveCaaSFile -> cm.updateQueue
        cm.caasIntegration.ReceiveCaaSFile -> cm.participantManagement.removeParticipant
        cm.caasIntegration.ReceiveCaaSFile -> cm.DemographicServices.demographicDurable
        
        // participantManagement Queues
        cm.addQueue -> cm.participantManagement.addParticipant
        cm.updateQueue -> cm.participantManagement.updateParticipant

        //Participant Management
        cm.participantManagement.addParticipant -> cm.screeningData.createParticipant
        cm.participantManagement.updateParticipant -> cm.screeningData.updateParticipantDetails
        cm.participantManagement.removeParticipant -> cm.screeningData.updateParticipantDetails

        //cm.participantManagement.addParticipant -> cm.cohortDistribution.createCohort
        //cm.participantManagement.updateParticipant -> cm.cohortDistribution.createCohort
        //cm.participantManagement.removeParticipant -> cm.cohortDistribution.createCohort

        cm.participantManagement.addParticipant -> cm.demographicServices.pdsGet
        cm.participantManagement.updateParticipant -> cm.demographicServices.pdsGet
        cm.participantManagement.removeParticipant -> cm.demographicServices.pdsGet
        cm.participantManagement.blockParticipant -> cm.demographicServices.pdsGet
        cm.participantManagement.deleteParticipant -> cm.demographicServices.pdsGet

        cm.participantManagement.addParticipant -> cm.screeningData.markEligible
        cm.participantManagement.updateParticipant -> cm.screeningData.markEligible
        cm.participantManagement.updateParticipant -> cm.screeningData.markIneligible
        cm.participantManagement.removeParticipant -> cm.screeningData.markIneligible

        cm.participantManagement.addParticipant -> cm.screeningValidation.staticValidation
        cm.participantManagement.updateParticipant -> cm.screeningValidation.staticValidation
        cm.participantManagement.removeParticipant -> cm.screeningValidation.staticValidation

        cm.participantManagement.addParticipant -> cm.cohortQueue
        cm.participantManagement.updateParticipant -> cm.cohortQueue
        cm.participantManagement.removeParticipant -> cm.cohortQueue

        cm.cohortQueue -> cm.cohortDistribution.createCohort

        //Cohort Distribution
        cm.cohortDistribution.createCohort -> cm.cohortDistribution.serviceProvider
        cm.cohortDistribution.createCohort -> cm.cohortDistribution.validateCohort
        cm.cohortDistribution.createCohort -> cm.cohortDistribution.transform  
        cm.cohortDistribution.createCohort -> cm.cohortDistribution.addCohort   
        cm.cohortDistribution.createCohort -> bss  

        //DemographicServices
        cm.demographicServices.pdsGet -> pds "HTTP request by NHS No."
        cm.demographicServices.NEMSSub -> nemssub
        cm.demographicServices.NEMSUnsub -> nemssub
        cm.demographicServices.demographicData -> cm.participantManagement.addParticipant
                
        //Admin
        admin -> cm.participantManagement.blockParticipant
        admin -> cm.participantManagement.deleteParticipant

        //National Service Desk
        nsd -> cm.exceptionWA

        //exceptionManagement
        cm.exceptionWA -> cm.screeningData.getValidationExceptions
        cm.screeningData.getValidationExceptions -> cm.exceptionWA  
        

        //screening data service
        cm.screeningData.markEligible -> cm.screeningData.participantManagementService
        cm.screeningData.markIneligible -> cm.screeningData.participantManagementService
        cm.screeningData.createParticipant -> cm.screeningData.participantManagementService
        cm.screeningData.updateParticipantDetails -> cm.screeningData.participantManagementService
        cm.screeningData.createParticipant -> cm.screeningValidation.lookupValidation
        cm.screeningData.updateParticipantDetails -> cm.screeningValidation.lookupValidation

        //NEMS Integration
        NEMSMESH -> cm.NEMSIntegration
        cm.NEMSIntegration -> cm.updateQueue

        //ServiceNowIntegration
        snow -> cm.snowIntegration
        cm.snowIntegration -> cm.updateQueue
        
    }

    views {
        systemContext cm "WholeSystemContext" {
            include *
            autolayout lr
        }

        systemContext cm "RoutineCohort" {
            include cm caas bss nsd
            autolayout lr
        }

        systemContext cm "Block" {
            include cm admin nemssub
            autolayout lr
        }

        container cm "WholeContainerDiagram" {
            include *
            
        }
        
        component cm.caasIntegration "AddComponentDiagram" {
            include cm.caasIntegration.retrieveMeshFile cm.caasIntegration.ReceiveCaaSFile cm.participantManagement.addParticipant
            autolayout lr
        }
        
        component cm.screeningData "ScreeningDataService" {
            include *
            autolayout tb
        }

        component cm.caasIntegration "CaasIntegrationService" {
            include *
            autolayout lr
        }

        component cm.cohortDistribution "CohortDistributionService" {
            include *
            autolayout lr
        }

        component cm.participantManagement "ParticipantManagementService" {
            include *
            autolayout lr
        }
        
        component cm.DemographicServices "DemographicServices" {
            include *
            autolayout lr
        }

        component cm.screeningValidation "ScreeningValidationService" {
            include *
            autolayout lr
        }

        styles {
            element "Element" {
                color #ffffff
            }
            element "Person" {
                background #093f75
                shape person
            }
            element "Software System" {
                background #1368bd
            }
            element "Container" {
                background #23a2d9
            }
            element "Component" {
                background #63bef2
            }
            element "Database" {
                background #23a2d9
                shape cylinder
            }
            element "externalSystem" {
                background #8d8496
            }
            element "microService" {
                shape hexagon
            }
            element "dataService" {
                background #3399FF
            }
            element "webapp" {
                shape WebBrowser
            }
            element "queue" {
                shape Pipe
            }

            element "analyseWork"{

            }
        }
    }

    configuration {
        scope softwaresystem
    }

}