systemContext participantManager "ParticipantManagerSystemContext" "Target System Context Diagram" {
    include *
    autolayout lr
}

container participantManager ParticipantManager {
    include *
}

container participantManager ParticipantManager_Alpha {
    include participantManager.API participantManager.db participantManager.experienceAPI participantManager.productEventHandler
    include participantManager.externalWebApp u nhsLogin
    
}

component participantManager.API ParticipantManagerAPI { 
    include *
    autoLayout lr
}