public with sharing class Add_Price_Handler {
    public static void executable(Map<Id , Product2> productMap) {
    	Map<Id , Product2> productExecuteMap = new Map<Id , Product2>();
    	for(Product2 productObj : productMap.values())
    		if(productObj.Family == null || productObj.Family == 'Custom Bike')
    			productExecuteMap.put(productObj.Id , productObj);
    	execute(productExecuteMap);
    }
    public static void execute(Map<Id , Product2> productMap) {
    	PriceBook2 priceBook2Obj = [
    		SELECT Id 
    		  FROM PriceBook2 
    		 WHERE IsStandard = true
    	];
    	List<PriceBookEntry> priceBookEntryList = new List<PriceBookEntry>();
    	for(Product2 productObj : productMap.values())
    		priceBookEntryList.add(new PriceBookEntry(IsActive = true , PriceBook2Id = priceBook2Obj.Id , UseStandardPrice = false , UnitPrice = 0 , Product2Id = productObj.Id));
    	insert priceBookEntryList;
    	List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
    	for(Product2 productObj : productMap.values())
    		for(PriceBookEntry priceEntryObj : priceBookEntryList)
    			opportunityLineItemList.add(new OpportunityLineItem(OpportunityId = productObj.Deal__c , PriceBookEntryId = priceEntryObj.id , UnitPrice = 0 , Quantity = 1 , ServiceDate = System.today()));
    	insert opportunityLineItemList;
    }
}