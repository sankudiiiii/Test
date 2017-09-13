global with sharing class SObjectRecordCreation implements Database.Batchable<sObject> , Database.Stateful {
	List<sObject> sList = new List<sObject>();
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('SELECT Object_Record__c , event_processed__c FROM Event WHERE Event_Processed__c = false');
	}
	global void execute(Database.BatchableContext BC, List<sObject> sObjectList) {
		list<Schema.SObjectType> objType = Schema.getGlobalDescribe().Values();
		List<Event> eventList = sObjectlist;
		for(Event eventInstance : eventList) {
			Map<String , Object> jsonMap = (Map<String , Object>)JSON.deserializeUntyped(eventInstance.Object_Record__c);
			for(Schema.SObjectType obj : objtype){
				if(obj.getDescribe().getname() == (String)jsonMap.get('Object Name')) {
					sObject sObj = obj.newSObject();
					Map<String , Object> fieldList = (Map<String , Object>)jsonMap.get('JSON');
					for(String fieldName : fieldList.keySet())
						sObj.put(fieldName , (String)fieldList.get(fieldName));
					slist.add(sObj);
					break;
				}
			}
			eventInstance.event_processed__c = true;
		}
		update eventList;
		insert slist;
	}
	global void finish(Database.BatchableContext BC) {}
}