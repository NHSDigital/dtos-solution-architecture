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