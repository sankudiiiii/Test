@isTest
private class LeadDuplicateCheckerSchedularTest {
	@isTest public static void LeadDuplicateCheckerSchedularTest(){
		TestDataFactory.generateLeadDuplicateCheckerTestData();
		LeadDuplicateCheckerSchedular ldcs = new LeadDuplicateCheckerSchedular();
		String cron = '0 59 23 * * ?';
		Id i = System.schedule('DuplicateLeads', cron , ldcs);
		CronTrigger ct = [select cronexpression,state from CronTrigger where id=:i];
		System.assertEquals(cron,ct.cronexpression,'CRON expression error');
		System.assertNotEquals(null,ct.state,'job not executed');
	}
}