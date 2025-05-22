communicationsManager = softwareSystem "Communications Manager" "Service for centralising all communication from screening programmes to the participant"{
    !docs docs
    API = container "Communication Manager API" "Receive Comms events from various products"
    eventHandler = container "Communication Manager Event Handler" "Categorise communication events"
    extPayloadProcessor = container "External Payload Processor""Create payload for external system, nhsNotify"
    db = container "DBStore communications" "Store all communication event send to Notify" "AzureSqlDatabase" "Database"
    businessLogic = container "Business Logic" "Logic to create payload "
    notifyAPI = container "External API" "Send payload to Notify"
}