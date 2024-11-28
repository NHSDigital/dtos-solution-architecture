workspace "Digital Transformation of Screening" "High level context diagram for all products within Digital Transformation of Screening" {

    model {
        u = person "Participant users" "External user eligible for screening" "external"
        st = person "Staff users" "Internal staff users including clinical and administrative staff"
        s = person "Secondary users" "Internal users, but not concerned with day to day operations"


        appointmentAllocator = softwareSystem "Appointment Allocator" "Service that appropriately allocates a participant to a slot"
        appointmentBooker = softwareSystem "Appointment Booker" "Service for both participant and staff to manage appointments"
        biandDataAnalysis = softwareSystem "BI and Data Analysis" "Service for analysing Screening data"
        businessAudit = softwareSystem "Business Audit" "Service that provides immutable audit datastore used for analysis and non-repudiation"
        campaignManager = softwareSystem "Campaign Manager" "Service for launching and monitoring campaigns to improve uptake"
        capacityAndDemandPlanner = softwareSystem "Capacity and Demand Planner" "Service for optimising capacity vs demand constraints"
        capacityManager = softwareSystem "Capacity Manager" "Service to centralise the overall system capacity"
        cohortingAsAService = softwareSystem "Cohoring as a Service" "Service which produces a list of eligible participants based on a cohort definition"
        cohortManager = softwareSystem "Cohort Manager" "Service used for managing eligible participants in lieu of high quality data"
        communicationsManager = softwareSystem "Communications Manager" "Service for centralising all communincation from screening programmes to the participant"
        participantManager = softwareSystem "Participant Manager" "Service for managing a participant's episodes and encounters" {
            webapp = container "Web Application"
            database = container "Participant Data Store"
        }
        participantSupport = softwareSystem "Participant Support" "Service for managing inbound help requests from participants"
        pathwayCoordinator = softwareSystem "Pathway Coordinator" "Service that implements a pathway definition"
        screeningEventManager = softwareSystem "Screening Event Manager" "Service for coordinating and capturing the clinical investigation processes"
        nhsNotify = softwareSystem "NHS Notify" "NHS Wide service for providing communication to the Citizen" "external"

        cohortingAsAService -> cohortManager "Notifies of new eligible participant"
        cohortManager -> participantManager "Creates new participant record using"
        participantManager -> pathwayCoordinator "Notifies of participant ready for screening using"
        pathwayCoordinator -> participantManager "Manages participant's episode using"
        pathwayCoordinator -> appointmentAllocator "Gets slot for participant using"
        capacityAndDemandPlanner -> appointmentBooker "Creates unresourced slots using"
        appointmentAllocator -> appointmentBooker "Gets available slots using"
        appointmentAllocator -> biandDataAnalysis "Retrieves participants usage patterns"
        pathwayCoordinator -> appointmentBooker "Allocates appointment to Participant"        
        pathwayCoordinator -> communicationsManager "Sends invitations to participant using"
        communicationsManager -> nhsNotify "Communicates with the participant using"
        pathwayCoordinator -> screeningEventManager "Executes clinical investigation using"
        screeningEventManager -> pathwayCoordinator "Notification of clinical outcome using"
        capacityAndDemandPlanner -> cohortManager "Receives demand from"
        capacityManager -> capacityAndDemandPlanner "Receives capacity from"

        participantManager -> businessAudit "Notifies of business audit events using"
        screeningEventManager -> businessAudit "Notifies of business audit events using"
        appointmentBooker -> businessAudit "Notifies of business audit events using"
        participantSupport -> businessAudit "Notifies of business audit events using"
        businessAudit -> biandDataAnalysis "Publishes data to"
        appointmentBooker -> biandDataAnalysis "Publishes data to"
        appointmentAllocator -> biandDataAnalysis "Publishes data to"
        screeningEventManager -> biandDataAnalysis "Publishes data to"
        participantManager -> biandDataAnalysis "Publishes data to"


        u -> participantManager "Views screening information using"
        u -> appointmentBooker "Manages appointment using"
        u -> campaignManager "Interacts with campaigns using"
        u -> participantSupport "Requests support using"


        st -> screeningEventManager "Manages clinical investigation using"
        st -> appointmentBooker "Manages participant appointments using"
        st -> participantManager "Manages participant's episode using"
        st -> participantSupport "Manages participant queries using"
        
        s -> pathwayCoordinator "Manages Pathway definitions using"
        s -> capacityManager "Manages Capacity using"
        s -> biandDataAnalysis "Analyses screening data using"
        s -> campaignManager "Creates campaigns using"
        s -> capacityAndDemandPlanner "Manages capacity and demand using"


    }

    views {

        systemLandscape sl "Overall system landscape"{
            include *
        }

        container participantManager {
            include *
            autoLayout lr
        }
        styles {
            element "Element" {
                color #ffffff
            }
            element "Person" {
                background #1168bd
                shape person
            }
            element "Software System" {
                background #1168bd
            }
            element "Container" {
                background #1168bd
            }
                element "Database" {
                shape cylinder
            }
            element "external" {
                background #eaeaea
                color #000000
            }

        }
    }

}