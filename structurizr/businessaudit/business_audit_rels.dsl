businessAudit -> biandDataAnalysis "Publishes data to"
# Business Audit
businessAudit.businessAudit_queue -> businessAudit.businessAudit_db "Writes audit data "
businessAudit.businessAudit_api -> businessAudit.businessAudit_db "Reads audit data"
businessAudit.businessAudit_api -> businessAudit.businessAudit_UserInterface  "Send participant audit log data "
businessAudit -> pathwayCoordinator "Subscribes to events from"