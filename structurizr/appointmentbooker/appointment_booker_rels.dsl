appointmentBooker -> businessAudit "Notifies of business audit events using"
appointmentBooker -> biandDataAnalysis "Publishes data to"
st -> appointmentBooker "Manages participant appointments using"
u -> appointmentBooker "Manages appointment using"

#Appointment Booker
u -> appointmentBooker.userWeb "Books appointments using"
st -> appointmentBooker.staffWeb "Manages appointments using"
appointmentBooker.userWeb -> appointmentBooker.apiApp "Accesses database using"
appointmentBooker.staffWeb -> appointmentBooker.apiApp "Access database using"
appointmentBooker.apiApp -> appointmentBooker.db "Reads/Writes data using"

AppointmentBooker -> businessAudit.inboundQueue "Write appointment booking log"