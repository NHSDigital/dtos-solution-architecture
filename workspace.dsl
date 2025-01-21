workspace "Digital Transformation of Screening" "High level context diagram for all products within Digital Transformation of Screening" {

    model {
        u = person "P9 Participant users" "External user eligible for screening" "external"
        u1 = person "Unauthenticated Participant users" "External users without NHS Login account" "external"

        st = person "Staff users" "Internal staff users including clinical and administrative staff"
        s = person "Secondary users" "Internal users, but not concerned with day to day operations"

        nhsNotify = softwareSystem "NHS Notify" "NHS Wide service for providing communication to the Citizen" "external"
        nhsLogin = softwareSystem "NHS Login" "NHS Wide service for authenticating the Citizen" "external"
        nhsIdentity = softwareSystem "NHS Identity" "NHS Wide service for authenticating Staff" "external"
        nhsApp = softwareSystem "NHS App" "National Mobile Application for NHS" "Mobile App" 
        appointmentAllocator = softwareSystem "Appointment Allocator" "Service that appropriately allocates a participant to a slot"{
            appointmentAllocator_apiApp = container "API Application"
        }
        appointmentBooker = softwareSystem "Appointment Booker" "Service for both participant and staff to manage appointments"{
            appointmentBooker_userWeb = container "Citizen facing web interface" "External facing web application to manage your booking" "Web App" "Web Browser"
            appointmentBooker_staffWeb = container "Staff facing web interface" "Internal facing web application use to manage appointment bookings and attendance" "Web App" "Web Browser"
            appointmentBooker_apiApp = container "API Layer" "API used to access underlying booking information" 
            appointmentBooker_db = container "Booking database" "Underlying booking data store" "Database" "Database"
        }
        biandDataAnalysis = softwareSystem "BI and Data Analysis" "Service for analysing Screening data"{
            biandDataAnalysis_analytics = container "Web interface for running queries" "Web portal used to access analysis and queries" "Web App" "Web Browser"
            biandDataAnalysis_participantManager = container "Read replica of participant database" "Copy of participant dataset containing episode information" "Database" "Database"
            biandDataAnalysis_businessAudit = container "Read replica of audit database" "Copy of audit database for analytics purposes" "Database" "Database"
        }
        businessAudit = softwareSystem "Business Audit" "Service that provides immutable audit datastore used for analysis and non-repudiation"{
            businessAudit_api = container "Audit api"
            businessAudit_db = container "Audit datastore" "Immutable audit data store containing all audit information" "Database" "Database" 
        }

        campaignManager = softwareSystem "Campaign Manager" "Service for launching and monitoring campaigns to improve uptake"
        capacityAndDemandPlanner = softwareSystem "Capacity and Demand Planner" "Service for optimising capacity vs demand constraints"
        capacityManager = softwareSystem "Capacity Manager" "Service to centralise the overall system capacity"
        cohortingAsAService = softwareSystem "Cohorting as a Service" "Service which produces a list of eligible participants based on a cohort definition"
        cohortManager = softwareSystem "Cohort Manager" "Service used for managing eligible participants in lieu of high quality data"
        communicationsManager = softwareSystem "Communications Manager" "Service for centralising all communication from screening programmes to the participant"
        participantManager = softwareSystem "Participant Manager" "Service for managing a participant's episodes and encounters" {     
            participantManager_internalWebapp = container "Staff Facing Web Application" "Internal facing web application for staff to manage participant episode information" "Web App" "Web Browser"
            participantManager_database = container "Participant Data Store" "System of record datastore for Participants and Episodes" "Database" "Database"
            participantManager_externalWebApp = container "Participant Facing Web Application" "External facing web interface for participants to engage with the screening service" "Web App" "Web Browser"
            participantManager_noAuthWebApp = container "Anonymous Web Application" "External facing web interface that requires minimal authentication to provide access to some screening services" "Web App" "Web Browser"
            participantManager_API = container "Participant API"
        }
        participantSupport = softwareSystem "Participant Support" "Service for managing inbound help requests from participants"
        pathwayCoordinator = softwareSystem "Pathway Coordinator" "Service that implements a pathway definition"{
            pathwayCoordinator_ParticipantEventsQueue = container "Participants Events Queue" "Main queue where participant related events are received" "Servicebus" "Queue"
            pathwayCoordinator_ParticipantEventHandler = container "Participant Event Handler" "Function responsible to acting on Participant Events" "Azure Function"
            pathwayCoordinator_PathwayManager = container "Pathway Manager" "Based on the triggering event and the pathway, determines the next action" ".net Class"
            pathwayCoordinator_PathwaySteps = container "Pathway Steps" "Collection of discrete pathway steps invoked by a pathway" ".net Class"
        }

        pathwayCoordinator_ParticipantEventHandler -> pathwayCoordinator_ParticipantEventsQueue "Subscribes to messages from"
        pathwayCoordinator_ParticipantEventHandler -> pathwayCoordinator_PathwayManager "Executes pathway using"
        pathwayCoordinator_PathwayManager -> pathwayCoordinator_PathwaySteps "Invokes pathway steps using"

        screeningEventManager = softwareSystem "Screening Event Manager" "Service for coordinating and capturing the clinical investigation processes" {
            sem_internalWebapp = container "Staff Facing SEM Web Application" "Internal facing web application for staff to manage SEM clinical information" "Web App" 
            sem_database = container "SEM datastore" "System of record datastore for screening event clinical information" "Database" 
            sem_internalOrchestrationWorkflowApp = container "SEM Orchestration Workflow" "Server App"
        }
        localTrustSystem = softwareSystem "Local Trust System" "Local Trust System"
        serviceLayer = softwareSystem "Service Layer" "Service integration layer used to transition from legacy to the future platform"

        cohortingAsAService -> cohortManager "Notifies of new eligible participant using"
        cohortManager -> pathwayCoordinator "Notifies of new eligible participant using"
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
        stManageEpisode = st -> participantManager "Manages participant's episode using"
        st -> participantSupport "Manages participant queries using"
        
        s -> pathwayCoordinator "Manages Pathway definitions using"
        s -> capacityManager "Manages Capacity using"
        s -> biandDataAnalysis "Analyses screening data using"
        s -> campaignManager "Creates campaigns using"
        s -> capacityAndDemandPlanner "Manages capacity and demand using"

        # Appointment allocator
        appointmentAllocator_apiApp -> BIAndDataAnalysis "Accesses historical attendance patterns using"

        #Appointment Booker
        u -> appointmentBooker_userWeb "Books appointments using"
        st -> appointmentBooker_staffWeb "Manages appointments using"
        appointmentBooker_userWeb -> appointmentBooker_apiApp "Accesses database using"
        appointmentBooker_staffWeb -> appointmentBooker_apiApp "Access database using"
        appointmentBooker_apiApp -> appointmentBooker_db "Reads/Writes data using"

        #BI & Data Analysis
        s -> biandDataAnalysis_analytics "Queries data using"
        biandDataAnalysis_analytics -> biandDataAnalysis_participantManager "Reads data from"
        biandDataAnalysis_analytics -> biandDataAnalysis_businessAudit "Reads data from"

        # Business Audit
        businessAudit_api -> businessAudit_db "Writes audit data using"
        businessAudit_api -> biandDataAnalysis_businessAudit "Streams events to"

        # Participant manager
        u -> nhsLogin "Authenticates using"
        u -> nhsApp "Accesses secure NHS services using"
        nhsApp -> participantManager_externalWebApp "Interacts with screening service using"
        u -> participantManager_externalWebApp "Interacts with screening service using"
        participantManager_externalWebApp -> participantManager_noAuthWebApp "Accesses low security area using"
        u1 -> participantManager_noAuthWebApp "Access low security information using"
        participantManager_externalWebApp -> participantManager_API "Retrieves data using"
        participantManager_internalWebapp -> participantManager_API "Retrieves data using"
        participantManager_API -> participantManager_database "Accesses data using"
        s -> participantManager_internalWebapp "Interacts with participant screening history using"
        s -> nhsIdentity "Authenticates using"

        # Pathway Coordinator
        cohortManager -> pathwayCoordinator_ParticipantEventsQueue "Published New Eligible Participant Event using"
        serviceLayer -> pathwayCoordinator_ParticipantEventsQueue "Publishes participant level event to"

        # Screening Event Manager
        st -> sem_internalWebapp "Manages SEM clinical information using"
        sem_internalWebapp -> sem_database "Reads/Writes data from/to"
        sem_internalOrchestrationWorkflowApp -> sem_database "Reads/Writes data from/to"
        sem_internalOrchestrationWorkflowApp -> participantManager "Reads data from"
        sem_internalOrchestrationWorkflowApp -> localTrustSystem "Communicates with"

    }

    views {

        systemLandscape dtosSystemContext "Overall system landscape"{
            include *
        }
        container appointmentAllocator AppointmentAllocator {
            include *
            autoLayout lr
        }
        container appointmentBooker AppointmentBooker {
            include *
            autoLayout lr
        }
        container biandDataAnalysis BIAndDataAnalysis {
            include *
            autoLayout lr
        }
        container businessAudit BusinessAudit {
            include *
            autoLayout lr
        }
        container campaignManager CampaignManager {
            include *
            autoLayout lr
        }
        container capacityAndDemandPlanner CapacityAndDemandPlanner {
            include *
            autoLayout lr
        }
        container capacityManager CapacityManager {
            include *
            autoLayout lr
        }
        container cohortManager CohortManager {
            include *
            autoLayout lr
        }
        container communicationsManager CommunicationsManager {
            include *
            autoLayout lr
        }
        container participantSupport ParticipantSupport {
            include *
            autoLayout lr
        }
        container pathwayCoordinator PathwayCoordinator {
            include *
            autoLayout lr
        }
        container screeningEventManager ScreeningEventManager {
            include *
            exclude stManageEpisode
            autoLayout lr
        }
        container participantManager ParticipantManager {
            include *
        }

        container serviceLayer ServiceLayer {
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
                background #438dd5
            }
            element "Queue" {
                shape "Pipe"
            }
            element "Web Browser" {
                shape WebBrowser
            }
            element "Mobile App" {
                shape MobileDeviceLandscape
            }
            element "Database" {
                shape Cylinder
            }
            element "external" {
                background #eaeaea
                color #000000
            }

        }
    }

}