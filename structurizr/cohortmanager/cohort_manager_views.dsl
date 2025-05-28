systemContext cm "RoutineCohort" {
    title "System context diagram for routine cohort"
    include cm CaaS BSSelect st
    autolayout lr
}

systemContext cm "Block"{
    title "Block Participant System Context" 
    include cm st NEIMS
    autolayout lr
}

systemContext cm "WholeSystemContext"{
    title "Target cohort manager system context"
    include *
    autolayout lr
}

container cm "WholeContainerDiagram" {
    include *
    autolayout lr   
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