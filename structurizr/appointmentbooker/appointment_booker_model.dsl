appointmentBooker = softwareSystem "Appointment Booker" "Service for both participant and staff to manage appointments"{
    !docs docs
    appointmentBooker_userWeb = container "Participant facing web interface" "External facing web application to manage your booking" "Web App" "Web Browser"
    appointmentBooker_staffWeb = container "Staff facing web interface" "Internal facing web application use to manage appointment bookings and attendance" "Web App" "Web Browser"
    appointmentBooker_apiApp = container "API Layer" "API used to access underlying booking information" 
    appointmentBooker_db = container "Booking database" "Underlying booking data store" "Database" "Database"
    appointmentBooker_ProductEventHandler = container "Appointment Booker Product Event Handler" "Product events handler for Appointment Booker" ".net Azure Function"
    appointmentBooker_ProductEventQueue = container "Appointment Booker Event Queue" "Inbound event queue for Appointment Booker" "Event Grid Topic" "Queue"
}