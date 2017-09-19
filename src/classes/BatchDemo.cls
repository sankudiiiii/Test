global class BatchDemo implements Database.Batchable<sObject> {
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return start();
	}
	global Database.QueryLocator start(){
		return Database.getQueryLocator('SELECT Id, Name FROM Account');
	}
	global void execute(Database.BatchableContext BC, list<sObject> sObjectList) {
	
	}
	global void finish(Database.BatchableContext BC) {
	
	}
}