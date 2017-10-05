public with sharing class Custom_Bike_Invoice_Extension {
	public list<OpportunityLineItem> opportunityLineItemList;
	public Opportunity opportunityInstance;
	public User userInstance;
	public ApexPages.StandardController controller;
	public Custom_Bike_Invoice_Extension(ApexPages.StandardController controller) {
    	opportunityLineItemList = new list<OpportunityLineItem>();
    	this.controller = controller;
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
    		 	 , (SELECT ListPrice
    			 		 , Quantity
    			 		 , Product2.Name
    		 	 	  FROM OpportunityLineItems
    		 	 	 WHERE Product_Status__c = 'Review'   		 	 
    		 	   )
    		  FROM Opportunity 
    		 WHERE Id = :opportunityObj.Id
		];
		setOpportunityLineItemList();
		setUserInstance();
    }
    public list<OpportunityLineItem> getOpportunityLineItemList() {
    	return opportunityLineItemList;
    }
    public void setOpportunityLineItemList() {
    	opportunityLineItemList = opportunityInstance.OpportunityLineItems;
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
    		 WHERE Id = :opportunityInstance.OwnerId
    	];
    }
}