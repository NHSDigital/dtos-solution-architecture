serviceLayer = softwareSystem "Service Layer" "Service integration layer used to transition from legacy to the future platform"{
    API = container "Service Layer API" "External API for external systems to interface with NSP" ".net Azure Function"
    meshMailbox = container "Service Layer Mesh Mailbox" "External mesh mailbox to ingest data" "Mesh Mailbox"
    processingFunctions = container "Service Layer Processing Functions" "Multiple functions to perform ETL on ingested data" ".net Azure Function" {
        fileDiscovery = component "File Discovery Function" "Timer-triggered function for polling MESH mailbox" ".net Azure Function"
        fileExtract = component "File Extract Function" "Queue-triggered function for downloading file from MESH mailbox" ".net Azure Function"
        fileTransform = component "File Transform Function" "Queue-triggered function for parsing and validating downloaded file, and storing structured data" ".net Azure Function"
    }
    internalQueues = container "Service Layer Internal Queues" "Multiple asynchronous queues to regulate processing of ingested data" "Azure Storage Queues" {
        fileExtractQueue = component "File Extract Queue" "Internal queue to regulate flow of file downloads" "Azure Storage Queue" "Queue"
        fileTransformQueue = component "File Transform Queue" "Internal queue to regulate flow of file parsing and data appending" "Azure Storage Queue" "Queue"
    }
    serviceLayer_FileStore = container "Service Layer File Store" "Binary file store to retain original downloaded files for processing and archival" "Azure Blob Storage Container" "Database"
    serviceLayer_DataStore = container "Service Layer Data Store" "Structured data store to hold aggregated data ingested from legacy systems" "Azure SQL DB" "Database"
}