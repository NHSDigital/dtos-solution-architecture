systemContext serviceLayer "ServiceLayerSystemContext" "Target System Context Diagram" {
    include *
    autolayout lr
}

systemContext serviceLayer "dtoss8622Context" "System Context Digram for Jira ticket dtos8622" {
    include NBSS
    include serviceLayer
    autolayout lr
}

container serviceLayer ServiceLayer {
    include *
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