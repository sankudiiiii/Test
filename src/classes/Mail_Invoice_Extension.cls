public with sharing class Mail_Invoice_Extension {
    public list<OpportunityLineItem> opportunityLineItemList;
	public Opportunity opportunityInstance;
	public String message;
    public boolean sent{get; set;}
    public Mail_Invoice_Extension(ApexPages.StandardController controller) {
    	opportunityLineItemList = new list<OpportunityLineItem>();
		setOpportunityInstance((Opportunity)controller.getrecord());
    	sent = false;
    	sendMail();
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
    			 		 , Customer_Email__c 
    		 	 	  FROM OpportunityLineItems   		 	 
    		 	   )
    		  FROM Opportunity 
    		 WHERE Id = :opportunityObj.Id
		];
		setOpportunityLineItemList();
    }
    public list<OpportunityLineItem> getOpportunityLineItemList() {
    	return opportunityLineItemList;
    }
    public void setOpportunityLineItemList() {
    	opportunityLineItemList = opportunityInstance.OpportunityLineItems;
    }
	public void setMessage(){
		if(sent)
			message = 'Email sent';
		else
			message = 'Email not sent';
	}
	public String getMessage(){
		return message;
	}
    public void sendMail(){
    List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[]{};
			for(OpportunityLineItem opportunityLineItemInstance : opportunityLineItemList)
				toAddresses.add(opportunityLineItemInstance.Customer_Email__c);
			mail.setToAddresses(toAddresses);
			mail.setSubject('PDF Demo');
			String textBody = 'Demo';
			mail.setPlainTextBody(textBody);
			mailList.add(mail);
		Messaging.sendEmail(mailList , false);
    }
}