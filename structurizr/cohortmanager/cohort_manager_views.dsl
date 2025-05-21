systemContext cm "WholeSystemContext" "Target System Context Diagram" {
    include *
    autolayout lr
}

systemContext cm "RoutineCohort" "Routine Cohort System Context Diagram" {
    include cm CaaS BSSelect st
    autolayout lr
}

systemContext cm "Block" "Block Participant System Context" {
    include cm st NEIMS
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