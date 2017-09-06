public with sharing class SObjectRecordCreationSchedular implements Schedulable{
    public Void execute(SchedulableContext context){
    	SObjectRecordCreation src = new SObjectRecordCreation();
		ID i = Database.executeBatch(src,200);
		reSchedule();
    }
    public void reSchedule(){
    	dateTime dt=System.now().addMinutes(1);
        String Csec,Cmin,Chr,Cday,Cmonth,CYear;
        Csec=String.valueof(dt.second());
        Cmin=String.valueof(dt.minute());
        Chr=String.valueof(dt.hour());
        Cday=String.valueof(dt.day());
        Cmonth=String.valueof(dt.month());
        CYear=String.valueof(dt.Year());
        String SchTimer=Csec+' '+Cmin+' '+Chr+' '+Cday+' '+Cmonth+' ? '+CYear;
        SObjectRecordCreationSchedular cas = new SObjectRecordCreationSchedular();
        system.schedule('Scheduler02: Running at '+System.now().format(), SchTimer, cas);
        for( CronTrigger c:[Select State,Id,EndTime,CronExpression From CronTrigger where NextFireTime= null  AND State='DELETED' Limit 100]){
        	System.abortJob(c.id);
        }
    }
}