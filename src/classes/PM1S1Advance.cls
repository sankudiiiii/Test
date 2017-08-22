public with sharing class PM1S1Advance {
    public void getAccountRecords(){
    	list<account> acclist = [select id,name from account];
    	for(Integer i = 0;i<acclist.size();i++){
    		System.debug(acclist.get(i));
    	}
    }
    
    public void getAccountRecordsAdvance(){
    	for(account acc : [select id,name from account]){
    		System.debug(acc);
    	}
    }
    
    public void getAccountRecordsWhile(){
    	Integer index = 0;
    	list<account> acclist = [select id,name from account];
    	while(index<acclist.size()){
    		System.debug(acclist.get(index));
    		index++;
    	}
    }
    
    public void getLeadId(){
    	set<id> leadset = new set<id>();
    	for(lead l : [select id from lead]){
    		leadset.add(l.id);
    	}
    	for(id i : leadset){
    		System.debug(i);
    	}
    }
    
    public void updateContactCount(){
    	aggregateresult agg = [select count(id) from contact where account.name='Eternus'];
		list<account> acclist = [select contact_count__c from account where name='Eternus'];
		for(account acc : acclist){
			acc.contact_count__c=(Integer)agg.get('expr0');
		}
		update acclist;
    }
    
    public void getWonLeads(){
    	list<lead> leadlist = [select name,status from lead where status='Won'];
    	for(lead l : leadlist){
    		l.stage__c='New';
    	}
    	update leadlist;
    }
    
    public void childParentRelationship(){
    	list<contact> conlist = [select id,account.name from  contact];
    	for(contact con : conlist){
    		System.debug('Contact Id : '+con.id+' Account Name : '+con.account.name);
    	}
    }
    
    public void getAccountsCreatedToday(){
    	list<account> acclist = [select id,name,createddate from account where createddate=today];
    	for(account acc : acclist){
    		System.debug('Account Name : '+acc.name+' Created Date : '+acc.createddate);
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
PM1S1Advance pm = new PM1S1Advance();
pm.getAccountRecords();

pm.getAccountRecordsAdvance();

pm.getAccountRecordsWhile();

pm.getLeadId();

pm.updateContactCount();

pm.getWonLeads();

pm.childParentRelationship();

pm.getAccountsCreatedToday();

pm.databaseQueryDemo();

pm.databaseSearchDemo();
*/