public with sharing class OpportunitiesClosedTodaySchedular implements Schedulable{
    public Void execute(SchedulableContext context){
    	OpportunitiesClosedToday oct = new OpportunitiesClosedToday();
		ID i = Database.executeBatch(oct,200);
    }
}