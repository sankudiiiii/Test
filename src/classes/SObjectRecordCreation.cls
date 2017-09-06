global with sharing class SObjectRecordCreation implements Database.Batchable<sObject>,Database.Stateful{
	list<sobject> slist = new list<sobject>();
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('select Object_Record__c,event_processed__c from event where Event_Processed__c=false');
	}
	global void execute(Database.BatchableContext BC, list<sObject> soList){
		list<Schema.SObjectType> objTyp = Schema.getGlobalDescribe().Values();
		list<event> eventlist = solist;
		for(event e : eventlist){
			Map<String, Object> m = (Map<String, Object>)JSON.deserializeUntyped(e.Object_Record__c);
			for(Schema.SObjectType obj : objtyp){
				if(obj.getDescribe().getname()==(String)m.get('Object Name')){
					sobject s = obj.newsobject();
					Map<String,Object> mm = (Map<String,Object>)m.get('JSON');
					for(String sss : mm.keySet()){
						s.put(sss,(String)mm.get(sss));
					}
					slist.add(s);
					break;
				}
			}
			e.event_processed__c=true;
		}
		update eventlist;
		insert slist;
	}
	global void finish(Database.BatchableContext BC){
		System.debug(slist);
	}
}