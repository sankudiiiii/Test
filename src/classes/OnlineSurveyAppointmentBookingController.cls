public with sharing class OnlineSurveyAppointmentBookingController {
    public String customerPostalCode{get; set;}
    public Date bookingDate{get; set;}
    public String distance;
    public String timeToReach;
    public String selectedTimeSlot{get; set;}
    public List<SelectOption> availableTimeSlotOptionList;
    public Survey_Appointment_Time_Setting__c timeSetting;
    public Survey_Appointment_Company_Setting__c companySetting;
    public Google_Distance_Matrix_API_Setting__c apiSetting;
    public Survey_Appointment_Message_Setting__c messageSetting;
    public String firstName{get; set;}
    public String lastName{get; set;}
    public String email{get; set;}
    public String country{get; set;}
    public String state{get; set;}
    public String city{get; set;}
    public String address{get; set;}
    public String minDate;
    public String formattedBookingDate;
    public List<Event> eventList;
    public List<Contact> contactList;
    public User adminUser;
    public DateTime currentDateTime;
    public OnlineSurveyAppointmentBookingController() {
    	setCompanySetting(Survey_Appointment_Company_Setting__c.getValues('Company Location'));
    	setTimeSetting(Survey_Appointment_Time_Setting__c.getValues('Survey Appointment Time'));
    	setApiSetting(Google_Distance_Matrix_API_Setting__c.getValues('Google Distance Matrix API'));
    	setMessageSetting(Survey_Appointment_Message_Setting__c.getValues('Survey Appointment Message'));
    	setDistance('');
    	setTimeToReach('');
    	availableTimeSlotOptionList = new List<SelectOption>();
    	setMinDate(System.today());
    	bookingDate = System.today();
    	currentDateTime = System.now();
    }
    public void setEventList(){
    	eventList = [
    		SELECT StartDateTime
    			 , EndDateTime 
    			 , ActivityDate
    		  FROM Event
    	];
    }
    public List<Event> getEventList(){
    	return eventList;
    }
    public void setContactList(){
    	contactList = [
    		SELECT Id
    			 , Email
    		  FROM Contact
    	];
    }
    public List<Contact> getContactList(){
    	return contactList;
    }
    public void setAdminUser(){
    	List<User> userList = [
	    	SELECT Id
    			 , CreatedDate 
    	  	  FROM User 
		 	 WHERE ProfileId IN (SELECT Id 
    						   	   FROM Profile 
    		 					  WHERE Name = :companySetting.AssignTo_User__c
    		 					)
    		   AND IsActive = true 
    	];
    	System.debug(userList);
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
    }
    public User getAdminUser(){
    	return adminUser;
    }
    public void setDistance(String str) {
    	distance = str;
    }
    public String getDistance() {
    	return distance;
    }
    public void setMinDate(Date dt) {
    	String min = dt.year() + '-';
    	if(dt.month() < 10)
    		min += '0';
    	min += dt.month() + '-' + dt.day();
    	minDate = min;
    }
    public String getMinDate() {
    	return minDate;
    }
    public void setFormattedBookingDate(Date dt) {
    	formattedBookingDate = dt.format();
    }
    public String getFormattedBookingDate() {
    	return formattedBookingDate;
    }
    public void setTimeToReach(String str) {
    	timeToReach = str;
    }
    public String getTimeToReach() {
    	return timeToReach;
    }
    public void setCompanySetting(Survey_Appointment_Company_Setting__c cSetting) {
    	companySetting = cSetting;
    }
    public Survey_Appointment_Company_Setting__c getCompanySetting() {
    	return companySetting;
    }
    public void setTimeSetting(Survey_Appointment_Time_Setting__c tSetting) {
    	timeSetting = tSetting;
    }
    public Survey_Appointment_Time_Setting__c getTimeSetting() {
    	return timeSetting;
    }
    public void setApiSetting(Google_Distance_Matrix_API_Setting__c aSetting) {
    	apiSetting = aSetting;
    }
    public Google_Distance_Matrix_API_Setting__c getApiSetting() {
    	return apiSetting;
    }
    public void setMessageSetting(Survey_Appointment_Message_Setting__c mSetting) {
    	messageSetting = mSetting;
    }
    public Survey_Appointment_Message_Setting__c getMessageSetting() {
    	return messageSetting;
    }
    public void setAvailableTimeSlotOptionList() {
    	setEventList();
    	setAdminUser();
    	Time startTime = Time.newInstance((Integer) timeSetting.Start_Time_Hours__c , (Integer) timeSetting.Start_Time_Minutes__c , 0 , 0);
    	Time endTime = Time.newInstance((Integer) timeSetting.End_Time_Hours__c , (Integer) timeSetting.End_Time_Minutes__c , 0 , 0);
    	List<Time> timeList = new List<Time>();
    	do {
    		boolean flag = true;
    		for(Event eventObj : getEventList())
    			if(bookingDate == eventObj.ActivityDate)
    				if(startTime >= eventObj.StartDateTime.time() && startTime< eventObj.EndDateTime.time()){
    					flag = false;
    					break;
    				}	
    		if(flag)
    			timeList.add(startTime);
			startTime = startTime.addMinutes((Integer) timeSetting.Time_Slot_Difference__c);
		} while(startTime <= endTime);
		List<SelectOption> options = new List<SelectOption>();
    	for(Time dt : timeList) {
			if(bookingDate == System.today()) {
	    		if(currentDateTime.time().hour() < 8 || (currentDateTime.time().hour() == 8 && currentDateTime.time().minute() < 30)) {			//from 12.30 
    				if(dt.hour() > 12 || (dt.hour() == 12 && dt.minute() >= 30))
    					options.add(new SelectOption(String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute()) , String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute())));
	    		} else 		//now + 4
    				if(dt.hour() > currentDateTime.time().addHours(4).hour() || (dt.hour() == currentDateTime.time().addHours(4).hour() && dt.minute() >= currentDateTime.time().minute()))
    					options.add(new SelectOption(String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute()) , String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute())));
	    	} else if(bookingDate == System.today().addDays(1)) {
    			if(currentDateTime.time().hour() < 17 || (currentDateTime.time().hour() == 17 && currentDateTime.time().minute() < 30))		//all
					options.add(new SelectOption(String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute()) , String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute())));
    			else 		//from 12.30
	   				if(dt.hour() > 12 || (dt.hour() == 12 && dt.minute() >= 30))
   						options.add(new SelectOption(String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute()) , String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute())));
	    	} else		//all
				options.add(new SelectOption(String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute()) , String.valueOf(dt.hour()) + ':' + String.valueOf(dt.minute())));
		}
    	availableTimeSlotOptionList = options;
    	if(availableTimeSlotOptionList != null && availableTimeSlotOptionList.size() > 0)
    		selectedTimeSlot = availableTimeSlotOptionList[0].getValue();
    } 
    public List<SelectOption> getAvailableTimeSlotOptionList() {
    	return availableTimeSlotOptionList;
    }
    public PageReference getTimeAndDistance() {
    	setDistance('');
    	setTimeToReach('');
    	firstName='';
    	lastName='';
    	email='';
    	address='';
    	city='';
    	state='';
    	country='';
    	setFormattedBookingDate(bookingDate);
    	if(bookingDate == System.today() && (currentDateTime.hour() > 15 || (currentDateTime.hour() == 15 && currentDateTime.minute() > 30)))
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING , messageSetting.Today_Timeout_Message__c));
    	else {
	    	Decimal tempDistance;
    		Integer tempTimeToReach;
    		Http httpObj = new Http();
			HttpRequest request = new HttpRequest();
			HttpResponse response;
			request.setMethod('GET');
			request.setEndpoint(apiSetting.Base_URL__c + apiSetting.Response_Type__c + '?origins=' + companySetting.Company_Postal_Code__c + '&destinations=' + customerPostalCode + '&language=' + apiSetting.Language__c + '&sensor=' + apiSetting.Sensor__c);
			response = httpObj.send(request);
			System.debug(customerPostalCode);
			System.debug(request);
			System.debug(response.getBody());
			JSONWrapperDemo wrapperObj = (JSONWrapperDemo) JSON.deserialize(response.getBody() , JSONWrapperDemo.class);
			if(wrapperObj.status == 'OK' && wrapperObj.rows[0].elements[0].status == 'OK') {
				if(wrapperObj.rows[0].elements[0].duration.value > companySetting.Reachable_Time_in_Seconds__c)
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO , messageSetting.Failed_to_Reach_Message__c));
				else {
					tempTimeToReach = (Integer) wrapperObj.rows[0].elements[0].duration.value;
					tempDistance = wrapperObj.rows[0].elements[0].distance.value;
					distance = String.valueOf(tempDistance / 1000) + ' km';
					timeToReach = String.valueOf(tempTimeToReach / 3600) + ' hr ';
					timeToReach += String.valueOf(tempTimeToReach / 60) + ' min';
					list<String> tempAddress = wrapperObj.destination_addresses[0].split(',');
					city = tempAddress[0];
					state = tempAddress[1].split(' ')[1];
					country = tempAddress[2].split(' ')[1];
					setAvailableTimeSlotOptionList();
				}
			} else if(wrapperObj.status == 'OK' && wrapperObj.rows[0].elements[0].status != 'OK')
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL , messageSetting.API_Result_Failure_Message__c));
			else 
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL , messageSetting.API_Failure_Message__c));
    	}
		return null;
    }
    public PageReference bookAppointment() {
    	setContactList();
    	DateTime bookingDateTime = DateTime.newInstance(bookingDate , Time.newInstance(Integer.valueOf(selectedTimeSlot.split(':')[0]) , Integer.valueOf(selectedTimeSlot.split(':')[1]) , 0 , 0));
    	try {
    		Contact contactObj;
    		boolean notPreviousCustomer = true;
    		for(Contact contactInstance : getContactList())
    			if(email == contactInstance.Email) {
    				notPreviousCustomer = false;
    				contactObj = contactInstance;
    			}    				
    		if(notPreviousCustomer) {
    			System.debug(lastName);
    			contactObj = new Contact(FirstName = firstName , LastName = lastName , email = email , OtherStreet = address , OtherCity = city , OtherState = state , OtherCountry = country , OtherPostalCode = customerPostalCode);
    			insert contactObj;
    		}
	    	customerPostalCode = '';
	    	bookingDate = System.today();
    		setDistance('');
    		setTimeToReach('');
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM , messageSetting.Success_Message__c));
    		try {
	    		Event eventObj = new Event(OwnerId = getAdminUser().Id , DurationInMinutes = (Integer) timeSetting.Time_Slot_Difference__c , WhoId = contactObj.Id , Subject = companySetting.Event_Subject__c , StartDateTime = bookingDateTime , EndDateTime = bookingDateTime.addMinutes((Integer) timeSetting.Time_Slot_Difference__c));
    			insert eventObj;
    		} catch (DMLException e) {
    			List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
    			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
				List<String> toAddresses = new List<String>();
				toAddresses.add(adminUser.Email);
				mail.setToAddresses(toAddresses);
				mail.setSubject('Event Creation Failed');
				String textBody = 'Failed to create event for customer ' + contactObj.FirstName + ' ' + contactObj.LastName + ' for booking date ' + bookingDateTime;
				mail.setPlainTextBody(textBody);
				mailList.add(mail);
				Messaging.sendEmail(mailList , false);
    		}
    	} catch (DMLException e) {
    		System.debug(e);
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , e.getDMLMessage(0)));
    	}
    	return null;
    }
    public PageReference reset() {
    	PageReference pageRef = new pageReference('/apex/Online_Appointment_Booking_Page'); 
    	pageRef.setRedirect(true);
		return pageRef;
    }
    public PageReference clearOnChange(){
    	setDistance('');
    	setTimeToReach('');
    	firstName='';
    	lastName='';
    	email='';
    	address='';
    	city='';
    	state='';
    	country='';
    	return null;
    }
}