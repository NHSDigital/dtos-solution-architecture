workspace "Digital Transformation of Screening" "High level context diagram for all products within Digital Transformation of Screening" {
    !docs workspace-docs
    !identifiers hierarchical
    
    model {
        properties {
            "structurizr.groupSeparator" "/"
        }

        # In this file, try and define the common elements across the solution. Generally those items that sit outside of Screening
        # Specifically things like external systems or users. 

        # User Types

        u = person "P9 Participant users" "External user eligible for screening" "Participant"
        u1 = person "Unauthenticated Participant users" "External users without NHS Login account" "Participant"

        st = person "Staff users" "Internal staff users including clinical and administrative staff" "NHS Staff"
        s = person "Secondary users" "Internal users, but not concerned with day to day operations" "NHS Staff"


        # External Systems and Services

        nhsNotify = softwareSystem "NHS Notify" "NHS Wide service for providing communication to the Citizen" "External System"
        nhsLogin = softwareSystem "NHS Login" "NHS Wide service for authenticating the Citizen" "External System"
        nhsCIS2 = softwareSystem "Care Identity Service (CIS)" "NHS Wide service for authenticating Staff" "External System"
        nhsApp = softwareSystem "NHS App" "National Mobile Application for NHS" "External System" 
        localTrustSystem = softwareSystem "Local Trust System" "Local Trust System" "External System"
        NBSS = softwareSystem "National Breast Screening Service" "External Service used for managing breast screening" "External System"
        CSMS = softwareSystem "Cervical Screening Management System" "External Service used for managing cervical screening" "External System"
        Bowel = softwareSystem "Bowel Screening System" "External Service used for managing bowel screening" "External System"
        DES = softwareSystem "Diabetic Eye Screening" "External Service used for managing diabetic eye screening" "External System"
        AAA = softwareSystem "Abdominal aortic aneurysm" "External Service used for managing AAA screening" "External System"
        BSSelect = softwareSystem "Breast Screening Select" "NHSE Service used to manage the cohort of participants for breast screening" "External System"
        PDS = softwareSystem "PDS" "NHS Demographic Service" "External System"
        ServiceNow = softwareSystem "Service Now" "Ticketing service" "External System"
        NEIMS = softwareSystem "NEIMS" "Demographic Change Event" "External System"
        CaaS = softwareSystem "Cohorting as a Service" "Service which produces a list of eligible participants based on a cohort definition" "External System"
        NDRS = softwareSystem "NDRS" "Data source for VHR referral" "External System"
        ITOC = softwareSystem "ITOC" "Centralised Monitoring Log" "External System"

        # Include files to models of NSP only services
        !include appointmentallocator/appointment_allocator_model.dsl
        !include appointmentbooker/appointment_booker_model.dsl
        !include bianddataanalysis/bi_and_data_analysis_model.dsl
        !include businessaudit/business_audit_model.dsl
        !include campaignmanager/campaign_manager_model.dsl
        !include capacityanddemandplanner/capacity_and_demand_planner_model.dsl
        !include capacitymanager/capacity_manager_model.dsl
        !include cohortmanager/cohort_manager_model.dsl
        !include communicationsmanager/communications_manager_model.dsl          
        !include participantmanager/participant_manager_model.dsl          
        !include participantsupport/participant_support_model.dsl     
        !include pathwaycoordinator/pathway_coordinator_model.dsl
        !include screeningeventmanager/screening_event_manager_model.dsl
        !include servicelayer/service_layer_model.dsl


        # Include files to the relationships within an NSP product.
        # !! Remember to include only those relationships where the product initiates communication !!
        !include appointmentallocator/appointment_allocator_rels.dsl
        !include appointmentbooker/appointment_booker_rels.dsl
        !include bianddataanalysis/bi_and_data_analysis_rels.dsl
        !include businessaudit/business_audit_rels.dsl
        !include campaignmanager/campaign_manager_rels.dsl
        !include capacityanddemandplanner/capacity_and_demand_planner_rels.dsl
        !include capacitymanager/capacity_manager_rels.dsl
        !include cohortmanager/cohort_manager_rels.dsl
        !include communicationsmanager/communications_manager_rels.dsl          
        !include participantmanager/participant_manager_rels.dsl          
        !include participantsupport/participant_support_rels.dsl         
        !include pathwaycoordinator/pathway_coordinator_rels.dsl         
        !include screeningeventmanager/screening_event_manager_rels.dsl
        !include servicelayer/service_layer_rels.dsl         

        
        # Externally initiated relationships

        Caas -> NDRS "Get VHR referral"  
        NBSS -> serviceLayer "Sends breast screening data to"
        CSMS -> serviceLayer "Sends cervical screening data to"
        Bowel -> serviceLayer "Sends bowel screening data to"
        DES -> serviceLayer "Sends DES screening data to"
        AAA -> serviceLayer "Sends AAA screening data to"
        nhsNotify -> CommunicationsManager "Sends back invitation status"
        u -> nhsLogin "Authenticates using"
        u -> nhsApp "Accesses secure NHS services using"
        nhsApp -> participantManager.participantManager_externalWebApp "Interacts with screening service using"
        nhsCIS2 -> participantManager.participantManager_internalWebapp "Logs on via"
        ServiceNow -> cm.snowIntegration
        NEIMS -> cm.NEMSIntegration "Sent via MESH Mailbox"
        CaaS -> cm.caasIntegration.retrieveMeshFile "Sent via Mesh Mailbox"
        ServiceNow -> cm "HTTP request"
        PDS -> cm pds "HTTP request"
        NBSS -> serviceLayer.serviceLayer_MeshMailbox "Sends data via"

    }

    views {


        properties {
            "c4plantuml.elementProperties" "true"
            "c4plantuml.tags" "true"
            "generatr.style.colors.primary" "#485fc7"
            "generatr.style.colors.secondary" "#ffffff"
            "generatr.style.faviconPath" "site/favicon.ico"
            "generatr.style.logoPath" "site/logo.png"

            // Absolute URL's like "https://example.com/custom.css" are also supported
            "generatr.style.customStylesheet" "site/custom.css"

            "generatr.svglink.target" "_self"

            // Full list of available "generatr.markdown.flexmark.extensions"
            // "Abbreviation,Admonition,AnchorLink,Aside,Attributes,Autolink,Definition,Emoji,EnumeratedReference,Footnotes,GfmIssues,GfmStrikethroughSubscript,GfmTaskList,GfmUsers,GitLab,Ins,Macros,MediaTags,ResizableImage,Superscript,Tables,TableOfContents,SimulatedTableOfContents,Typographic,WikiLinks,XWikiMacro,YAMLFrontMatter,YouTubeLink"
            // see https://github.com/vsch/flexmark-java/wiki/Extensions
            // ATTENTION:
            // * "generatr.markdown.flexmark.extensions" values must be separated by comma
            // * it's not possible to use "GitLab" and "ResizableImage" extensions together
            // default behaviour, if no generatr.markdown.flexmark.extensions property is specified, is to load the Tables extension only
            "generatr.markdown.flexmark.extensions" "Abbreviation,Admonition,AnchorLink,Attributes,Autolink,Definition,Emoji,Footnotes,GfmTaskList,GitLab,MediaTags,Tables,TableOfContents,Typographic"

            "generatr.site.exporter" "structurizr"
            "generatr.site.externalTag" "External System"
            "generatr.site.nestGroups" "false"
            "generatr.site.cdn" "https://cdn.jsdelivr.net/npm"
            "generatr.site.theme" "auto"
        }
        systemLandscape "SystemLandscape" "Overall system landscape"{
            include *
            autoLayout 
        }

        !include appointmentallocator/appointment_allocator_views.dsl
        !include appointmentbooker/appointment_booker_views.dsl
        !include bianddataanalysis/bi_and_data_analysis_views.dsl
        !include businessaudit/business_audit_views.dsl
        !include campaignmanager/campaign_manager_views.dsl
        !include capacityanddemandplanner/capacity_and_demand_planner_views.dsl
        !include capacitymanager/capacity_manager_views.dsl
        !include cohortmanager/cohort_manager_views.dsl
        !include communicationsmanager/communications_manager_views.dsl          
        !include participantmanager/participant_manager_views.dsl          
        !include participantsupport/participant_support_views.dsl   
        !include pathwaycoordinator/pathway_coordinator_views.dsl   
        !include screeningeventmanager/screening_event_manager_views.dsl
        !include servicelayer/service_layer_views.dsl

        
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
        }
         
         styles {
            element "Person" {
                color #ffffff
                fontSize 22
                shape Person
            }
            element "Participant" {
                background #686868
            }
            element "NHS Staff" {
                background #08427B
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "External System" {
                background #686868
            }
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
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
            element "Queue" {
                shape "Pipe"
            }
            element "Component" {
                background #85bbf0
                color #000000
            }
        }
    }

}