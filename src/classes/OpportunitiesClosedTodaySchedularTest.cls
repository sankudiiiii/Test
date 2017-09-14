@isTest
private class OpportunitiesClosedTodaySchedularTest {
	@isTest public static void OpportunitiesClosedTodaySchedularTest() {
		TestDataFactory.generateOpportunitiesClosedTodayTestData();
		OpportunitiesClosedTodaySchedular opportunitiesClosedTodaySchedularInstance = new OpportunitiesClosedTodaySchedular();
		String cron = '0 59 23 * * ?';
		Id cronTriggerId = System.schedule('ClosedOpportunities' , cron , opportunitiesClosedTodaySchedularInstance);
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