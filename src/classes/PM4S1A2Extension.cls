public with sharing class PM4S1A2Extension {
    public list<Contact> contactList{get; set;}
    public list<Opportunity> opportunityList{get; set;}
    public ID accountId{get; set;}
    public PM4S1A2Extension(ApexPages.StandardSetController controller) {
    	contactList = new list<Contact>();
    	opportunityList = new list<Opportunity>();
    }
    public PageReference fetchContacts() {
    	Account accountInstance = [SELECT (SELECT name 
    									   FROM   contacts
    									  )
    									, (SELECT name 
    									   FROM   opportunities
    									  ) 
    							   FROM   Account 
    							   WHERE  id=:accountId
    							  ];
    	contactList = accountInstance.contacts;
    	opportunityList = accountInstance.opportunities;
    	return null;
    }
}