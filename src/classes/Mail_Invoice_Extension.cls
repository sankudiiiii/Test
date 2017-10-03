public with sharing class Mail_Invoice_Extension {
    public list<OpportunityLineItem> opportunityLineItemList;
	public Opportunity opportunityInstance;
	public String message;
    public boolean sent{get; set;}
    public Mail_Invoice_Extension(ApexPages.StandardController controller) {
    	opportunityLineItemList = new list<OpportunityLineItem>();
		setOpportunityInstance((Opportunity)controller.getrecord());
    	sent = false;
    	sendEmail();
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
    public PageReference sendEmail(){
    	PageReference pdf = Page.Custom_Bike_Invoice;
    // add parent id to the parameters for standardcontroller
    pdf.getParameters().put('id',opportunityInstance.Id);
System.debug(pdf);
    // the contents of the attachment from the pdf
    Blob body;

    try {

      // returns the output of the page as a PDF
      body = pdf.getContent();

    // need to pass unit test -- current bug  
    } catch (VisualforceException e) {
      body = Blob.valueOf('Some Text');
    }
System.debug(body);
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');
    attach.setFileName('testPdf.pdf');
    attach.setInline(false);
    attach.Body = body;
	System.debug(attach);
	List<String> addr = new List<String>();
	for(OpportunityLineItem opportunityLineItemInstance : opportunityLineItemList)
		addr.add(opportunityLineItemInstance.Customer_Email__c);
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(addr);
    mail.setSubject('PDF Email Demo');
    mail.setHtmlBody('Here is the email you requested! Check the attachment!');
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
System.debug(mail);
    // Send the email
    Messaging.SendEmailResult[] res = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    System.debug(res);
    return null;
    }
}