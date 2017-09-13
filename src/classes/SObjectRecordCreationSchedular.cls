public with sharing class SObjectRecordCreationSchedular implements Schedulable {
    public Void execute(SchedulableContext context){
    	SObjectRecordCreation SObjectRecordCreationInstance = new SObjectRecordCreation();
		ID asyncApexJobId = Database.executeBatch(SObjectRecordCreationInstance , 200);
		reSchedule();
    }
    public void reSchedule() {
    	dateTime dt = System.now().addMinutes(1);
        String csec, cmin ,chr, cday, cmonth, cYear;
        csec = String.valueof(dt.second());
        cmin = String.valueof(dt.minute());
        chr = String.valueof(dt.hour());
        cday = String.valueof(dt.day());
        cmonth = String.valueof(dt.month());
        cYear = String.valueof(dt.Year());
        String schTimer = csec +' ' + cmin + ' ' + chr + ' ' + cday + ' ' + cmonth + ' ? ' + cYear;
        SObjectRecordCreationSchedular SObjectRecordCreationSchedularInstance = new SObjectRecordCreationSchedular();
        system.schedule('sObject Creation Scheduler : Running at '+ System.now().format() , schTimer , SObjectRecordCreationSchedularInstance);
        for( CronTrigger deletedJobs : [
        	SELECT State
        	     , Id
        	     , EndTime
        	     , CronExpression 
        	  FROM CronTrigger 
        	 WHERE NextFireTime = null  
        	   AND State = 'DELETED' 
        	 LIMIT 100
        ]) {
        	System.abortJob(deletedJobs.Id);
        }
    }
}
/*
SObjectRecordCreationSchedular SObjectRecordCreationSchedularInstance = new SObjectRecordCreationSchedular();
String cronExpression = '0 25 15 13 9 ?';
System.schedule('sObject Creation', cronExpression , SObjectRecordCreationSchedularInstance);
*/