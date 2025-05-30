serviceLayer.API -> serviceLayer.processingFunctions "Adds data for processing using"
serviceLayer.meshMailbox -> serviceLayer.processingFunctions "Adds messages for processing using"
serviceLayer.processingFunctions -> serviceLayer.internalQueues "Enqueues messages to"
serviceLayer.internalQueues -> serviceLayer.processingFunctions  "Dequeue messages from"
serviceLayer.processingFunctions -> serviceLayer.serviceLayer_FileStore "Downloads original files to"
serviceLayer.processingFunctions -> pathwayCoordinator.inbound_API "Emits events for processing using"
serviceLayer.processingFunctions -> serviceLayer.serviceLayer_DataStore "Appends validated transformed data to"
serviceLayer.meshMailbox -> serviceLayer.processingFunctions.fileDiscovery
serviceLayer.processingFunctions.fileDiscovery -> serviceLayer.internalQueues.fileExtractQueue "Enqueues file extract message on"
serviceLayer.internalQueues.fileExtractQueue -> serviceLayer.processingFunctions.fileExtract
serviceLayer.meshMailbox -> serviceLayer.processingFunctions.fileExtract
serviceLayer.processingFunctions.fileExtract -> serviceLayer.serviceLayer_FileStore "Stores original downloaded binary file"
serviceLayer.processingFunctions.fileExtract -> serviceLayer.internalQueues.fileTransformQueue "Enqueues file transform message to"
serviceLayer.internalQueues.fileTransformQueue -> serviceLayer.processingFunctions.fileTransform "Sends file transform message to"
serviceLayer.processingFunctions.fileTransform -> serviceLayer.serviceLayer_FileStore "Parses downloaded binary file"
serviceLayer.processingFunctions.fileTransform -> serviceLayer.serviceLayer_DataStore "Appends validated transformed data to"

# Eligible Participant Integration (CaaS/Service Now)
servicelayer.caasIntegrationservice -> servicelayer.meshMailBoxCaaS "Retrieve CaaS file" 
servicelayer.caasIntegrationservice -> servicelayer.caasProcessingFunction "Send file for processing"
servicelayer.caasProcessingFunction -> servicelayer.eligibleParticipantInboundQueue "Sends participant records"
servicelayer.participantTransformationFunction -> servicelayer.eligibleParticipantInboundQueue "Get participant record"
servicelayer.participantTransformationFunction -> servicelayer.eligibleParticipantQueue "Send standardised participant record"
servicelayer.ServiceNowIntegrationAPI -> servicelayer.eligibleParticipantInboundQueue "Send manually add participants"

#Demographic Integration (PDS,NEIMS)
servicelayer.demographicChangeEventInboundQueue -> servicelayer.meshMailBoxNEIMS "Retrieve demographic change event"
servicelayer.demographicChangeEventInboundQueue -> servicelayer.PDSIntegrationAPI "Get Demographic Change Details"
servicelayer.NEIMSubscriptionIntegration -> servicelayer.eligibleParticipantInboundQueue "Get New NHS ID"
servicelayer.PDSIntegrationAPI -> servicelayer.eligibleParticipantInboundQueue "Get New NHS ID"

//external system integration
servicelayer.PDSIntegrationAPI -> PDS "Get Demographic Data"
NEIMS -> servicelayer.meshMailBoxNEIMS "Sent demographic change event VIA mesh"
servicelayer.NEIMSubscriptionIntegration -> NEIMSSubscriptionAPI "Explicit subscription" 
