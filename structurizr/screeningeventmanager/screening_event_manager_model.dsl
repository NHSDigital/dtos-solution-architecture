screeningEventManager = softwareSystem "Screening Event Manager" "Service for coordinating and capturing the clinical investigation processes" {
    !docs docs
    sem_internalWebapp = container "Staff Facing SEM Web Application" "Internal facing web application for staff to manage SEM clinical information" "Web App" "Web Browser"
    sem_database = container "SEM datastore" "System of record datastore for screening event clinical information" "Database" "Database"
    sem_internalOrchestrationWorkflowApp = container "SEM Orchestration Workflow" "Server App"
}
