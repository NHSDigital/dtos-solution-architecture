appointmentBooker = softwareSystem "Appointment Booker" "Service for both participant and staff to manage appointments"{
    !docs docs
    userWeb = container "Participant facing web interface" "External facing web application to manage your booking" "Web App" "Web Browser"
    staffWeb = container "Staff facing web interface" "Internal facing web application use to manage appointment bookings and attendance" "Web App" "Web Browser"
    apiApp = container "API Layer" "API used to access underlying booking information" 
    db = container "Booking database" "Underlying booking data store" "Database" "Database"
    productEventHandler = container "Appointment Booker Product Event Handler" "Product events handler for Appointment Booker" ".net Azure Function"
    productEventQueue = container "Appointment Booker Event Queue" "Inbound event queue for Appointment Booker" "Event Grid Topic" "Queue"
}