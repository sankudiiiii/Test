@isTest
private class LeadDuplicateCheckerSchedularTest {
	@isTest public static void LeadDuplicateCheckerSchedularTest() {
		TestDataFactory.generateLeadDuplicateCheckerTestData();
		LeadDuplicateCheckerSchedular leadDuplicateCheckerSchedularInstance = new LeadDuplicateCheckerSchedular();
		String cron = '0 59 23 * * ?';
		Id cronTriggerId = System.schedule('DuplicateLeads' , cron , leadDuplicateCheckerSchedularInstance);
		CronTrigger cronTriggerInstance = [
			SELECT CronExpression
				 , State 
			  FROM CronTrigger 
			 WHERE Id = :cronTriggerId
		];
		System.assertEquals(cron , cronTriggerInstance.CronExpression , 'CRON expression error');
		System.assertNotEquals(null , cronTriggerInstance.State , 'job not executed');
	}
}