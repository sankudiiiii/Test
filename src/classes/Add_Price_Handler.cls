public with sharing class Add_Price_Handler {
    public static void executable(List<Product2> productList){
    	execute(productList);
    }
    public static void execute(List<Product2> productList){
    	PriceBook2 priceBook2Obj = [
    		SELECT Id 
    		  FROM PriceBook2 
    		 WHERE IsStandard = true
    	];
    	List<PriceBookEntry> priceBookEntryList = new List<PriceBookEntry>();
    	for(Product2 productObj : productList)
    		priceBookEntryList.add(new PriceBookEntry(IsActive = true , PriceBook2Id = priceBook2Obj.Id , UseStandardPrice = false , UnitPrice = 0 , Product2Id = productObj.Id));
    	insert priceBookEntryList;
    }
}