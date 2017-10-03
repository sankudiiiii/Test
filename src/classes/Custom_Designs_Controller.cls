global with sharing class Custom_Designs_Controller {
    public List<Product2> productList;
    public String email{get; set;}
    ApexPages.StandardController controller;
    public Custom_Designs_Controller() {
    	productList = new List<Product2>();
    	setProductList();
    }
    public Custom_Designs_Controller(ApexPages.StandardController controller){
		this.controller = controller;
	}
    public void setProductList() {
    	productList = [
    		SELECT Name
    			 , Description
    			 , Image_Document_Id__c 
    		  From Product2 
    		 WHERE IsActive = true 
    		   AND Family = 'Custom Bike'
    	];
    }
    public List<Product2> getProductList() {
    	return productList;
    }
    @RemoteAction
    global static String newLead(String em) {
    	if(em.length()>1){
    	List<List<sObject>> objList = [FIND :em IN EMAIL FIELDS Returning Account,Contact,Lead];
    	if(objList[0].size()>0 || objList[1].size()>0 || objList[2].size()>0)
    		return em;
    	}
    	return null;
    }
    public PageReference saveRecord(){
    	try{
    	insert controller.getRecord();
    	return new PageReference('javascript:window.close()');
    	} catch (Exception e){
    		return null;
    	}
    	
    }
    @RemoteAction
    global static boolean inquire(Id productId,String email) {
    	try{
    		Product2 productObj = [SELECT Name, Description FROM Product2 WHERE Id = :productId];
    		List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[]{};
			toAddresses.add(email);
			mail.setToAddresses(toAddresses);
			mail.setSubject('Custom Bike Info');
			mail.setPlainTextBody(productObj.Name+ ''+ productObj.Description);
			mailList.add(mail);
		Messaging.sendEmail(mailList , false);
    		return true;
    	} catch (Exception e){
    	return false;	
    	}
    }
}