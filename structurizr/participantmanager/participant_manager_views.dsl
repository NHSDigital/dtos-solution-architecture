systemContext participantManager "ParticipantManagerSystemContext" "Target System Context Diagram" {
    include *
    autolayout lr
}

container participantManager ParticipantManager {
    include *
}

container participantManager ParticipantManager_Alpha {
    include participantManager.participantManager_API participantManager.participantManager_database participantManager.participantManager_ExperienceAPI participantManager.participantManager_ProductEventHandler
    include participantManager.participantManager_externalWebApp u nhsLogin
    
}

component participantManager.participantManager_API ParticipantManagerAPI { 
    include *
    autoLayout lr
}