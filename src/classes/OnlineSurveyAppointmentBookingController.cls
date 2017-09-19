public with sharing class OnlineSurveyAppointmentBookingController {
    public String customerPostalCode{get; set;}
    public Date bookingDate{get; set;}
    public Integer distance{get; set;}
    public Integer timeToReach{get; set;}
    Survey_Appointment_Company_Setting__c companySetting;
    public OnlineSurveyAppointmentBookingController(){
    	companySetting = Survey_Appointment_Company_Setting__c.getValues('Company Location');
    }
    public PageReference getTimeAndDistance(){
    	if(String.isBlank(customerPostalCode) && bookingDate==null)
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Please Enter Postal Code & Booking Date'));
    	else if(String.isBlank(customerPostalCode))
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Please Enter Postal Code'));
    	else if(bookingDate==null)
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Please Enter Booking Date'));
    	else if(!customerPostalCode.isAlphaNumericSpace() && bookingDate<System.today())
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Please Enter Valid Postal Code & Booking Date can not be less than today'));
    	else if(!customerPostalCode.isAlphaNumericSpace())
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Please Enter Valid Postal Code'));
    	else if(bookingDate<System.today())
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Booking Date can not be less than today'));
    	else { 
    		Http httpObj = new Http();
			HttpRequest request = new HttpRequest();
			HttpResponse response;
			request.setMethod('GET');
			request.setEndpoint('http://maps.googleapis.com/maps/api/distancematrix/json?origins='+ companySetting.get('Company_Postal_Code__c')+'&destinations='+ customerPostalCode +'&language=en-EN&sensor=false');
			response = httpObj.send(request);
			if(response.getStatusCode()!=200)
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Sorry..! We are unable to process your request at the moment. Please try after some time . For further queries drop us an email at “support@xyzcompany.com” and we will be glad to assist you.'));
			else {
				System.debug(request);
				System.debug(response.getBody());
				JSONParser parser = JSON.createParser(response.getBody());
				while (parser.nextToken() != null) 
					if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
						if(parser.gettext()=='distance')
							while(parser.nexttoken()!=null)
								if(parser.gettext()=='value'){
									parser.nexttoken();
									distance = parser.getintegervalue();
									break;
								}
						if(parser.gettext()=='duration')
							while(parser.nexttoken()!=null)
								if(parser.gettext()=='value'){
									parser.nexttoken();
									timeToReach = parser.getIntegervalue();
									break;
								}
					}
			}
    	}
    	return null;
    }
}