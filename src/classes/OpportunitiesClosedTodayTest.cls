@isTest
private class OpportunitiesClosedTodayTest {
	@isTest public static void OpportunitiesClosedTodayTest() {
		TestDataFactory.generateOpportunitiesClosedTodayTestData();
		OpportunitiesClosedToday opportunitiesClosedTodayInstance = new OpportunitiesClosedToday();
		ApexClass apexClassInstance = [
			SELECT Id 
			  FROM ApexClass 
			 WHERE Name = 'OpportunitiesClosedToday'
		];
		ID asyncApexJobId = Database.executeBatch(opportunitiesClosedTodayInstance , 200);
		AsyncApexJob asyncApexJobInstance = [
			SELECT JobType
				 , Status
				 , ApexClassID 
			  FROM AsyncApexJob 
			 WHERE Id = :asyncApexJobId
		];
		System.assertNotEquals(null , asyncApexJobInstance.JobType , 'Batch not executed');
		System.assertNotEquals(null , asyncApexJobInstance.Status , 'Job type error');
		System.assertEquals(apexClassInstance.Id , asyncApexJobInstance.ApexClassID , 'Apex class error');
	}
}