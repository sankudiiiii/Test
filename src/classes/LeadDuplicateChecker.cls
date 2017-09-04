global with sharing class LeadDuplicateChecker implements Database.Batchable<sObject>,Database.Stateful{
	global list<sObject> deleteSet = new list<sObject>();
	global Map<String,set<lead>> leadMap = new Map<String,set<lead>>();
    global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('select '+ System.label.Lead_Duplicate_Check_Fields+',createddate from lead where '+ System.label.Lead_Duplicate_Check_Fields+' != null');
	}
	global void execute(Database.BatchableContext BC, list<sObject> soList){
		list<lead> leadlist = soList;
		String compareField = System.label.Lead_Duplicate_Check_Fields;
		for(lead l : leadList){
			if(leadMap.containsKey((String)l.get(compareField))){
				set<lead> leadset = leadMap.get((String)l.get(compareField));
				leadset.add(l);
				leadMap.put((String)l.get(compareField),leadset);
			} else {
				set<lead> leadset = new set<lead>();
				leadset.add(l);
				leadMap.put((String)l.get(compareField),leadset);
			}
		}
		for(String s : leadMap.keySet()){
			if(leadMap.get(s).size()>1){
				lead winner;
				for(lead s1 : leadMap.get(s)){
					for(lead s2 : leadMap.get(s)){
						if(s1!=s2){
							if(s1.createddate>s2.createddate){
								winner = s2;
							} else {
								winner = s1;
							}
						}
					}
				}
				for(lead s1 : leadMap.get(s)){
					if(s1 != winner){
						deleteset.add(s1);
					}
				}
			}
		}
		delete deleteset;
	}
	global void finish(Database.BatchableContext BC){
		
	}
}