public with sharing class Add_Price_Handler {
    public static void executable(Map<Id , Product2> productMap) {
    	execute(productMap);
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
    }
}