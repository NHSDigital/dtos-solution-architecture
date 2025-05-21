participantManager = softwareSystem "Participant Manager" "Service for managing a participant's episodes and encounters" {     
    !docs docs
    participantManager_internalWebapp = container "Staff Facing Web Application" "Internal facing web application for staff to manage participant episode information" "Nextjs Web App" "Web Browser"
    participantManager_database = container "Participant Manager Data Store" "System of record datastore for Participants and Episodes" "Azure SQL Database" "Database"
    participantManager_externalWebApp = container "Participant Facing Web Application" "External facing web interface for participants to engage with the screening service" "Nextjs Web App" "Web Browser"
    participantManager_noAuthWebApp = container "Anonymous Web Application" "External facing web interface that requires minimal authentication to provide access to some screening services" "Nextjs Web App" "Web Browser"
    participantManager_API = container "Participant API" "CRUD API used to manage the underlying data store" ".net Azure Function"{
        participantManager_API_Participant = component "Participant Function" "Azure function for managing participant" ".net Azure Function"
        participantManager_API_Episode = component "Episode Function" "Azure function for managing episode" ".net Azure Function"
        participantManager_API_Eligibility = component "Eligibility Function" "Azure function for managing eligibility" ".net Azure Function"
        participantManager_API_Encounter = component "Encounter Function" "Azure function for managing encounter" ".net Azure Function"

    }
    participantManager_ExperienceAPI = container "Participant Experience API" "Experience API used by the web front ends to present data" ".net Azure Function"
    participantManager_ProductEventHandler = container "Participant Manager Product Event Handler" "Product events handler for Participant Manager" ".net Azure Function"
}