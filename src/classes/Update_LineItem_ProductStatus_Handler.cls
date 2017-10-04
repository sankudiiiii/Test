public with sharing class Update_LineItem_ProductStatus_Handler {
    public static void executable(Map<Id , Product2> productMap) {
    	Map<Id , Product2> productExecuteMap = new Map<Id , Product2>();
    	for(Product2 productObj : productMap.values())
    		if(productObj.Family == null || productObj.Family == 'Custom Bike')
    			productExecuteMap.put(productObj.Id , productObj);
    	execute(productExecuteMap);
    }
    public static void execute(Map<Id , Product2> productMap) {
    	try {
	    	List<OpportunityLineItem> opportunityLineItemList= [
    			SELECT Id
    				 , Product_Status__c
    				 , Product2Id 
	    		  FROM OpportunityLineItem 
    			 WHERE Product2Id IN :productMap.keySet()
    		];
	    	for(Product2 productObj : productMap.values())
    			for(OpportunityLineItem opportunityLineItemObj : opportunityLineItemList)
    				if(opportunityLineItemObj.Product2Id == productObj.Id)
    					opportunityLineItemObj.Product_Status__c = productObj.Design_Process_Status__c;
	    	update opportunityLineItemList; 
    	} catch(Exception e) {
    		
    	}
    }
}