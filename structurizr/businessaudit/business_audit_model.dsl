
businessAudit = softwareSystem "Business Audit" "Service that provides immutable audit datastore used for analysis and non-repudiation"{
    !docs docs
    businessAudit_queue = container "Audit log queue"
    businessAudit_api = container " Read Audit Data Api"
    businessAudit_db = container "Audit datastore" "Immutable audit data store containing all audit information" "Database" "Database" 
    businessAudit_UserInterface = container "Audit User Interface" "Search and Display participants sequence of event"
}
