public with sharing class SurveyAppointmentBooking_Handler {
    public static void executable(List<Contact> contactList) {
    	List<Contact> contactExecutableList = new List<Contact>();
    	for(Contact contactInstance : contactList) 
    		if(contactInstance.Booking_DateTime__c != null)
    			contactExecutableList.add(contactInstance);
    	execute(contactExecutableList);
    }
    public static void execute(List<Contact> contactList) {
    	List<Event> eventList = new List<Event>();
    	Survey_Appointment_Company_Setting__c companySetting = Survey_Appointment_Company_Setting__c.getValues('Company Location');
    	Survey_Appointment_Time_Setting__c timeSetting = Survey_Appointment_Time_Setting__c.getValues('Survey Appointment Time');
    	List<User> userList = [
    		SELECT Id
    			 , CreatedDate 
    		  FROM User 
    		 WHERE ProfileId IN (SELECT Id 
    		 					   FROM Profile 
    		 					  WHERE Name = :companySetting.AssignTo_User__c
    		 					)
    	];
    	User adminUser;
    	if(userList.size() == 1)
    		adminUser = userList[0];
    	else
    		for(User userInstance1 : userList)
    			for(User userInstance2 : userList)
    				if(userInstance1 != userInstance2) {
    					if(userInstance1.CreatedDate < userInstance2.CreatedDate)
    						adminUser = userInstance1;
    					else
    						adminUser = userInstance2;
    				}
    	for(Contact contactInstance : contactList)
    		eventList.add(new Event(OwnerId = adminUser.Id , DurationInMinutes = (Integer) timeSetting.Time_Slot_Difference__c , WhoId = contactInstance.Id , Subject = companySetting.Event_Subject__c , StartDateTime = contactInstance.Booking_DateTime__c , EndDateTime = contactInstance.Booking_DateTime__c.addMinutes((Integer) timeSetting.Time_Slot_Difference__c)));
    	insert eventList;
    }
}