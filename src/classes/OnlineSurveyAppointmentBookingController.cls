public with sharing class OnlineSurveyAppointmentBookingController {
    public String customerPostalCode{get; set;}
    public Date bookingDate{get; set;}
    public String distance;
    public String timeToReach;
    public String selectedTimeSlot{get; set;}
    public List<SelectOption> availableTimeSlotOptionList;
    Survey_Appointment_Time_Setting__c timeSetting;
    Survey_Appointment_Company_Setting__c companySetting;
    Google_Distance_Matrix_API_Setting__c apiSetting;
    Survey_Appointment_Message_Setting__c messageSetting;
    public String firstName{get; set;}
    public String lastName{get; set;}
    public String email{get; set;}
    public String country{get; set;}
    public String state{get; set;}
    public String city{get; set;}
    public String address{get; set;}
    public OnlineSurveyAppointmentBookingController() {
    	setCompanySetting(Survey_Appointment_Company_Setting__c.getValues('Company Location'));
    	setTimeSetting(Survey_Appointment_Time_Setting__c.getValues('Survey Appointment Time'));
    	setApiSetting(Google_Distance_Matrix_API_Setting__c.getValues('Google Distance Matrix API'));
    	setMessageSetting(Survey_Appointment_Message_Setting__c.getValues('Survey Appointment Message'));
    	setDistance('');
    	setTimeToReach('');
    	availableTimeSlotOptionList = new List<SelectOption>();
    }
    public void setDistance(String str) {
    	distance = str;
    }
    public String getDistance() {
    	return distance;
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
    	Time startTime = Time.newInstance((Integer) timeSetting.Start_Time_Hours__c , (Integer) timeSetting.Start_Time_Minutes__c , 0 , 0);
    	Time endTime = Time.newInstance((Integer)timeSetting.End_Time_Hours__c,(Integer)timeSetting.End_Time_Minutes__c,0,0);
    	List<Time> timeList = new List<Time>();
    	do{
    		timeList.add(startTime);
			startTime = startTime.addMinutes((Integer)timeSetting.Time_Slot_Difference__c);
		}while(startTime <= endTime);
		System.debug(timeList);
    	List<SelectOption> options = new List<SelectOption>();
    	if(bookingDate == System.today()){
    		if(System.now().hour()<8 || (System.now().hour()==8 && System.now().minute()<30)){
    			//from 12.30 
    			for(Time dt : timeList){
    				if(dt.hour()>12 || (dt.hour() == 12 && dt.minute() >=30)){
    					options.add(new SelectOption(String.valueOf(dt.hour())+':'+String.valueOf(dt.minute()),String.valueOf(dt.hour())+':'+String.valueOf(dt.minute())));
    				}
    			}
    		} else if(System.now().hour()<15 || (System.now().hour()==15 && System.now().minute()<30)){
    			//now + 4
    			for(Time dt : timeList){
    				if(dt.hour()>System.now().time().addHours(4).hour() || (dt.hour() == System.now().time().addHours(4).hour() && dt.minute() >=System.now().time().minute())){
    					options.add(new SelectOption(String.valueOf(dt.hour())+':'+String.valueOf(dt.minute()),String.valueOf(dt.hour())+':'+String.valueOf(dt.minute())));
    				}
    			}
    		} else {
    			setDistance('');
    			setTimeToReach('');
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING , messageSetting.Today_Timeout_Message__c));
    		}
    	} else if(bookingDate == System.today().addDays(1)) {
    		if(System.now().hour()<17 || (System.now().hour()==17 && System.now().minute()<30)){
    			//all
    			for(Time dt : timeList){
    					options.add(new SelectOption(String.valueOf(dt.hour())+':'+String.valueOf(dt.minute()),String.valueOf(dt.hour())+':'+String.valueOf(dt.minute())));
    			}
    		} else {
    			//from 12.30
    			for(Time dt : timeList){
    				if(dt.hour()>12 || (dt.hour() == 12 && dt.minute() >=30)){
    					options.add(new SelectOption(String.valueOf(dt.hour())+':'+String.valueOf(dt.minute()),String.valueOf(dt.hour())+':'+String.valueOf(dt.minute())));
    				}
    			}
    		}
    	} else {
    		//all
    		for(Time dt : timeList){
    					options.add(new SelectOption(String.valueOf(dt.hour())+':'+String.valueOf(dt.minute()),String.valueOf(dt.hour())+':'+String.valueOf(dt.minute())));
    		}
    	}
    	System.debug(options);
    	availableTimeSlotOptionList = options;
    	if(availableTimeSlotOptionList != null && availableTimeSlotOptionList.size() >0)
    	selectedTimeSlot = availableTimeSlotOptionList[0].getValue();
    } 
    public List<SelectOption> getAvailableTimeSlotOptionList(){
    	return availableTimeSlotOptionList;
    }
    
    public PageReference getTimeAndDistance(){
    	setDistance('');
    	setTimeToReach('');
    	Decimal tempDistance;
    	Integer tempTimeToReach;
    	Http httpObj = new Http();
		HttpRequest request = new HttpRequest();
		HttpResponse response;
		request.setMethod('GET');
		request.setEndpoint(apiSetting.Base_URL__c+apiSetting.Response_Type__c+'?origins='+companySetting.Company_Postal_Code__c+'&destinations='+customerPostalCode+'&language='+apiSetting.Language__c+'&sensor='+apiSetting.Sensor__c);
		response = httpObj.send(request);
		JSONWrapperDemo wrapperObj = (JSONWrapperDemo )JSON.deserialize(response.getBody(), JSONWrapperDemo.class);
		if(wrapperObj.status == 'OK' && wrapperObj.rows[0].elements[0].status == 'OK'){
			if(wrapperObj.rows[0].elements[0].duration.value > companySetting.Reachable_Time_in_Seconds__c)
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO , messageSetting.Failed_to_Reach_Message__c));
			else {
				tempTimeToReach = (Integer) wrapperObj.rows[0].elements[0].duration.value;
				tempDistance = wrapperObj.rows[0].elements[0].distance.value;
				distance = String.valueOf(tempDistance/1000)+' km';
				timeToReach = String.valueOf(tempTimeToReach/3600)+' hr ';
				timeToReach += String.valueOf(tempTimeToReach/60)+' min';
				list<String> tempAddress = wrapperObj.destination_addresses[0].split(',');
				city = tempAddress[0];
				state = tempAddress[1].split(' ')[1];
				country = tempAddress[2].split(' ')[1];
				setAvailableTimeSlotOptionList();
			}
		} else
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL , messageSetting.API_Failure_Message__c));
		return null;
    }
    public PageReference bookAppointment(){
    	DateTime bookingDateTime = DateTime.newInstance(bookingDate,Time.newInstance(Integer.valueOf(selectedTimeSlot.split(':')[0]),Integer.valueOf(selectedTimeSlot.split(':')[1]),0,0));
    	Contact contactObj = new Contact(FirstName=firstName,LastName=lastName,email=email,OtherStreet=address,OtherCity=city,OtherState=state,OtherCountry=country,OtherPostalCode=customerPostalCode,Booking_DateTime__c=bookingDateTime);
    	try{
	    	insert contactObj;
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM , messageSetting.Success_Message__c));
    		bookingDate=null;
    		customerPostalCode='';
    		setDistance('');
	    	setTimeToReach('');
    	} catch (DMLException e) {
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , e.getDMLMessage(0)));
    	}
    	return null;
    }
}    