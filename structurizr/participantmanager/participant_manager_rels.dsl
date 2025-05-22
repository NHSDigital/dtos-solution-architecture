participantManager -> pathwayCoordinator "Notifies of participant ready for screening using"
participantManager -> businessAudit "Notifies of business audit events using"
participantManager -> biandDataAnalysis "Publishes data to"
u -> participantManager "Views screening information using"
st -> participantManager "Manages participant's episode using"

participantManager.externalWebApp -> nhsLogin  "Protects using"
participantManager.experienceAPI -> nhsLogin "Protects API using"
u -> participantManager.externalWebApp "Interacts with screening service using"
u1 -> participantManager.noAuthWebApp "Access low security information using"

participantManager.externalWebApp -> participantManager.experienceAPI "Retrieves data using"
participantManager.internalWebapp -> participantManager.experienceAPI "Retrieves data using"
participantManager.noAuthWebApp -> participantManager.experienceAPI "Retrieves data using"

participantManager.experienceAPI -> participantManager.API "Accesses data using"
participantManager.API -> participantManager.db "Accesses data using"
participantManager.productEventHandler -> participantManager.API "Accesses data using"

st -> participantManager.internalWebapp "Interacts with participant screening history using"
participantManager.experienceAPI -> nhsCIS2 "Protects API using"
