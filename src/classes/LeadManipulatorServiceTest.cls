@isTest
private class LeadManipulatorServiceTest {
	@isTest public static void createLeadRecordPositiveTest(){
		LeadManipulatorService.ResponseWrapper rw = LeadManipulatorService.createLeadRecord('A','B','c@d.e','6','g');
		System.assertEquals(true,rw.isSuccess,'Insertion failed');
		System.assertNotEquals(null,rw.leadId,'Insertion failed');
		System.assertEquals('A B',rw.leadName,'Insertion failed');
		System.assertEquals('Success',rw.status,'Insertion failed');
	}
	@isTest public static void createLeadRecordNegativeTest(){
		LeadManipulatorService.ResponseWrapper rw = LeadManipulatorService.createLeadRecord('A','B','c@d.e','6',null);
		System.assertEquals(false,rw.isSuccess,'Insertion Success');
		System.assertEquals(null,rw.leadId,'Insertion Success');
		System.assertEquals('A B',rw.leadName,'Insertion Success');
		System.assertNotEquals('Success',rw.status,'Insertion Success');
	}
	@isTest public static void updateLeadRecordPositiveTest(){
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorService.ResponseWrapper rw = LeadManipulatorService.updateLeadRecord('A','B','c@d.e','6');
		System.assertEquals(true,rw.isSuccess,'Updation failed');
		System.assertNotEquals(null,rw.leadId,'Updation failed');
		System.assertEquals('A B',rw.leadName,'Updation failed');
		System.assertEquals('Success',rw.status,'Updation failed');
	}
	@isTest public static void updateLeadRecordNegativeTest(){
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorService.ResponseWrapper rw = LeadManipulatorService.updateLeadRecord('A','CB','c@d.e','6');
		System.assertEquals(false,rw.isSuccess,'Updation Successful');
		System.assertEquals(null,rw.leadId,'Updation Successful');
		System.assertEquals('null null',rw.leadName,'Updation Successful');
		System.assertNotEquals('Success',rw.status,'Updation Successful');
	}
	@isTest public static void deleteLeadRecordPositiveTest(){
		TestDataFactory.generateLeadManipulatorServiceTestData();
		RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/LeadManipulatorService';  
        req.addParameter('firstname', 'A');
        req.addParameter('lastname', 'B');
        req.addParameter('email', 'c@d.e');
        req.addParameter('phone', '6');
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        RestContext.response = res;
		LeadManipulatorService.ResponseWrapper rw = LeadManipulatorService.deleteLeadRecord();
		System.assertEquals(true,rw.isSuccess,'Deletion failed');
		System.assertEquals(null,rw.leadId,'Deletion failed');
		System.assertEquals('A B',rw.leadName,'Deletion failed');
		System.assertEquals('Success',rw.status,'Deletion failed');
	}
	@isTest public static void deleteLeadRecordNegativeTest(){
		TestDataFactory.generateLeadManipulatorServiceTestData();
		RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/LeadManipulatorService';  
        req.addParameter('firstname', 'A');
        req.addParameter('lastname', 'B');
        req.addParameter('email', 'c@d.e');
        req.addParameter('phone', '67');
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        RestContext.response = res;
		LeadManipulatorService.ResponseWrapper rw = LeadManipulatorService.deleteLeadRecord();
		System.assertEquals(false,rw.isSuccess,'Deletion Successful');
		System.assertEquals(null,rw.leadId,'Deletion Successful');
		System.assertEquals('null null',rw.leadName,'Deletion Successful');
		System.assertNotEquals('Success',rw.status,'Deletion Successful');
	}
}