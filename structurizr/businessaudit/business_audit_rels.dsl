businessAudit -> biandDataAnalysis "Publishes data to"
# Business Audit
businessAudit.inboundQueue -> businessAudit.db "Writes audit data "
businessAudit.API -> businessAudit.db "Reads audit data"
businessAudit.API -> businessAudit.web  "Send participant audit log data "
businessAudit -> pathwayCoordinator "Subscribes to events from"