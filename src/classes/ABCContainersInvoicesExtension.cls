public with sharing class ABCContainersInvoicesExtension {
	public list<OpportunityLineItem> opportunityLineItemList;
	public OpportunityLineItem opportunityLineItemInstance;
	public Account accountInstance{get; set;}
	public Opportunity opportunityInstance{get; set;}
	public User userInstance{get; set;}
	public String invoiceNo{get; set;}
	public ApexPages.StandardController controller;
	public Decimal taxamount{get; set;}
	public Decimal labour{get; set;}
	public Decimal total{get; set;}
	public Decimal lineItemCost{get; set;}
	public Decimal discount{get; set;}
	public Integer count;
	public String dt;
		
	public ABCContainersInvoicesExtension(ApexPages.StandardController controller) {
    	opportunityLineItemList = new list<OpportunityLineItem>();
    	OpportunityLineItemInstance = new OpportunityLineItem();
    	this.controller = controller;
    	taxamount = 0;
    	labour = 0;
		total = 0;
		lineItemCost = 0;
		discount = 0;
		invoiceNo = ApexPages.currentPage().getParameters().get('no');
		count = 000000;
	}   
	public Integer getCount() {
		return ++count;
	}
	public String getDt() {
		OpportunityLineItemInstance = getOpportunityLineItemInstance();
		dt = OpportunityLineItemInstance.servicedate.day().format() + '/' + OpportunityLineItemInstance.servicedate.month().format() + '/' + OpportunityLineItemInstance.servicedate.year().format().remove(',');
    	return dt;
	} 
    public list<OpportunityLineItem> getOpportunityLineItemList() {
    	if(opportunityLineItemList.size() == 0)
    		opportunityLineItemList=retrieveLineitems();
    	return opportunityLineItemList;
    }
    public list<OpportunityLineItem> retrieveLineitems() {
    	opportunityLineItemList = [
    		Select UnitPrice
    			 , TotalPrice
    			 , Quantity
    			 , Product2Id
    			 , Opportunityid
    			 , Name
    			 , ListPrice 
    		  From OpportunityLineItem
    	];
    	return opportunityLineItemList;
    }
    public OpportunityLineItem getOpportunityLineItemInstance() {
    	OpportunityLineItemInstance = retrieveLi((OpportunityLineItem) controller.getrecord());
    	return OpportunityLineItemInstance;
    }
    public OpportunityLineItem retrieveLi(OpportunityLineItem oli) {
    	OpportunityLineItemInstance = [
    		SELECT Name
    			 , UnitPrice
    			 , ServiceDate
    			 , Quantity
    			 , OpportunityId
    			 , discount
    			 , service_fee__c
    			 , labour_hour__c
    			 , labour_rate__c
    			 , tax__c 
    		  FROM OpportunityLineItem 
    		 WHERE Id = :oli.id
    	];
    	opportunityInstance = [
    		SELECT OwnerId
    		 	 , AccountId
    		 	 , Name 
    		  FROM Opportunity 
    		 WHERE Id = :OpportunityLineItemInstance.OpportunityId
    	];
    	accountInstance = [
    		SELECT Phone
    		   	 , Name
    			 , Email_Address__c
    			 , BillingStreet
    			 , BillingState
    			 , BillingPostalCode
    			 , BillingCity 
    		  FROM Account 
    		 WHERE Id = :opportunityInstance.AccountId
    	];
    	userInstance = [
    		SELECT Name
    			 , Phone
    			 , Email 
    		  FROM User 
    		 WHERE Id = :opportunityInstance.OwnerId
    	];
    	labour = OpportunityLineItemInstance.labour_hour__c * OpportunityLineItemInstance.labour_rate__c;
    	lineItemCost = Math.round(OpportunityLineItemInstance.unitprice * OpportunityLineItemInstance.quantity / 10) * 10.00;
    	discount = Math.round((OpportunityLineItemInstance.service_fee__c + labour + lineItemCost) * OpportunityLineItemInstance.discount / 100 / 10) * 10.00;
    	taxamount = Math.round((OpportunityLineItemInstance.service_fee__c + labour + lineItemCost - discount) * OpportunityLineItemInstance.tax__c / 100 / 10) * 10.00;
    	total = OpportunityLineItemInstance.service_fee__c + labour + lineItemCost - discount + taxamount;
    	return OpportunityLineItemInstance;
    }
}