@isTest
private class LeadManipulatorWebServiceTest {
	@isTest public static void createLeadRecordPositiveTest(){
		LeadManipulatorWebService.WrapperResponse rw = LeadManipulatorWebService.createLeadRecord('A','B','c@d.e','6','g');
		System.assertEquals(true,rw.isSuccess,'Insertion Failed');
		System.assertNotEquals(null,rw.lead,'Insertion Failed');
		System.assertEquals('Success',rw.status,'Insertion Failed');
	}
	@isTest public static void createLeadRecordNegativeTest(){
		LeadManipulatorWebService.WrapperResponse rw = LeadManipulatorWebService.createLeadRecord('A','B','c@d.e','6',null);
		System.assertEquals(false,rw.isSuccess,'Insertion Successful');
		System.assertEquals('',rw.lead,'Insertion Successful');
		System.assertNotEquals('Success',rw.status,'Insertion Successful');
	}
	@isTest public static void updateLeadRecordPositiveTest(){
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorWebService.WrapperResponse rw = LeadManipulatorWebService.updateLeadRecord('A','B','c@d.e','6');
		System.assertEquals(true,rw.isSuccess,'Updation Failed');
		System.assertNotEquals(null,rw.lead,'Updation Failed');
		System.assertEquals('Success',rw.status,'Updation Failed');
	}
	@isTest public static void updateLeadRecordNegativeTest(){
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorWebService.WrapperResponse rw = LeadManipulatorWebService.updateLeadRecord('A','CB','c@d.e','6');
		System.assertEquals(false,rw.isSuccess,'Updation Successful');
		System.assertEquals('',rw.lead,'Updation Successful');
		System.assertNotEquals('Success',rw.status,'Updation Successful');
	}
	@isTest public static void deleteLeadRecordPositiveTest(){
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorWebService.WrapperResponse rw = LeadManipulatorWebService.deleteLeadRecord('A','B','c@d.e','6');
		System.assertEquals(true,rw.isSuccess,'Deletion Failed');
		System.assertEquals('A B',rw.lead,'Deletion Failed');
		System.assertEquals('Success',rw.status,'Deletion Failed');
	}
	@isTest public static void deleteLeadRecordNegativeTest(){
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorWebService.WrapperResponse rw = LeadManipulatorWebService.deleteLeadRecord('A','BC','c@d.e','6');
		System.assertEquals(false,rw.isSuccess,'Deletion Successful');
		System.assertEquals('',rw.lead,'Deletion Successful');
		System.assertNotEquals('Success',rw.status,'Deletion Successful');
	}
}