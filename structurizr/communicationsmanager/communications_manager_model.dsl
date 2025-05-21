communicationsManager = softwareSystem "Communications Manager" "Service for centralising all communication from screening programmes to the participant"{
    !docs docs
    communicationsManager_eventAPI = container "Communication Manager API" "Receive Comms events from various products"
    communicationManager_EventHandler = container "Communication Manager Event Handler" "Categorise communication events"
    communicationManager_Extpayloadprocessor = container "External Payload Processor""Create payload for external system, nhsNotify"
    communicationManager_DBStore = container "DBStore communications" "Store all communication event send to Notify" "AzureSqlDatabase" "Database"
    communicationManager_BusinessLogic = container "Business Logic" "Logic to create payload "
    communicationManager_NotifyAPI = container "External API" "Send payload to Notify"
}