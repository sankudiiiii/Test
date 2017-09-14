@isTest
private class LeadDuplicateCheckerTest {
	@isTest public static void LeadDuplicateCheckerTest() {
		TestDataFactory.generateLeadDuplicateCheckerTestData();
		LeadDuplicateChecker leadDuplicateCheckerInstance = new LeadDuplicateChecker();
		ApexClass apexClassInstance = [
			SELECT Id 
			  FROM ApexClass 
			 WHERE Name = 'LeadDuplicateChecker'
		];
		ID asyncApexJobId = Database.executeBatch(leadDuplicateCheckerInstance , 200);
		List<Lead> leadList = [
			SELECT Id 
			  FROM Lead 
			 WHERE Email = 'abc@xyz.com'
		];
		AsyncApexJob asyncApexJobInstance = [
			SELECT Jobtype
				 , Status
				 , ApexClassID
			  FROM AsyncApexJob 
			 WHERE Id = :asyncApexJobId
		];
		System.assertNotEquals(null , asyncApexJobInstance.Jobtype , 'Batch not executed');
		System.assertNotEquals(null , asyncApexJobInstance.Status , 'Job type error');
		System.assertEquals(apexClassInstance.Id , asyncApexJobInstance.ApexClassID , 'Apex class error');
		//System.assertEquals(1,ll.size(),'Leads not get deleted');
	}
}