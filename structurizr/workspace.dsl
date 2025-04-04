workspace "Digital Transformation of Screening" "High level context diagram for all products within Digital Transformation of Screening" {

    model {
        u = person "P9 Participant users" "External user eligible for screening" "external"
        u1 = person "Unauthenticated Participant users" "External users without NHS Login account" "external"

        st = person "Staff users" "Internal staff users including clinical and administrative staff"
        s = person "Secondary users" "Internal users, but not concerned with day to day operations"

        nhsNotify = softwareSystem "NHS Notify" "NHS Wide service for providing communication to the Citizen" "external"
        nhsLogin = softwareSystem "NHS Login" "NHS Wide service for authenticating the Citizen" "external"
        nhsCIS2 = softwareSystem "Care Identity Service (CIS)" "NHS Wide service for authenticating Staff" "external"
        nhsApp = softwareSystem "NHS App" "National Mobile Application for NHS" "Mobile App" 
        appointmentQueue = softwareSystem "Appointment Queue" "Service for pathway coordinator to receive appointments "
        appointmentAllocator = softwareSystem "Appointment Allocator" "Service that appropriately allocates a participant to a slot"{
            appointmentAllocator_apiApp = container "API Application"
        
        }
        appointmentBooker = softwareSystem "Appointment Booker" "Service for both participant and staff to manage appointments"{
            appointmentBooker_userWeb = container "Participant facing web interface" "External facing web application to manage your booking" "Web App" "Web Browser"
            appointmentBooker_staffWeb = container "Staff facing web interface" "Internal facing web application use to manage appointment bookings and attendance" "Web App" "Web Browser"
            appointmentBooker_apiApp = container "API Layer" "API used to access underlying booking information" 
            appointmentBooker_db = container "Booking database" "Underlying booking data store" "Database" "Database"
            appointmentBooker_ProductEventHandler = container "Appointment Booker Product Event Handler" "Product events handler for Appointment Booker" ".net Azure Function"
            appointmentBooker_ProductEventQueue = container "Appointment Booker Event Queue" "Inbound event queue for Appointment Booker" "Event Grid Topic" "Queue"
        }
        biandDataAnalysis = softwareSystem "BI and Data Analysis" "Service for analysing Screening data"{
            biandDataAnalysis_analytics = container "Web interface for running queries" "Web portal used to access analysis and queries" "Web App" "Web Browser"
            biandDataAnalysis_participantManager = container "Read replica of participant database" "Copy of participant dataset containing episode information" "Database" "Database"
            biandDataAnalysis_businessAudit = container "Read replica of audit database" "Copy of audit database for analytics purposes" "Database" "Database"
        }
        businessAudit = softwareSystem "Business Audit" "Service that provides immutable audit datastore used for analysis and non-repudiation"{
            businessAudit_queue = container "Audit log queue"
            businessAudit_api = container " Read Audit Data Api"
            businessAudit_db = container "Audit datastore" "Immutable audit data store containing all audit information" "Database" "Database" 
            businessAudit_UserInterface = container "Audit User Interface" "Search and Display participants sequence of event"
        }

        campaignManager = softwareSystem "Campaign Manager" "Service for launching and monitoring campaigns to improve uptake"
        capacityAndDemandPlanner = softwareSystem "Capacity and Demand Planner" "Service for optimising capacity vs demand constraints"
        capacityManager = softwareSystem "Capacity Manager" "Service to centralise the overall system capacity"
        cohortingAsAService = softwareSystem "Cohorting as a Service" "Service which produces a list of eligible participants based on a cohort definition"
        cohortManager = softwareSystem "Cohort Manager" "Service used for managing eligible participants in lieu of high quality data"
        communicationsManager = softwareSystem "Communications Manager" "Service for centralising all communication from screening programmes to the participant"{
            communicationsManager_eventAPI = container "Communication Manager API" "Receive Comms events from various products"
            communicationManager_EventHandler = container "Communication Manager Event Handler" "Categorise communication events"
            communicationManager_Extpayloadprocessor = container "External Payload Processor""Create payload for external system, nhsNotify"
            communicationManager_DBStore = container "DBStore communications" "Store all communication event send to Notify" "AzureSqlDatabase" "Database"
            communicationManager_BusinessLogic = container "Business Logic" "Logic to create payload "
            communicationManager_NotifyAPI = container "External API" "Send payload to Notify"
        }
        

        participantManager = softwareSystem "Participant Manager" "Service for managing a participant's episodes and encounters" {     
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

        participantSupport = softwareSystem "Participant Support" "Service for managing inbound help requests from participants"
        pathwayCoordinator = softwareSystem "Pathway Coordinator" "Service that implements a pathway definition"{
            pathwayManager_database = container "Pathway Data Store" "System of record datastore for Screening Pathways" "Azure SQL Database" "Database"
            pathwayManager_API = container "Pathway Manager API" "CRUD API used to manage the underlying data store" ".net Azure Function"
            pathwayManager_internalWebapp = container "Pathway Web Application" "Internal facing web application for staff to manage pathway definitions" "Nextjs Web App" "Web Browser"
            contextManager_database = container "Pathway Context Data Store" "Transient data store used ot support the pathway progression" "Azure Cosmos Database" "Database"
            contextManager_API = container "Pathway Context API" "CRUD API used to manage the underlying data store" ".net Azure Function"
            contextManager_internalWebapp = container "Context Web Application" "Internal facing web application for staff view current pathway statuses" "Nextjs Web App" "Web Browser"
            pathwayCoordinator_API = container "Pathway Coordinator API" "Used as a synchronous mechanism for validating the data payload, before processing" ".net Azure Function"

            pathwayCoordinator_ParticipantEventsQueue = container "Participants Events Queue" "Main queue where participant related events are received" "Eventgrid" "Queue"
            pathwayCoordinator_ProductEventsQueue = container "Product Events Queue" "Queue used by the Pathway Coordinator to communicate with Products" "Eventgrid" "Queue" 
            pathwayCoordinator_ParticipantEventHandler = container "Participant Event Handler" "Function responsible to acting on Participant Events" ".net Azure Function"
            contextManager_ParticipantEventHandler = container "Context Event Handler" "Function responsible for tracking the context of the Participant" ".net Azure Function"
             
        }
        localTrustSystem = softwareSystem "Local Trust System" "Local Trust System" "external"

        screeningEventManager = softwareSystem "Screening Event Manager" "Service for coordinating and capturing the clinical investigation processes" {
            sem_internalWebapp = container "Staff Facing SEM Web Application" "Internal facing web application for staff to manage SEM clinical information" "Web App" "Web Browser"
            sem_database = container "SEM datastore" "System of record datastore for screening event clinical information" "Database" "Database"
            sem_internalOrchestrationWorkflowApp = container "SEM Orchestration Workflow" "Server App"
        }
        serviceLayer = softwareSystem "Service Layer" "Service integration layer used to transition from legacy to the future platform"{
            serviceLayer_API = container "Service Layer API" "External API for external systems to interface with NSP" ".net Azure Function"
            serviceLayer_MeshMailbox = container "Service Layer Mesh Mailbox" "External mesh mailbox to ingest data" "Mesh Mailbox"
            serviceLayer_ProcessingQueue = container "Service Layer Processing Queue" "Asynchronous queue for processing inbound data items" "Eventgrid"
            serviceLayer_DataProcessor = container "Service Layer Data Processor" "Multiple data processors that convert data into NSP Events" ".net Azure Function"
            
        }

        NBSS = softwareSystem "National Breast Screening Service" "External Service used for managing breast screening" "external"
        CSMS = softwareSystem "Cervical Screening Management System" "External Service used for managing cervical screening" "external"
        Bowel = softwareSystem "Bowel Screening System" "External Service used for managing bowel screening" "external"
        DES = softwareSystem "Diabetic Eye Screening" "External Service used for managing diabetic eye screening" "external"
        AAA = softwareSystem "Abdominal aortic aneurysm" "External Service used for managing AAA screening" "external"

        cohortingAsAService -> cohortManager "Notifies of new eligible participant using"
        cohortManager -> pathwayCoordinator "Notifies of new eligible participant using"
        participantManager -> pathwayCoordinator "Notifies of participant ready for screening using"
        pathwayCoordinator -> participantManager "Manages participant's episode (appointments, closed episodes) using"
        pathwayCoordinator -> appointmentAllocator "Gets slot for participant using"
        capacityAndDemandPlanner -> appointmentBooker "Creates unresourced slots using"
        appointmentAllocator -> appointmentBooker "Gets available slots using"
        appointmentAllocator -> biandDataAnalysis "Retrieves participants usage patterns"      
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

        serviceLayer -> localTrustSystem "Communicates with"

        NBSS -> ServiceLayer "Sends breast screening data to"
        CSMS -> ServiceLayer "Sends cervical screening data to"
        Bowel -> ServiceLayer "Sends bowel screening data to"
        DES -> ServiceLayer "Sends DES screening data to"
        AAA -> ServiceLayer "Sends AAA screening data to"

        BusinessAudit -> PathwayCoordinator "Subscribes to events from"

        ServiceLayer -> AppointmentBooker "Send processed appointment events"
        AppointmentBooker -> appointmentQueue "Sends booked appointment for invitation"
        appointmentQueue -> PathwayCoordinator "Publishes appointment"
        pathwayCoordinator_ProductEventsQueue -> CommunicationsManager "Send appointment with pathway definition"
        nhsNotify -> CommunicationsManager "Sends back invitation status"
        CommunicationsManager -> PathwayCoordinator "Sends back invitation status payload"
        PathwayCoordinator -> ParticipantManager "Update episodes with appointment statuses"
        PathwayCoordinator -> AppointmentBooker "Update appointment invitation status"

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
         businessAudit_queue -> businessAudit_db "Writes audit data "
         businessAudit_api -> businessAudit_db "Reads audit data"
         businessAudit_api -> businessAudit_UserInterface  "Send participant audit log data "
         cohortManager -> businessAudit_queue "Writes eligibility changes, demographic and transformation changes"
         CommunicationsManager -> businessAudit_queue "Writes appointment invitation statuses"
         AppointmentBooker -> businessAudit_queue "Write appointment booking log"

        # Participant manager
        u -> nhsLogin "Authenticates using"
        participantManager_externalWebApp -> nhsLogin  "Protects using"
        participantManager_ExperienceAPI -> nhsLogin "Protects API using"
        u -> nhsApp "Accesses secure NHS services using"
        nhsApp -> participantManager_externalWebApp "Interacts with screening service using"
        u -> participantManager_externalWebApp "Interacts with screening service using"
        u1 -> participantManager_noAuthWebApp "Access low security information using"

        participantManager_externalWebApp -> participantManager_ExperienceAPI "Retrieves data using"
        participantManager_internalWebapp -> participantManager_ExperienceAPI "Retrieves data using"
        participantManager_noAuthWebApp -> participantManager_ExperienceAPI "Retrieves data using"

        participantManager_ExperienceAPI -> participantManager_API "Accesses data using"
        participantManager_API -> participantManager_database "Accesses data using"
        participantManager_ProductEventHandler -> participantManager_API "Accesses data using"



        
        st -> participantManager_internalWebapp "Interacts with participant screening history using"
        nhsCIS2 -> participantManager_internalWebapp "Logs on via"
        participantManager_ExperienceAPI -> nhsCIS2 "Protects API using"


        # Pathway Coordinator
        cohortManager -> pathwayCoordinator_API "Published New Eligible Participant Event using"
        SLtoPC = serviceLayer -> pathwayCoordinator_API "Publishes participant level event to"
        pathwayCoordinator_ParticipantEventHandler -> pathwayCoordinator_ParticipantEventsQueue "Subscribes to messages from"
        pathwayCoordinator_ParticipantEventHandler -> pathwayManager_API "Accesses pathway definition using"
        pathwayCoordinator_ParticipantEventHandler -> pathwayCoordinator_ProductEventsQueue "Communicates with the products using"
        contextManager_ParticipantEventHandler -> pathwayCoordinator_ParticipantEventsQueue "Subscribes to messages from"
        contextManager_ParticipantEventHandler -> contextManager_API "Updates data using"
        pathwayManager_API -> pathwayManager_database "Accesses data from"
        contextManager_API -> contextManager_database "Accesses data from"
        contextManager_internalWebapp -> contextManager_API "Displays data using"
        pathwayManager_internalWebapp -> pathwayManager_API "Displays data using"
        st -> pathwayManager_internalWebapp "Interacts with participant screening history using"
        nhsCIS2 -> pathwayManager_internalWebapp "Logs on via"
        pathwayManager_API -> nhsCIS2 "Protects API using"
        st -> contextManager_internalWebapp "Interacts with participant screening history using"
        nhsCIS2 -> contextManager_internalWebapp "Logs on via"
        contextManager_API -> nhsCIS2 "Protects API using"
        pathwayCoordinator_API -> pathwayManager_API "Retrieves schema information using"
        pathwayCoordinator_API -> pathwayCoordinator_ParticipantEventsQueue "Adds validated messages to"
        pathwayCoordinator_ProductEventsQueue -> participantManager_ProductEventHandler "Publishes messages to"
        


        # Screening Event Manager
        st -> sem_internalWebapp "Manages SEM clinical information using"
        st -> nhsCIS2 "Authenticates using"
        sem_internalWebapp -> sem_database "Reads/Writes data from/to" 
        sem_internalOrchestrationWorkflowApp -> sem_database "Reads/Writes data from/to"
        pathwayCoordinator_ProductEventsQueue -> sem_internalOrchestrationWorkflowApp "Executes clinical investigation using"
        sem_internalOrchestrationWorkflowApp -> serviceLayer "Communicates with"
        nhsCIS2 -> sem_internalWebapp "Provides national authentication & authorisation services to"

        # Service Layer
        serviceLayer_API -> serviceLayer_ProcessingQueue "Adds messages for processing using"
        serviceLayer_MeshMailbox -> serviceLayer_ProcessingQueue "Adds messages for processing using"
        serviceLayer_DataProcessor -> serviceLayer_ProcessingQueue "Subscribes to queue"
        serviceLayer_DataProcessor -> pathwayCoordinator_API "Emits events for processing using"
        NBSS -> serviceLayer_MeshMailbox "Sends data via"

        # Communication Manager
        pathwayCoordinator_ProductEventsQueue -> communicationsManager_eventAPI "Send participant comms event with pathway definition"
        communicationsManager_eventAPI -> communicationManager_EventHandler "Send communication event"
        communicationManager_EventHandler -> communicationManager_BusinessLogic "Get Business Logic"
        communicationManager_EventHandler -> communicationManager_Extpayloadprocessor "Send events to process"
        communicationManager_Extpayloadprocessor -> communicationManager_DBStore "Store payload"
        communicationManager_NotifyAPI -> communicationManager_DBStore "Get the payload "
        communicationManager_NotifyAPI -> nhsNotify "Send Payload"

    }

    views {

        systemLandscape dtosSystemContext "Overall system landscape"{
            include *
        }

        systemLandscape dtos5thTeamContext "Core focus of the 5th team"{
            include NBSS
            include CSMS
            include DES
            include AAA
            include Bowel
            include serviceLayer
            include pathwayCoordinator
            include businessAudit
        }

        systemLandscape dtosSystemAppointmentBookContext "Appointment Data Processing Context Diagram"{
            include NBSS
            include serviceLayer
            include appointmentBooker
            include pathwayCoordinator
            include participantManager
            include communicationsManager
            include nhsNotify
            include appointmentQueue
            
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
        }
        container screeningEventManager ScreeningEventManager {
            include *
            autoLayout lr
            exclude SLtoPC
        }
        container participantManager ParticipantManager {
            include *
        }

        container participantManager ParticipantManager_Alpha {
            include participantManager_API participantManager_database participantManager_ExperienceAPI participantManager_ProductEventHandler
            include participantManager_externalWebApp u nhsLogin
            
        }

        container serviceLayer ServiceLayer {
            include *
        }
        
        component participantManager_API ParticipantManagerAPI { 
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