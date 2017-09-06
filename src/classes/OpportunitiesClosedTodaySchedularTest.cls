@isTest
private class OpportunitiesClosedTodaySchedularTest {
	@isTest public static void OpportunitiesClosedTodaySchedularTest(){
		TestDataFactory.generateOpportunitiesClosedTodayTestData();
		OpportunitiesClosedTodaySchedular octs = new OpportunitiesClosedTodaySchedular();
		String cron = '0 59 23 * * ?';
		Id i = System.schedule('ClosedOpportunities', cron , octs);
		CronTrigger ct = [select cronexpression,state from CronTrigger where id=:i];
		System.assertEquals(cron,ct.cronexpression,'CRON expression error');
		System.assertNotEquals(null,ct.state,'job not executed');
	}
}