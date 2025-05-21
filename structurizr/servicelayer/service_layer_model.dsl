serviceLayer = softwareSystem "Service Layer" "Service integration layer used to transition from legacy to the future platform"{
    serviceLayer_API = container "Service Layer API" "External API for external systems to interface with NSP" ".net Azure Function"
    serviceLayer_MeshMailbox = container "Service Layer Mesh Mailbox" "External mesh mailbox to ingest data" "Mesh Mailbox"
    serviceLayer_ProcessingQueue = container "Service Layer Processing Queue" "Asynchronous queue for processing inbound data items" "Eventgrid"
    serviceLayer_DataProcessor = container "Service Layer Data Processor" "Multiple data processors that convert data into NSP Events" ".net Azure Function"
    
}