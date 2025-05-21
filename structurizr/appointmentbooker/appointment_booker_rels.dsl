appointmentBooker -> businessAudit "Notifies of business audit events using"
appointmentBooker -> biandDataAnalysis "Publishes data to"
st -> appointmentBooker "Manages participant appointments using"
u -> appointmentBooker "Manages appointment using"

#Appointment Booker
u -> appointmentBooker.appointmentBooker_userWeb "Books appointments using"
st -> appointmentBooker.appointmentBooker_staffWeb "Manages appointments using"
appointmentBooker.appointmentBooker_userWeb -> appointmentBooker.appointmentBooker_apiApp "Accesses database using"
appointmentBooker.appointmentBooker_staffWeb -> appointmentBooker.appointmentBooker_apiApp "Access database using"
appointmentBooker.appointmentBooker_apiApp -> appointmentBooker.appointmentBooker_db "Reads/Writes data using"

AppointmentBooker -> businessAudit.businessAudit_queue "Write appointment booking log"