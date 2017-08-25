public with sharing class ABCContainersInvoicesExtension {
	public list<OpportunityLineItem> lineitems;
	public 	OpportunityLineItem li;
	public 	Account acc{get;set;}
	public 	Opportunity opp{get;set;}
	public 	user usr{get;set;}
	ApexPages.StandardController controller;
	public ABCContainersInvoicesExtension(ApexPages.StandardController controller){
    	lineitems=new list<OpportunityLineItem>();
    	li=new OpportunityLineItem();
    	this.controller=controller;
    }    
    public list<OpportunityLineItem> getLineitems(){
    	if(lineitems.size()==0)
    		lineitems=retrieveLineitems();
    	return lineitems;
    }
    public list<OpportunityLineItem> retrieveLineitems(){
    	lineitems=[Select UnitPrice, TotalPrice, Quantity, Product2Id, Opportunityid, Name, ListPrice From OpportunityLineItem];
    	return lineitems;
    }
    public OpportunityLineItem getLi(){
    	li = retrieveLi((OpportunityLineItem) controller.getrecord());
    	return li;
    }
    public OpportunityLineItem retrieveLi(OpportunityLineItem oli){
    	li = [Select name, UnitPrice, ServiceDate, Quantity,  OpportunityId From OpportunityLineItem where id = :oli.id];
    	opp = [select ownerid,accountid,name from opportunity where id=:li.opportunityid];
    	acc = [select Phone, Name, Email_Address__c, BillingStreet, BillingState, BillingPostalCode, BillingCity from account where id=:opp.accountid];
    	usr = [select name,phone,email from user where id=:opp.ownerid];
    	return li;
    }
}