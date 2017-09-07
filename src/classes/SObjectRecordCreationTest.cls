@isTest
private class SObjectRecordCreationTest {
	@isTest public static void SObjectRecordCreationTest(){
		TestDataFactory.generateSObjectRecordCreationTestData();
		SObjectRecordCreation ldc = new SObjectRecordCreation();
		ApexClass ac = [SELECT Id FROM ApexClass WHERE Name = 'SObjectRecordCreation'];
		ID i = Database.executeBatch(ldc,200);
		AsyncApexJob aaj = [select jobtype,status,ApexClassID from AsyncApexJob where id =:i];
		System.assertNotEquals(null,aaj.jobtype,'Batch not executed');
		System.assertNotEquals(null,aaj.status,'Job type error');
		System.assertEquals(ac.id,aaj.ApexClassID,'Apex class error');
	}
}