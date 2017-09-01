global with sharing class LeadDuplicateChecker implements Database.Batchable<sObject>{
	global set<lead> leadSet = new set<lead>();
    global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('select '+ System.label.Lead_Duplicate_Check_Fields+',createddate from lead');
	}
	global void execute(Database.BatchableContext BC, list<sObject> soList){
		list<lead> leadlist = (list<lead>) soList;
		Map<String,set<lead>> leadMap = new Map<String,set<lead>>();
		list<String> comparingFields = System.label.Lead_Duplicate_Check_Fields.split(',');
		for(lead l : leadList){
			for(lead l2 : leadlist){
				boolean flag=true;
				for(String s : comparingFields){
					if(l.get(s)!=l2.get(s)){
						flag=false;
					}
				}
				if(flag){
					String key='';
					for(String s : comparingFields){
						key+=s;
					}
					if(leadMap.containsKey(key)){
						set<lead> ls = leadMap.get(key);
						ls.add(l);
						ls.add(l2);
						leadMap.put(key,ls);						
					} else {
						set<lead> ls = new set<lead>();
						ls.add(l);
						ls.add(l2);
						leadMap.put(key,ls);
					}
				}
			}
		}
		for(String s : leadMap.keySet()){
			set<lead> ls = leadMap.get(s);
			if(ls.size()>1){
				lead winner = new lead();
				for(lead l : ls){
					for(lead l1 : ls){
						if(l1.createddate>l.createddate){
							winner=l;
						}						
					}
				}
				for(lead l : ls){
					if(l!=winner){
						leadset.add(l);
					}
				}
			}
		}		
	}
	global void finish(Database.BatchableContext BC){
		System.debug(leadset);
	}
}