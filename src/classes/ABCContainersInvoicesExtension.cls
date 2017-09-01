public with sharing class ABCContainersInvoicesExtension {
	public list<OpportunityLineItem> lineitems;
	public OpportunityLineItem li;
	public Account acc{get;set;}
	public Opportunity opp{get;set;}
	public user usr{get;set;}
	public String invoiceNo{get;set;}
	public ApexPages.StandardController controller;
	public Decimal taxamount{get;set;}
	public Decimal labour{get;set;}
	public Decimal total{get;set;}
	public Decimal licost{get;set;}
	public Decimal discount{get;set;}
	public Integer count;
	public String dt;
		
	public ABCContainersInvoicesExtension(ApexPages.StandardController controller){
    	lineitems=new list<OpportunityLineItem>();
    	li=new OpportunityLineItem();
    	this.controller=controller;
    	taxamount=0;
    	labour=0;
		total=0;
		licost=0;
		discount=0;
		invoiceNo=ApexPages.currentPage().getParameters().get('no');
		count=000000;
	}   
	public Integer getCount(){
		return ++count;
	}
	public String getDt(){
		li = getLi();
		dt = li.servicedate.day().format()+'/'+li.servicedate.month().format()+'/'+li.servicedate.year().format().remove(',');
    	return dt;
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
    	li = [Select name, UnitPrice, ServiceDate, Quantity,  OpportunityId,discount, service_fee__c,labour_hour__c,labour_rate__c,tax__c From OpportunityLineItem where id = :oli.id];
    	opp = [select ownerid,accountid,name from opportunity where id=:li.opportunityid];
    	acc = [select Phone, Name, Email_Address__c, BillingStreet, BillingState, BillingPostalCode, BillingCity from account where id=:opp.accountid];
    	usr = [select name,phone,email from user where id=:opp.ownerid];
    	labour=li.labour_hour__c*li.labour_rate__c;
    	licost=Math.round(li.unitprice*li.quantity/10)*10.00;
    	discount = Math.round((li.service_fee__c+labour+licost)*li.discount/100/10)*10.00;
    	taxamount = Math.round((li.service_fee__c+labour+licost-discount)*li.tax__c/100/10)*10.00;
    	total = li.service_fee__c+labour+licost-discount+taxamount;
    	return li;
    }
}