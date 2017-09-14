public with sharing class ABCContainersInvoicesExtension {
	public list<OpportunityLineItem> opportunityLineItemList;
	public Account accountInstance;
	public Opportunity opportunityInstance;
	public User userInstance;
	public String invoiceNo{get; set;}
	public ApexPages.StandardController controller;
	public String invoiceDate;
		
	public ABCContainersInvoicesExtension(ApexPages.StandardController controller) {
    	opportunityLineItemList = new list<OpportunityLineItem>();
    	this.controller = controller;
    	invoiceNo = '';
		setOpportunityInstance((Opportunity)controller.getrecord());
	}
	public Opportunity getOpportunityInstance() {
    	return opportunityInstance;
    }
    public void setOpportunityInstance(Opportunity opportunityObj) {
    	opportunityInstance = [
			SELECT OwnerId
    		 	 , AccountId
    		 	 , Name 
    		 	 , CloseDate
    		 	 , (SELECT UnitPrice
    			 		 , Quantity
    			 		 , discount
    			 		 , Product2.Name
    		 	 	  FROM OpportunityLineItems   		 	 
    		 	   )
    		  FROM Opportunity 
    		 WHERE Id = :opportunityObj.Id
		];
		setInvoiceDate();
		setOpportunityLineItemList();
		setAccountInstance();
    }
	public String getInvoiceDate() {
		invoiceDate = opportunityInstance.CloseDate.day().format() + '/' + opportunityInstance.CloseDate.month().format() + '/' + opportunityInstance.CloseDate.year().format().remove(',');
    	return invoiceDate;
	}
	public void setInvoiceDate() {
		invoiceDate = opportunityInstance.CloseDate.day().format() + '/' + opportunityInstance.CloseDate.month().format() + '/' + opportunityInstance.CloseDate.year().format().remove(',');
	} 
    public list<OpportunityLineItem> getOpportunityLineItemList() {
    	return opportunityLineItemList;
    }
    public void setOpportunityLineItemList() {
    	opportunityLineItemList = opportunityInstance.OpportunityLineItems;
    }
    public Account getAccountInstance() {
    	return accountInstance;
    }
    public void setAccountInstance() {
    	accountInstance = [
    		SELECT Phone
    		   	 , Name
    			 , Email_Address__c
    			 , BillingStreet
    			 , BillingState
    			 , BillingPostalCode
    			 , BillingCity 
    			 , OwnerId
    		  FROM Account 
    		 WHERE Id = :opportunityInstance.AccountId
    	];
		setUserInstance();
    }
    public User getUserInstance() {
    	return userInstance;
    }
    public void setUserInstance() {
    	userInstance = [
    		SELECT Name
    			 , Phone
    			 , Email 
    		  FROM User 
    		 WHERE Id = :accountInstance.OwnerId
    	];
    }
}