global with sharing class LeadDuplicateChecker implements Database.Batchable<sObject> , Database.Stateful {
	global List<sObject> deleteSet = new List<sObject>();
	global Map<String,set<Lead>> leadMap = new Map<String,set<Lead>>();
    global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('SELECT ' + System.label.Lead_Duplicate_Check_Fields + ' , Createddate FROM Lead WHERE '+ System.label.Lead_Duplicate_Check_Fields + ' != null');
	}
	global void execute(Database.BatchableContext BC , List<sObject> sObjectList) {
		List<Lead> leadList = sObjectList;
		String compareField = System.label.Lead_Duplicate_Check_Fields;
		for(lead leadInstance : leadList) {
			if(leadMap.containsKey((String)leadInstance.get(compareField))) {
				Set<Lead> leadSet = leadMap.get((String)leadInstance.get(compareField));
				leadSet.add(leadInstance);
				leadMap.put((String)leadInstance.get(compareField),leadSet);
			} else {
				Set<Lead> leadSet = new Set<Lead>();
				leadSet.add(leadInstance);
				leadMap.put((String)leadInstance.get(compareField),leadSet);
			}
		}
		for(String fieldName : leadMap.keySet()) {
			if(leadMap.get(fieldName).size() > 1) {
				lead winner;
				for(lead lead1 : leadMap.get(fieldName))
					for(lead lead2 : leadMap.get(fieldName))
						if(lead1 != lead2) {
							if(lead1.createddate > lead2.createddate)
								winner = lead2;
							else
								winner = lead1;
						}
				for(lead s1 : leadMap.get(fieldName))
					if(s1 != winner)
						deleteset.add(s1);
			}
		}
		delete deleteset;
	}
	global void finish(Database.BatchableContext BC) {
		
	}
}