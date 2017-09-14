@isTest
private class LeadManipulatorServiceTest {
	@isTest public static void createLeadRecordPositiveTest() {
		LeadManipulatorService.ResponseWrapper responseWrapperInstance = LeadManipulatorService.createLeadRecord('A' , 'B' , 'c@d.e' , '6' , 'g');
		System.assertEquals(true , responseWrapperInstance.isSuccess , 'Insertion failed');
		System.assertNotEquals(null , responseWrapperInstance.leadId , 'Insertion failed');
		System.assertEquals('A B' , responseWrapperInstance.leadName , 'Insertion failed');
		System.assertEquals('Success' , responseWrapperInstance.status , 'Insertion failed');
	}
	@isTest public static void createLeadRecordNegativeTest() {
		LeadManipulatorService.ResponseWrapper responseWrapperInstance = LeadManipulatorService.createLeadRecord('A' , 'B' , 'c@d.e' , '6' , null);
		System.assertEquals(false , responseWrapperInstance.isSuccess , 'Insertion Success');
		System.assertEquals(null , responseWrapperInstance.leadId , 'Insertion Success');
		System.assertEquals('A B' , responseWrapperInstance.leadName , 'Insertion Success');
		System.assertNotEquals('Success' , responseWrapperInstance.status , 'Insertion Success');
	}
	@isTest public static void updateLeadRecordPositiveTest() {
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorService.ResponseWrapper responseWrapperInstance = LeadManipulatorService.updateLeadRecord('A' , 'B' , 'c@d.e' , '6');
		System.assertEquals(true , responseWrapperInstance.isSuccess , 'Updation failed');
		System.assertNotEquals(null , responseWrapperInstance.leadId , 'Updation failed');
		System.assertEquals('A B' , responseWrapperInstance.leadName , 'Updation failed');
		System.assertEquals('Success' , responseWrapperInstance.status , 'Updation failed');
	}
	@isTest public static void updateLeadRecordNegativeTest() {
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorService.ResponseWrapper responseWrapperInstance = LeadManipulatorService.updateLeadRecord('A' , 'CB' , 'c@d.e' , '6');
		System.assertEquals(false , responseWrapperInstance.isSuccess , 'Updation Successful');
		System.assertEquals(null , responseWrapperInstance.leadId , 'Updation Successful');
		System.assertEquals('null null' , responseWrapperInstance.leadName , 'Updation Successful');
		System.assertNotEquals('Success' , responseWrapperInstance.status , 'Updation Successful');
	}
	@isTest public static void deleteLeadRecordPositiveTest() {
		TestDataFactory.generateLeadManipulatorServiceTestData();
		RestRequest requestInstance = new RestRequest(); 
        RestResponse responseInstance = new RestResponse();
        requestInstance.requestURI = '/services/apexrest/LeadManipulatorService';  
        requestInstance.addParameter('firstname' , 'A');
        requestInstance.addParameter('lastname' , 'B');
        requestInstance.addParameter('email' , 'c@d.e');
        requestInstance.addParameter('phone' , '6');
        requestInstance.httpMethod = 'DELETE';
        RestContext.request = requestInstance;
        RestContext.response = responseInstance;
		LeadManipulatorService.ResponseWrapper responseWrapperInstance = LeadManipulatorService.deleteLeadRecord();
		System.assertEquals(true , responseWrapperInstance.isSuccess , 'Deletion failed');
		System.assertEquals(null , responseWrapperInstance.leadId , 'Deletion failed');
		System.assertEquals('A B' , responseWrapperInstance.leadName , 'Deletion failed');
		System.assertEquals('Success' , responseWrapperInstance.status , 'Deletion failed');
	}
	@isTest public static void deleteLeadRecordNegativeTest() {
		TestDataFactory.generateLeadManipulatorServiceTestData();
		RestRequest requestInstance = new RestRequest(); 
        RestResponse responseInstance = new RestResponse();
        requestInstance.requestURI = '/services/apexrest/LeadManipulatorService';  
        requestInstance.addParameter('firstname' , 'A');
        requestInstance.addParameter('lastname' , 'B');
        requestInstance.addParameter('email' , 'c@d.e');
        requestInstance.addParameter('phone' , '67');
        requestInstance.httpMethod = 'DELETE';
        RestContext.request = requestInstance;
        RestContext.response = responseInstance;
		LeadManipulatorService.ResponseWrapper responseWrapperInstance = LeadManipulatorService.deleteLeadRecord();
		System.assertEquals(false , responseWrapperInstance.isSuccess , 'Deletion Successful');
		System.assertEquals(null , responseWrapperInstance.leadId , 'Deletion Successful');
		System.assertEquals('null null' , responseWrapperInstance.leadName , 'Deletion Successful');
		System.assertNotEquals('Success' , responseWrapperInstance.status , 'Deletion Successful');
	}
}