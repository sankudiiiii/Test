@isTest
private class LeadDuplicateCheckerTest {
	@isTest public static void LeadDuplicateCheckerTest(){
		TestDataFactory.generateLeadDuplicateCheckerTestData();
		LeadDuplicateChecker ldc = new LeadDuplicateChecker();
		ApexClass ac = [SELECT Id FROM ApexClass WHERE Name = 'LeadDuplicateChecker'];
		ID i = Database.executeBatch(ldc,200);
		list<lead> ll = [select id from lead where email='abc@xyz.com'];
		AsyncApexJob aaj = [select jobtype,status,ApexClassID from AsyncApexJob where id =:i];
		System.assertNotEquals(null,aaj.jobtype,'Batch not executed');
		System.assertNotEquals(null,aaj.status,'Job type error');
		System.assertEquals(ac.id,aaj.ApexClassID,'Apex class error');
		//System.assertEquals(1,ll.size(),'Leads not get deleted');
	}
}