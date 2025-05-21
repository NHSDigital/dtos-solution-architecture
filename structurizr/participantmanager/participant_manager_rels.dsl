participantManager -> pathwayCoordinator "Notifies of participant ready for screening using"
participantManager -> businessAudit "Notifies of business audit events using"
participantManager -> biandDataAnalysis "Publishes data to"
u -> participantManager "Views screening information using"
st -> participantManager "Manages participant's episode using"

participantManager.participantManager_externalWebApp -> nhsLogin  "Protects using"
participantManager.participantManager_ExperienceAPI -> nhsLogin "Protects API using"
u -> participantManager.participantManager_externalWebApp "Interacts with screening service using"
u1 -> participantManager.participantManager_noAuthWebApp "Access low security information using"

participantManager.participantManager_externalWebApp -> participantManager.participantManager_ExperienceAPI "Retrieves data using"
participantManager.participantManager_internalWebapp -> participantManager.participantManager_ExperienceAPI "Retrieves data using"
participantManager.participantManager_noAuthWebApp -> participantManager.participantManager_ExperienceAPI "Retrieves data using"

participantManager.participantManager_ExperienceAPI -> participantManager.participantManager_API "Accesses data using"
participantManager.participantManager_API -> participantManager.participantManager_database "Accesses data using"
participantManager.participantManager_ProductEventHandler -> participantManager.participantManager_API "Accesses data using"

st -> participantManager.participantManager_internalWebapp "Interacts with participant screening history using"
participantManager.participantManager_ExperienceAPI -> nhsCIS2 "Protects API using"
