 //Relationships
        
        //external systems
        st -> cm 
        cm -> BSSelect "Data via API"
       // nems -> cm "Deposit file in MESH"
        cm -> NEIMS "Un/Subscribe HTTP Request"
       // CaaS -> cm "Deposit file in MESH"

        //CaaS Integration
        
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
        cm.cohortDistribution.createCohort -> BSSelect  

        //DemographicServices
        cm.demographicServices.pdsGet -> PDS "HTTP request by NHS No."
        cm.demographicServices.NEMSSub -> NEIMS
        cm.demographicServices.NEMSUnsub -> NEIMS
        cm.demographicServices.demographicData -> cm.participantManagement.addParticipant
                
        //Admin
        st -> cm.participantManagement.blockParticipant
        st -> cm.participantManagement.deleteParticipant

        //National Service Desk
        st -> cm.exceptionWA

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

        cm.NEMSIntegration -> cm.updateQueue

        //ServiceNowIntegration
        
        cm.snowIntegration -> cm.updateQueue


        //cm -> pathwayCoordinator "Notifies of new eligible participant using"
        cm -> ITOC "Send monitoring logs"

        cm -> businessAudit.inboundQueue "Writes eligibility changes, demographic and transformation changes"
        cm -> pathwayCoordinator.inbound_API "Published New Eligible Participant Event using"