@isTest
private class OpportunitiesClosedTodayTest {
	@isTest public static void OpportunitiesClosedTodayTest(){
		TestDataFactory.generateOpportunitiesClosedTodayTestData();
		OpportunitiesClosedToday oct = new OpportunitiesClosedToday();
		ApexClass ac = [SELECT Id FROM ApexClass WHERE Name = 'OpportunitiesClosedToday'];
		ID i = Database.executeBatch(oct,200);
		AsyncApexJob aaj = [select jobtype,status,ApexClassID from AsyncApexJob where id =:i];
		System.assertNotEquals(null,aaj.jobtype,'Batch not executed');
		System.assertNotEquals(null,aaj.status,'Job type error');
		System.assertEquals(ac.id,aaj.ApexClassID,'Apex class error');
	}
}