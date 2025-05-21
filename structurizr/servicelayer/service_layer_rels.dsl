serviceLayer -> localTrustSystem "Communicates with"
serviceLayer -> appointmentBooker "Send processed appointment events"          
SLtoPC = serviceLayer -> pathwayCoordinator.pathwayCoordinator_API "Publishes participant level event to"
serviceLayer.serviceLayer_API -> serviceLayer.serviceLayer_ProcessingQueue "Adds messages for processing using"
serviceLayer.serviceLayer_MeshMailbox -> serviceLayer.serviceLayer_ProcessingQueue "Adds messages for processing using"
serviceLayer.serviceLayer_DataProcessor -> serviceLayer.serviceLayer_ProcessingQueue "Subscribes to queue"
serviceLayer.serviceLayer_DataProcessor -> pathwayCoordinator.pathwayCoordinator_API "Emits events for processing using"

