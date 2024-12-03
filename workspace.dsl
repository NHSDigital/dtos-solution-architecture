workspace "Digital Transformation of Screening" "High level context diagram for all products within Digital Transformation of Screening" {

    model {
        u = person "Participant users" "External user eligible for screening" "external"
        st = person "Staff users" "Internal staff users including clinical and administrative staff"
        s = person "Secondary users" "Internal users, but not concerned with day to day operations"


        appointmentAllocator = softwareSystem "Appointment Allocator" "Service that appropriately allocates a participant to a slot"{
            appointmentAllocator_apiApp = container "API Application"

        }
        appointmentBooker = softwareSystem "Appointment Booker" "Service for both participant and staff to manage appointments"{
            appointmentBooker_userWeb = container "Citizen facing web interface"
            appointmentBooker_staffWeb = container "Staff facing web interface"
            appointmentBooker_apiApp = container "API Layer"
            appointmentBooker_db = container "Booking database"
            u -> appointmentBooker_userWeb "Books appointments using"
            st -> appointmentBooker_staffWeb "Manages appointments using"
            appointmentBooker_userWeb -> appointmentBooker_apiApp "Accesses database using"
            appointmentBooker_staffWeb -> appointmentBooker_apiApp "Access database using"
            appointmentBooker_apiApp -> appointmentBooker_db "Reads/Writes data using"
        }
        biandDataAnalysis = softwareSystem "BI and Data Analysis" "Service for analysing Screening data"{
            biandDataAnalysis_analytics = container "Web interface for running queries"
            biandDataAnalysis_participantManager = container "Read replica of particpant database"
            biandDataAnalysis_businessAudit = container "Read replica of audit database"
            s -> biandDataAnalysis_analytics "Queries data using"
            biandDataAnalysis_analytics -> biandDataAnalysis_participantManager "Reads data from"
            biandDataAnalysis_analytics -> biandDataAnalysis_businessAudit "Reads data from"
        }
        businessAudit = softwareSystem "Business Audit" "Service that provides immutable audit datastore used for analysis and non-repudiation"{
            businessAudit_api = container "Audit api"
            businessAudit_db = container "Immutable audit data store"
            businessAudit_api -> businessAudit_db "Writes audit data using"
            businessAudit_db -> biandDataAnalysis_businessAudit "Publishes read replica to"
        }

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

        systemLandscape dtosSystemContext "Overall system landscape"{
            include *
        }
        container appointmentAllocator {
            include *
            autoLayout lr
        }
        container appointmentBooker {
            include *
            autoLayout lr
        }
        container participantManager {
            include *
            autoLayout lr
        }
        container biandDataAnalysis {
            include *
            autoLayout lr
        }
        container businessAudit {
            include *
            autoLayout lr
        }
        container campaignManager {
            include *
            autoLayout lr
        }
        container capacityAndDemandPlanner {
            include *
            autoLayout lr
        }
        container capacityManager {
            include *
            autoLayout lr
        }
        container cohortManager {
            include *
            autoLayout lr
        }
        container communicationsManager {
            include *
            autoLayout lr
        }
        container participantSupport {
            include *
            autoLayout lr
        }
        container pathwayCoordinator {
            include *
            autoLayout lr
        }
        container screeningEventManager {
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