public with sharing class PM1S2Advance {
    public void getAccountRecordsA(){
    	List<account> accList = [select id from account];
for(Account acc : accList){
System.debug(acc.id);
}
    }
    public void getAccountRecords(){
    	for(sObject s : [select id from account])
System.debug(s.id);

List<opportunity> oppList = [select id from opportunity where account.name != null and stagename='closed won'];
for(opportunity opp : oppList){
System.debug(opp.id);
}
    }
    
    public void getOpportunityList(){
    	List<opportunity> oppList = [select id from opportunity where account.name != null and stagename='closed won'];
for(opportunity opp : oppList){
System.debug(opp.id);
    }
}
    public void getOpportunitySet(){
    	Set<opportunity> oppSet = new Set<opportunity>{};
List<opportunity> oppList = [select id from opportunity where account.name != null and stagename='closed won'];
for(opportunity opp : oppList){
oppSet.add(opp);
}
for(opportunity opp : oppSet){
System.debug(opp.id);
}
    }
    
    public void getOpportunityMap(){
    	map<id,id> oppMap = new map<id,id>{};
List<opportunity> s = [select id,account.id from opportunity where account.name != null and stagename='closed won'];
for(opportunity opp : s){
oppMap.put(opp.id,opp.account.id);
}
for(id oppId : oppMap.keyset()){
System.debug('Opportunity Id : '+oppId+' Account Id : '+oppMap.get(oppId));
}
    }
    
    public void ChangeNamesStartingWithA(){
    	list<account> accList = [select name from account where name like 'a%'];
for(Account acc : acclist){
acc.name='bbc';
}
update accList;
System.debug(acclist);
    }
    
    public void getAccountOpportunityMap(){
    	Map<id,List<id>> mapAO = new Map<id,List<id>>{};
list<Account> accList = [select id,(select id from opportunities) from account];
for(Account acc : accList){
	List<id> oppId = new list<id>();	
for(Opportunity opp : acc.opportunities){
	oppId.add(opp.id);
}
	mapAO.put(acc.id,oppId);
}
System.debug(mapAO);
    }
    
    public void getTenCampaignAsc(){
    	List<campaign> campList = [select id,name from campaign order by name asc limit 10];
for(campaign camp : campList){
	System.debug(camp.name +'	'+camp.id);
}
    }
    
    public void getTenCampaignDesc(){
    	List<campaign> campList = [select id,name from campaign order by name desc limit 10];
for(campaign camp : campList){
	System.debug(camp.name +'	'+camp.id);
}
    }
    
    public void getTodayUpdatedContacts(){
    	List<contact> conList = [select id,name from contact where lastmodifieddate = today];
for(contact con : conList){
	System.debug(con.id +'	'+con.name);
}
    }
    
    public void databaseQueryDemo(){
    	Integer conEx = 29;
list<sObject> s = Database.query('select id,name from contact where experience__c =: conEx');
for(sObject c : s)
	System.debug(c.id);
    }
    
    public void databaseSearchDemo(){
    	String fString= 'bbc';
list<list<sObject>> s = search.query('find :fString in all fields returning account(ownerID), contact(experience__c)');
for(list<sObject> s1 : s){
system.debug(s1);
}
    }
}
/*
PM1S2Advance a = new PM1S2Advance();
a.getAccountRecordsA();

a.getAccountRecords();

a.getOpportunityList();

a.getOpportunitySet();

a.getOpportunityMap();

a.ChangeNamesStartingWithA();

a.getAccountOpportunityMap();

a.getTenCampaignAsc();

a.getTenCampaignDesc();

a.getTodayUpdatedContacts();

a.databaseQueryDemo();

a.databaseSearchDemo();
*/