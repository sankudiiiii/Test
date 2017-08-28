public with sharing class ABCContainersInvoicesExtension {
	public list<OpportunityLineItem> lineitems;
	public OpportunityLineItem li;
	public Account acc{get;set;}
	public Opportunity opp{get;set;}
	public user usr{get;set;}
	public Integer count;
	public Integer invoiceNo{get;set;}
	ApexPages.StandardController controller;
	public Decimal servicefee{get;set;}
	public Decimal labourhour{get;set;}
	public Decimal labourcost{get;set;}
	public Decimal tax{get;set;}
	public Decimal taxamount;
	public Decimal labour{get;set;}
	public Decimal total;
	public Decimal sum;
	public Decimal licost;
	
	public ABCContainersInvoicesExtension(ApexPages.StandardController controller){
    	lineitems=new list<OpportunityLineItem>();
    	li=new OpportunityLineItem();
    	this.controller=controller;
    	count=0;
    	servicefee=200.00;
		labourhour=5;
		labour=75.00;
		tax = 4.25;
		labourcost=labour*labourhour;
		total=0;
		licost=0;
		sum=0;
    }    
    public Integer getCount(){
    	return ++count;    	
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
    	System.debug(acc);
    	return li;
    }
    public Decimal getLicost(){
    	licost = li.quantity * li.unitprice;
    	return Math.round(licost / 10) * 10.00;
    }
    public Decimal getTaxamount(){
    	sum = servicefee + licost + labourcost;
    	taxamount = sum * tax / 100;
    	return Math.round(taxamount * 100) / 100.0;
    }
    public Decimal getTotal(){
    	total = sum + taxamount;
    	return Math.round(total * 100) / 100.00;
    }
}