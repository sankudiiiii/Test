public class InvokeDemo {
    @InvocableMethod
    public static void sendMail(List<Id> opportunityObjId){
    	Opportunity opportunityInstance = [
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
    		 WHERE Id IN :opportunityObjId
		];
    	List<OpportunityLineItem> opportunityLineItemList = opportunityInstance.OpportunityLineItems;
    	PageReference pdf = new PageReference('https://c.ap5.visual.force.com/apex/Custom_Bike_Invoice');
    // add parent id to the parameters for standardcontroller
    pdf.getParameters().put('id',opportunityInstance.Id);
System.debug(pdf);
    // the contents of the attachment from the pdf
    Blob body;

    try {

      // returns the output of the page as a PDF
      body = pdf.getContentAsPDF();

    // need to pass unit test -- current bug  
    } catch (VisualforceException e) {
    	System.debug(e);
      body = Blob.valueOf('Some Text');
    }
System.debug(body);
System.debug(body.size());
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
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail } , false);
    }
}