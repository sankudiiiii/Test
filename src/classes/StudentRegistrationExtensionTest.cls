@isTest
private class StudentRegistrationExtensionTest {
	@isTest public static void StudentRegistrationExtensionTest(){
		TestDataFactory.generateStudentRegistrationTestData();
		Student__c s = [select id from Student__c limit 1];
		ApexPages.StandardController controller = new ApexPages.StandardController(s);
		StudentRegistrationExtension sr = new StudentRegistrationExtension(controller);
		System.assertNotEquals(0,sr.so.size(),'Custom label not defined or accessable');
		System.assertEquals(s,sr.s,'Record not assigned');
	}
	@isTest public static void insertRecordTest(){
		TestDataFactory.generateStudentRegistrationTestData();
		Student__c s = new Student__c(name='XYZ');
		ApexPages.StandardController controller = new ApexPages.StandardController(s);
		StudentRegistrationExtension sr = new StudentRegistrationExtension(controller);
		sr.insertRecord();
		System.assertNotEquals(null,sr.s.id,'Record not inserted.');
	}
}