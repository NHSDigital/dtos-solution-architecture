pathwayCoordinator = softwareSystem "Pathway Coordinator" "Service that implements a pathway definition"{
    !docs docs
    db = container "Pathway Data Store" "System of record datastore for Screening Pathways" "Azure SQL Database" "Database"
    pathwayManager_API = container "Pathway Manager API" "CRUD API used to manage the underlying data store" ".net Azure Function"
    internalWebapp = container "Pathway Web Application" "Internal facing web application for staff to manage pathway definitions" "Nextjs Web App" "Web Browser"
    contextManager_database = container "Pathway Context Data Store" "Transient data store used ot support the pathway progression" "Azure Cosmos Database" "Database"
    contextManager_API = container "Pathway Context API" "CRUD API used to manage the underlying data store" ".net Azure Function"
    contextManager_internalWebapp = container "Context Web Application" "Internal facing web application for staff view current pathway statuses" "Nextjs Web App" "Web Browser"
    inbound_API = container "Pathway Coordinator API" "Used as a synchronous mechanism for validating the data payload, before processing" ".net Azure Function"

    participantEventsQueue = container "Participants Events Queue" "Main queue where participant related events are received" "Eventgrid" "Queue"
    productEventsQueue = container "Product Events Queue" "Queue used by the Pathway Coordinator to communicate with Products" "Eventgrid" "Queue" 
    participantEventHandler = container "Participant Event Handler" "Function responsible to acting on Participant Events" ".net Azure Function"
    contextManager_ParticipantEventHandler = container "Context Event Handler" "Function responsible for tracking the context of the Participant" ".net Azure Function"       
}
