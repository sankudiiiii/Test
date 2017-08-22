public with sharing class PM1S3Advance {
    public void getContacts(){
    	list<contact> conlist = [select id,name from contact];
    	for(contact con : conlist){
    		System.debug(con);
    	}
    }
    
    public void associatedContacts(){
    	list<account> acclist = [select id,name,(select id,name from contacts) from account];
    	for(account acc : acclist){
    		System.debug(acc+' Contacts : '+acc.contacts);
    	}
    }
    
    public void newRecords(){
    	Account acc = new Account(name='ACC');
    	insert acc;
    	Lead l = new Lead(lastname='LEAD',company='COMPANY');
    	insert l;
    	Contact con = new Contact(lastname='CON',experience__c=13);
    	insert con;
    	Opportunity opp = new Opportunity(name='OPP',stagename='Qualification',closedate=date.valueof('2017-08-20'));
    	insert opp;
    	System.debug(acc.id+' '+l.id+' '+opp.id+' '+con.id);
    }
    
    public void parentChild(){
    	list<account> acclist = [select id,name,(select id,name from contacts) from account];
    	for(Account acc : acclist){
    		System.debug(acc+' '+acc.contacts);
    	}
    }
    
    public void activeUsers(){
    	Map<id,user> userMap = new Map<id,user>();
    	list<user> ulist = [select id,name from user where isactive=true];
    	for(User u : ulist){
    		userMap.put(u.id,u);
    	}
    	for(id i : userMap.keyset()){
    		System.debug('Key : '+i+' Value : '+userMap.get(i));
    	}
    }
    
    public void accountMaps(){
    	Map<String,id> accMap1 = new Map<String,id>();
    	Map<id,account> accMap2 = new Map<id,account>();
    	list<account> acclist = [select id,name,createddate from account];
    	for(account acc : acclist){
    		accMap1.put(acc.name,acc.id);
    		accMap2.put(acc.id,acc);
    	}
    	System.debug('A');
    	for(String str : accMap1.keySet()){
    		System.debug(str+' '+accMap1.get(str));
    	}
    	System.debug('B');
    	for(Id i : accMap2.keySet()){
    		System.debug(i+' '+accMap2.get(i));
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
PM1S3Advance pm = new PM1S3Advance();
pm.getContacts();

pm.associatedContacts();

pm.newRecords();

pm.parentChild();

pm.activeUsers();

pm.accountMaps();

pm.databaseQueryDemo();

pm.databaseSearchDemo();
*/