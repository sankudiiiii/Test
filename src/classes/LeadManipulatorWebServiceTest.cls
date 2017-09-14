@isTest
private class LeadManipulatorWebServiceTest {
	@isTest public static void createLeadRecordPositiveTest() {
		LeadManipulatorWebService.WrapperResponse wrapperResponseInstance = LeadManipulatorWebService.createLeadRecord('A' , 'B' , 'c@d.e' , '6' , 'g');
		System.assertEquals(true , wrapperResponseInstance.isSuccess , 'Insertion Failed');
		System.assertNotEquals(null , wrapperResponseInstance.lead , 'Insertion Failed');
		System.assertEquals('Success' , wrapperResponseInstance.status , 'Insertion Failed');
	}
	@isTest public static void createLeadRecordNegativeTest() {
		LeadManipulatorWebService.WrapperResponse wrapperResponseInstance = LeadManipulatorWebService.createLeadRecord('A' , 'B' , 'c@d.e' , '6' , null);
		System.assertEquals(false , wrapperResponseInstance.isSuccess , 'Insertion Successful');
		System.assertEquals('' , wrapperResponseInstance.lead , 'Insertion Successful');
		System.assertNotEquals('Success' , wrapperResponseInstance.status , 'Insertion Successful');
	}
	@isTest public static void updateLeadRecordPositiveTest() {
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorWebService.WrapperResponse wrapperResponseInstance = LeadManipulatorWebService.updateLeadRecord('A' , 'B' , 'c@d.e' , '6');
		System.assertEquals(true , wrapperResponseInstance.isSuccess , 'Updation Failed');
		System.assertNotEquals(null , wrapperResponseInstance.lead , 'Updation Failed');
		System.assertEquals('Success' , wrapperResponseInstance.status , 'Updation Failed');
	}
	@isTest public static void updateLeadRecordNegativeTest() {
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorWebService.WrapperResponse wrapperResponseInstance = LeadManipulatorWebService.updateLeadRecord('A' , 'CB' , 'c@d.e' , '6');
		System.assertEquals(false , wrapperResponseInstance.isSuccess , 'Updation Successful');
		System.assertEquals('' , wrapperResponseInstance.lead , 'Updation Successful');
		System.assertNotEquals('Success' , wrapperResponseInstance.status , 'Updation Successful');
	}
	@isTest public static void deleteLeadRecordPositiveTest() {
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorWebService.WrapperResponse wrapperResponseInstance = LeadManipulatorWebService.deleteLeadRecord('A' , 'B' , 'c@d.e' , '6');
		System.assertEquals(true , wrapperResponseInstance.isSuccess , 'Deletion Failed');
		System.assertEquals('A B' , wrapperResponseInstance.lead , 'Deletion Failed');
		System.assertEquals('Success' , wrapperResponseInstance.status , 'Deletion Failed');
	}
	@isTest public static void deleteLeadRecordNegativeTest() {
		TestDataFactory.generateLeadManipulatorServiceTestData();
		LeadManipulatorWebService.WrapperResponse wrapperResponseInstance = LeadManipulatorWebService.deleteLeadRecord('A' , 'BC' , 'c@d.e' , '6');
		System.assertEquals(false , wrapperResponseInstance.isSuccess , 'Deletion Successful');
		System.assertEquals('' , wrapperResponseInstance.lead , 'Deletion Successful');
		System.assertNotEquals('Success' , wrapperResponseInstance.status , 'Deletion Successful');
	}
}