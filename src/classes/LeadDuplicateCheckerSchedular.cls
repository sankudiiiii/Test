public with sharing class LeadDuplicateCheckerSchedular implements Schedulable{
    public Void execute(SchedulableContext context){
    	LeadDuplicateChecker ldc = new LeadDuplicateChecker();
		ID i = Database.executeBatch(ldc,200);
    }
}