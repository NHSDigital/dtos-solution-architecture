
businessAudit = softwareSystem "Business Audit" "Service that provides immutable audit datastore used for analysis and non-repudiation"{
    !docs docs
    inboundQueue = container "Audit log queue"
    API = container " Read Audit Data Api"
    db = container "Audit datastore" "Immutable audit data store containing all audit information" "Database" "Database" 
    web = container "Audit User Interface" "Search and Display participants sequence of event"
}
