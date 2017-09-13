public with sharing class LeadDuplicateCheckerSchedular implements Schedulable {
    public Void execute(SchedulableContext context) {
    	LeadDuplicateChecker LeadDuplicateCheckerInstance = new LeadDuplicateChecker();
		ID asyncApexJobId = Database.executeBatch(LeadDuplicateCheckerInstance , 200);
    }
}
/*
LeadDuplicateCheckerSchedular LeadDuplicateCheckerSchedularInstance = new LeadDuplicateCheckerSchedular();
String cronExpression = '0 0 0,3,6,9,12,15,18,21 * * ?';
System.schedule('Lead Duplicate Checker', cronExpression , LeadDuplicateCheckerSchedularInstance);
*/