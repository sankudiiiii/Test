public with sharing class PM4S1A1Controller {
    public String searchString{get; set;}
    public list<list<sObject>> resultList{get; set;}
    public list<Account> accountList{get; set;}
    public list<Contact> contactList{get; set;}
    public list<Opportunity> opportunityList{get; set;}
    public list<Lead> leadList{get; set;}
    public PM4S1A1Controller() {
    	list<list<sObject>> resultList = new list<list<sObject>>();
    	accountList = new list<Account>();
    	contactList = new list<Contact>();
    	opportunityList = new list<Opportunity>();
    	leadList = new list<Lead>();
    }
    public PM4S1A1Controller(ApexPages.StandardController controller) {
    	list<list<sObject>> resultList = new list<list<sObject>>();
    	accountList = new list<Account>();
    	contactList = new list<Contact>();
    	opportunityList = new list<Opportunity>();
    	leadList = new list<Lead>();
    }
    public PageReference search() {
    	accountList.clear();
    	contactList.clear();
    	opportunityList.clear();
    	leadList.clear();
    	if(searchString.deleteWhiteSpace().length() > 1) {
    		String soslSearchString = searchString + '*';
    		resultList = [
    				 FIND :soslSearchString 
    				   IN NAME FIELDS 
    			RETURNING Account (Name)
    					, Contact (Name)
    					, Opportunity (Name) 
    					, Lead (Name)
    		];
    	}
    	for(list<sObject> results : resultList){
    		if(results.getsObjectType().getdescribe().getLabel() == 'Opportunity')
    			opportunityList = results;
    		else if(results.getsObjectType().getdescribe().getLabel() == 'Contact')
    			contactList = results;
    		else if(results.getsObjectType().getdescribe().getLabel() == 'Account')
    			accountList = results;
    		else
    			leadList = results;
    	}
    	return null;
    }
}