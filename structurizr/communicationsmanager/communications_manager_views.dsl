
systemContext communicationsManager "CurrentCommunicationsManagerSystemContext"{
    title "Current Communications Manager System Context Diagram"
    include nhsNotify
    autoLayout lr
}

systemContext communicationsManager "TargetCommunicationsManagerSystemContext" {
    title "Target Communications Manager System Context Diagram"
    include *
    autolayout lr
}


container communicationsManager "TargetCommunicationsManager" {
    title "Target Communications Manager Container Diagram"
    include *
    autoLayout lr
}