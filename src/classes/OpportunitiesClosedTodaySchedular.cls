public with sharing class OpportunitiesClosedTodaySchedular implements Schedulable{
    public Void execute(SchedulableContext context) {
    	OpportunitiesClosedToday opportunitiesClosedTodayInstance = new OpportunitiesClosedToday();
		ID asyncApexJobId = Database.executeBatch(opportunitiesClosedTodayInstance , 200);
    }
}
/*
OpportunitiesClosedTodaySchedular OpportunitiesClosedTodaySchedularInstance = new OpportunitiesClosedTodaySchedular();
String cronExpression = '0 59 23 * * ?';
System.schedule('Closed Opportunities', cronExpression , OpportunitiesClosedTodaySchedularInstance);
*/