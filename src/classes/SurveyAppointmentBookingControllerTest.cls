@isTest
private class SurveyAppointmentBookingControllerTest {
	public static testmethod void controllerInitializationTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		test.startTest();
			OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		test.stopTest();
		System.assertNotEquals(null , controller.getTimeSetting() , 'Controller not initialized');
		System.assertNotEquals(null , controller.getCompanySetting() , 'Controller not initialized');
		System.assertNotEquals(null , controller.getApiSetting() , 'Controller not initialized');
		System.assertNotEquals(null , controller.getMessageSetting() , 'Controller not initialized');
		System.assertNotEquals(null , controller.getAvailableTimeSlotOptionList() , 'Controller not initialized');
		System.assertEquals('',controller.getDistance() , 'Controller not initialized');
		System.assertEquals('',controller.getTimeToReach() , 'Controller not initialized');
		System.assertEquals(System.today() , controller.bookingDate , 'Controller not initialized');
		String min = System.today().year() + '-';
    	if(System.today().month() < 10)
    		min += '0';
    	min += System.today().month() + '-' + System.today().day();
    	System.assertEquals(min , controller.getMinDate() , 'Controller not initialized');
	}
	public static testmethod void getTimeAndDistanceTodayBefore830Test() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(controller.bookingDate.format() , controller.getFormattedBookingDate(),'');
		JSONWrapperDemo wrapperObj = (JSONWrapperDemo) JSON.deserialize('{"destination_addresses" : [ "Pune, Maharashtra 411009, India" ],"origin_addresses" : [ "Pune, Maharashtra 411030, India" ],"rows" : [{         "elements" : [{"distance" : {"text" : "3.0 km","value" : 3001},               "duration" : {                  "text" : "11 mins",                  "value" : 665               },               "status" : "OK"            }         ]      }   ],  "status" : "OK"}' , JSONWrapperDemo.class);
		Integer tempTimeToReach = (Integer) wrapperObj.rows[0].elements[0].duration.value;
		Decimal tempDistance = wrapperObj.rows[0].elements[0].distance.value;
		String distance = String.valueOf(tempDistance / 1000) + ' km';
		String timeToReach = String.valueOf(tempTimeToReach / 3600) + ' hr ';
		timeToReach += String.valueOf(tempTimeToReach / 60) + ' min';
		System.assertEquals(distance , controller.distance , '');
		System.assertEquals(timeToReach , controller.timeToReach , '');
		List<String> tempAddress = wrapperObj.destination_addresses[0].split(',');
		String city = tempAddress[0];
		String state = tempAddress[1].split(' ')[1];
		String country = tempAddress[2].split(' ')[1];
		System.assertEquals(city , controller.city , '');
		System.assertEquals(state , controller.state , '');
		System.assertEquals(country , controller.country , '');
		System.assertEquals(15 , controller.availableTimeSlotOptionList.size() , '');
		System.assertNotEquals('' , controller.selectedTimeSlot , '');
		System.assertNotEquals(null , controller.selectedTimeSlot , '');
	}
	public static testmethod void getTimeAndDistanceToday830To1530Test() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,45,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(controller.bookingDate.format() , controller.formattedBookingDate,'');
		JSONWrapperDemo wrapperObj = (JSONWrapperDemo) JSON.deserialize('{"destination_addresses" : [ "Pune, Maharashtra 411009, India" ],"origin_addresses" : [ "Pune, Maharashtra 411030, India" ],"rows" : [{         "elements" : [{"distance" : {"text" : "3.0 km","value" : 3001},               "duration" : {                  "text" : "11 mins",                  "value" : 665               },               "status" : "OK"            }         ]      }   ],  "status" : "OK"}' , JSONWrapperDemo.class);
		Integer tempTimeToReach = (Integer) wrapperObj.rows[0].elements[0].duration.value;
		Decimal tempDistance = wrapperObj.rows[0].elements[0].distance.value;
		String distance = String.valueOf(tempDistance / 1000) + ' km';
		String timeToReach = String.valueOf(tempTimeToReach / 3600) + ' hr ';
		timeToReach += String.valueOf(tempTimeToReach / 60) + ' min';
		System.assertEquals(distance , controller.distance , '');
		System.assertEquals(timeToReach , controller.timeToReach , '');
		List<String> tempAddress = wrapperObj.destination_addresses[0].split(',');
		String city = tempAddress[0];
		String state = tempAddress[1].split(' ')[1];
		String country = tempAddress[2].split(' ')[1];
		System.assertEquals(city , controller.city , '');
		System.assertEquals(state , controller.state , '');
		System.assertEquals(country , controller.country , '');
		System.assert(controller.availableTimeSlotOptionList.size() == 14 , '');
		System.assertNotEquals('' , controller.selectedTimeSlot , '');
		System.assertNotEquals(null , controller.selectedTimeSlot , '');
	}
	public static testmethod void getTimeAndDistanceTodayAfter1530Test() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(16,45,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(true , ApexPages.hasMessages() , '');
	}
	public static testmethod void getTimeAndDistanceTomorrowBrfore1730Test() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today().addDays(1);
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(controller.bookingDate.format() , controller.formattedBookingDate,'');
		JSONWrapperDemo wrapperObj = (JSONWrapperDemo) JSON.deserialize('{"destination_addresses" : [ "Pune, Maharashtra 411009, India" ],"origin_addresses" : [ "Pune, Maharashtra 411030, India" ],"rows" : [{         "elements" : [{"distance" : {"text" : "3.0 km","value" : 3001},               "duration" : {                  "text" : "11 mins",                  "value" : 665               },               "status" : "OK"            }         ]      }   ],  "status" : "OK"}' , JSONWrapperDemo.class);
		Integer tempTimeToReach = (Integer) wrapperObj.rows[0].elements[0].duration.value;
		Decimal tempDistance = wrapperObj.rows[0].elements[0].distance.value;
		String distance = String.valueOf(tempDistance / 1000) + ' km';
		String timeToReach = String.valueOf(tempTimeToReach / 3600) + ' hr ';
		timeToReach += String.valueOf(tempTimeToReach / 60) + ' min';
		System.assertEquals(distance , controller.distance , '');
		System.assertEquals(timeToReach , controller.timeToReach , '');
		List<String> tempAddress = wrapperObj.destination_addresses[0].split(',');
		String city = tempAddress[0];
		String state = tempAddress[1].split(' ')[1];
		String country = tempAddress[2].split(' ')[1];
		System.assertEquals(city , controller.city , '');
		System.assertEquals(state , controller.state , '');
		System.assertEquals(country , controller.country , '');
		System.assert(controller.availableTimeSlotOptionList.size() == 25 , '');
		System.assertNotEquals('' , controller.selectedTimeSlot , '');
		System.assertNotEquals(null , controller.selectedTimeSlot , '');
	}
	public static testmethod void getTimeAndDistanceTomorrowAfter1730Test() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today().addDays(1);
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(18,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(controller.bookingDate.format() , controller.formattedBookingDate,'');
		JSONWrapperDemo wrapperObj = (JSONWrapperDemo) JSON.deserialize('{"destination_addresses" : [ "Pune, Maharashtra 411009, India" ],"origin_addresses" : [ "Pune, Maharashtra 411030, India" ],"rows" : [{         "elements" : [{"distance" : {"text" : "3.0 km","value" : 3001},               "duration" : {                  "text" : "11 mins",                  "value" : 665               },               "status" : "OK"            }         ]      }   ],  "status" : "OK"}' , JSONWrapperDemo.class);
		Integer tempTimeToReach = (Integer) wrapperObj.rows[0].elements[0].duration.value;
		Decimal tempDistance = wrapperObj.rows[0].elements[0].distance.value;
		String distance = String.valueOf(tempDistance / 1000) + ' km';
		String timeToReach = String.valueOf(tempTimeToReach / 3600) + ' hr ';
		timeToReach += String.valueOf(tempTimeToReach / 60) + ' min';
		System.assertEquals(distance , controller.distance , '');
		System.assertEquals(timeToReach , controller.timeToReach , '');
		List<String> tempAddress = wrapperObj.destination_addresses[0].split(',');
		String city = tempAddress[0];
		String state = tempAddress[1].split(' ')[1];
		String country = tempAddress[2].split(' ')[1];
		System.assertEquals(city , controller.city , '');
		System.assertEquals(state , controller.state , '');
		System.assertEquals(country , controller.country , '');
		System.assert(controller.availableTimeSlotOptionList.size() == 15 , '');
		System.assertNotEquals('' , controller.selectedTimeSlot , '');
		System.assertNotEquals(null , controller.selectedTimeSlot , '');
	}
	public static testmethod void getTimeAndDistanceOtherDaysTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today().addDays(4);
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(18,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(controller.bookingDate.format() , controller.formattedBookingDate , '');
		JSONWrapperDemo wrapperObj = (JSONWrapperDemo) JSON.deserialize('{"destination_addresses" : [ "Pune, Maharashtra 411009, India" ],"origin_addresses" : [ "Pune, Maharashtra 411030, India" ],"rows" : [{         "elements" : [{"distance" : {"text" : "3.0 km","value" : 3001},               "duration" : {                  "text" : "11 mins",                  "value" : 665               },               "status" : "OK"            }         ]      }   ],  "status" : "OK"}' , JSONWrapperDemo.class);
		Integer tempTimeToReach = (Integer) wrapperObj.rows[0].elements[0].duration.value;
		Decimal tempDistance = wrapperObj.rows[0].elements[0].distance.value;
		String distance = String.valueOf(tempDistance / 1000) + ' km';
		String timeToReach = String.valueOf(tempTimeToReach / 3600) + ' hr ';
		timeToReach += String.valueOf(tempTimeToReach / 60) + ' min';
		System.assertEquals(distance , controller.distance , '');
		System.assertEquals(timeToReach , controller.timeToReach , '');
		List<String> tempAddress = wrapperObj.destination_addresses[0].split(',');
		String city = tempAddress[0];
		String state = tempAddress[1].split(' ')[1];
		String country = tempAddress[2].split(' ')[1];
		System.assertEquals(city , controller.city , '');
		System.assertEquals(state , controller.state , '');
		System.assertEquals(country , controller.country , '');
		System.assert(controller.availableTimeSlotOptionList.size() == 25 , '');
		System.assertNotEquals('' , controller.selectedTimeSlot , '');
		System.assertNotEquals(null , controller.selectedTimeSlot , '');
	}
	public static testmethod void unReachableTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleAPIUnreachableResultGeneratorMock());
		controller.bookingDate = System.today().addDays(4);
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(18,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(true , ApexPages.hasMessages() , '');
	}
	public static testmethod void failedResponseTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleAPIFailedResponseGeneratorMock());
		controller.bookingDate = System.today().addDays(4);
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(18,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(true , ApexPages.hasMessages() , '');
	}
	public static testmethod void failedResultTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleAPIFailedResultGeneratorMock());
		controller.bookingDate = System.today().addDays(4);
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(18,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(true , ApexPages.hasMessages() , '');
	}
	public static testmethod void eventExistsTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		TestDataFactory.generateSurveyAppointmentRecordTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
		test.stopTest();
		System.assertEquals(14 , controller.availableTimeSlotOptionList.size() , '');
	}
	public static testmethod void bookAppointmentContactAndEventSuccessTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
			controller.firstName = 'Sanket';
			controller.lastName = 'Mandhare';
			controller.email = 's@m.com';
			controller.address = 'SM';
			controller.bookAppointment();
		test.stopTest();
		List<Contact> contactList = [
			SELECT Id 
			  FROM Contact
		];
		List<Event> eventList = [
			SELECT Id
			  FROM Event
		];
		System.assertEquals(1 , contactList.size() , '');
		System.assertEquals(1 , eventList.size() , '');
	}
	public static testmethod void bookAppointmentContactFailureTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
			controller.firstName = 'Sanket';
			controller.lastName = 'Mandhare';
			controller.email = 's.com';
			controller.address = 'SM';
			controller.bookAppointment();
		test.stopTest();
		List<Contact> contactList = [
			SELECT Id 
			  FROM Contact
		];
		List<Event> eventList = [
			SELECT Id 
			  FROM Event
		];
		System.assertEquals(0 , contactList.size() , '');
		System.assertEquals(0 , eventList.size() , '');
	}
	public static testmethod void bookAppointmentEventFailureTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
			controller.firstName = 'Sanket';
			controller.lastName = 'Mandhare';
			controller.email = 's@m.com';
			controller.address = 'SM';
			controller.adminUser= new User();
			controller.bookAppointment();
		test.stopTest();
		List<Contact> contactList = [
			SELECT Id 
			  FROM Contact
		];
		List<Event> eventList = [
			SELECT Id 
			  FROM Event
		];
		System.assertEquals(1 , contactList.size() , '');
		System.assertEquals(0 , eventList.size() , '');
	}
	public static testmethod void bookAppointmentContactPresentSuccessTest() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		TestDataFactory.generateSurveyAppointmentRecordTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
			controller.firstName = 'Sanket';
			controller.lastName = 'Mandhare';
			controller.email = 's@m.com';
			controller.address = 'SM';
			controller.bookAppointment();
		test.stopTest();
		List<Contact> contactList = [
			SELECT Id 
			  FROM Contact
		];
		List<Event> eventList = [
			SELECT Id 
			  FROM Event
		];
		System.assertEquals(1 , contactList.size() , '');
		System.assertEquals(2 , eventList.size() , '');
	}
	public static testmethod void resetTest() {
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		controller.reset();
	}
	public static testmethod void checkEventOwner() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
			controller.firstName = 'Sanket';
			controller.lastName = 'Mandhare';
			controller.email = 's@m.com';
			controller.address = 'SM';
			controller.bookAppointment();
		test.stopTest();
		List<Event> eventList = [
			SELECT Id
				 , OwnerId 
			  FROM Event
		];
		Profile profileObj = [
			SELECT Name 
			  FROM Profile 
			 WHERE Id IN (SELECT ProfileId 
			 				FROM User 
			 			   WHERE Id = :eventList[0].OwnerId
			 			 )
		];
		System.assertEquals('System Administrator' , profileObj.Name , '');
	}
	public static testmethod void checkEventDuration() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
			controller.firstName = 'Sanket';
			controller.lastName = 'Mandhare';
			controller.email = 's@m.com';
			controller.address = 'SM';
			controller.bookAppointment();
		test.stopTest();
		List<Event> eventList = [
			SELECT Id
				 , DurationInMinutes 
			  FROM Event
		];
		System.assertEquals(30 , eventList[0].DurationInMinutes , '');
	}
	public static testmethod void checkEmailSent() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today();
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(8,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
			controller.firstName = 'Sanket';
			controller.lastName = 'Mandhare';
			controller.email = 's@m.com';
			controller.address = 'SM';
			controller.bookAppointment();
		test.stopTest();
		List<Event> eventList = [
			SELECT Id
				 , Email_Sent__c 
			  FROM Event
		];
		System.assertEquals(true , eventList[0].Email_Sent__c , '');
	}
	public static testmethod void checkReminderScheduled() {
		TestDataFactory.generateSurveyAppointmentCustomSettingTestData();
		OnlineSurveyAppointmentBookingController controller = new OnlineSurveyAppointmentBookingController();
		Test.setMock(HttpCalloutMock.class , new GoogleDistanceAPIResponseGeneratorMock());
		controller.bookingDate = System.today().addDays(4);
		controller.customerPostalCode = '411030';
		controller.currentDateTime = DateTime.newInstance(System.today() , Time.newInstance(18,15,0,0));
		test.startTest();
			controller.getTimeAndDistance();
			controller.firstName = 'Sanket';
			controller.lastName = 'Mandhare';
			controller.email = 's@m.com';
			controller.address = 'SM';
			controller.bookAppointment();
		test.stopTest();
		List<Event> eventList = [
			SELECT Id
				 , IsReminderSet 
			  FROM Event
		];
		System.assertEquals(true , eventList[0].IsReminderSet , '');
	}
}