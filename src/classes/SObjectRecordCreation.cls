global with sharing class SObjectRecordCreation implements Database.Batchable<sObject>{
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('select Object_Record__c from event where Event_Processed__c=false');
	}
	global void execute(Database.BatchableContext BC, list<sObject> soList){
		list<event> eventlist = solist;
		
	}
	global void finish(Database.BatchableContext BC){
		
	}
}