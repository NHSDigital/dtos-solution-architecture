systemContext serviceLayer "ServiceLayerSystemContext" "Target System Context Diagram" {
    include *
    autolayout lr
}

systemContext serviceLayer "dtoss8622Context" "System Context Digram for Jira ticket dtos8622" {
    include NBSS
    include serviceLayer
    autolayout lr
}
container serviceLayer "FutureStateCaaS-SNowintegrationServiceLayer"{
    include servicelayer.caasIntegrationservice servicelayer.caasProcessingFunction servicelayer.eligibleParticipantInboundQueue servicelayer.participantTransformationFunction servicelayer.eligibleParticipantQueue servicelayer.ServiceNowIntegrationAPI servicelayer.meshMailBoxCaaS servicelayer.eligibleParticipantInboundQueue NEIMSSubscriptionAPI servicelayer.NEIMSubscriptionIntegration servicelayer.PDSIntegrationAPI PDS NEIMSSubscriptionAPI
}
container serviceLayer "FutureStateDemographicIntegrationServiceLayer"{
    include PDS NEIMS NEIMSSubscriptionAPI servicelayer.NEIMSubscriptionIntegration servicelayer.meshMailBoxNEIMS servicelayer.PDSIntegrationAPI servicelayer.demographicChangeEventInboundQueue servicelayer.eligibleParticipantInboundQueue
}
container serviceLayer ServiceLayer {
    include *
    exclude servicelayer.caasIntegrationservice servicelayer.caasProcessingFunction servicelayer.eligibleParticipantInboundQueue servicelayer.participantTransformationFunction servicelayer.eligibleParticipantQueue servicelayer.ServiceNowIntegrationAPI servicelayer.meshMailBoxCaaS servicelayer.NEIMSubscriptionIntegration servicelayer.meshMailBoxNEIMS servicelayer.PDSIntegrationAPI servicelayer.demographicChangeEventInboundQueue NEIMS NEIMSSubscriptionAPI
    autolayout lr
}

container serviceLayer "ServiceLayerContainerDtoss8622" {
    include NBSS
    include serviceLayer.meshMailbox serviceLayer.processingFunctions serviceLayer.internalQueues serviceLayer.serviceLayer_DataStore serviceLayer.serviceLayer_FileStore
    autolayout lr
}

component serviceLayer.processingFunctions "ProcessingFunctionComponentView"{
    include *
    autoLayout lr
}

dynamic serviceLayer.processingFunctions ServiceLayerComponentsDtoss8622 {
    serviceLayer.processingFunctions.fileDiscovery -> serviceLayer.meshMailbox "Gets list of files"
    serviceLayer.processingFunctions.fileDiscovery -> serviceLayer.internalQueues.fileExtractQueue "Enqueues file extract message on"

    serviceLayer.internalQueues.fileExtractQueue -> serviceLayer.processingFunctions.fileExtract "Sends file extract message to"
    serviceLayer.processingFunctions.fileExtract -> serviceLayer.meshMailbox "Downloads and acknowledges file"
    serviceLayer.processingFunctions.fileExtract -> serviceLayer.serviceLayer_FileStore "Stores original downloaded binary file"
    serviceLayer.processingFunctions.fileExtract -> serviceLayer.internalQueues.fileTransformQueue "Enqueues file transform message to"

    serviceLayer.internalQueues.fileTransformQueue -> serviceLayer.processingFunctions.fileTransform "Sends file transform message to"
    serviceLayer.processingFunctions.fileTransform -> serviceLayer.serviceLayer_FileStore "Parses downloaded binary file"
    serviceLayer.processingFunctions.fileTransform -> serviceLayer.serviceLayer_DataStore "Appends validated transformed data to"
    autolayout lr
}