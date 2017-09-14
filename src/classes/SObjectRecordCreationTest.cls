@isTest
private class SObjectRecordCreationTest {
	@isTest public static void SObjectRecordCreationTest() {
		TestDataFactory.generateSObjectRecordCreationTestData();
		SObjectRecordCreation sObjectRecordCreationInstance = new SObjectRecordCreation();
		ApexClass apexClassInstance = [
			SELECT Id 
			  FROM ApexClass 
			 WHERE Name = 'SObjectRecordCreation'
		];
		ID asyncApexJobId = Database.executeBatch(sObjectRecordCreationInstance , 200);
		AsyncApexJob asyncApexJobInstance = [
			SELECT JobType
				 , Status
				 , ApexClassID 
			  FROM AsyncApexJob 
			 WHERE Id =:asyncApexJobId
		];
		System.assertNotEquals(null , asyncApexJobInstance.JobType , 'Batch not executed');
		System.assertNotEquals(null , asyncApexJobInstance.Status , 'Job type error');
		System.assertEquals(apexClassInstance.Id , asyncApexJobInstance.ApexClassID , 'Apex class error');
	}
}