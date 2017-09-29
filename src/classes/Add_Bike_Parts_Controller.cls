public with sharing class Add_Bike_Parts_Controller {
    public Product2 customBike;
    public List<Product2> accessoryList{get; set;}
    public boolean added{get; set;}
    public Add_Bike_Parts_Controller() {
    	accessoryList = new List<Product2>();
    	setCustomBike(apexpages.currentpage().getparameters().get('id'));
    	added = false;
    }
    public void setCustomBike(Id product2Id) {
    	customBike = [
    		SELECT Name
    			 , Wheel__c
    			 , Turn_Signal__c
    			 , Tail_Light__c
    			 , Mirror__c
    			 , LogoOrSticker__c
    			 , Head_Light__c
    			 , Gauge__c
    			 , Exhaust__c
    			 , Engine__c 
    		  From Product2 
    		 WHERE Id = :product2Id
    	];
    	if(customBike.Wheel__c!=null)
    		accessoryList.add([
    			SELECT Name
    			 	 , Stock__c 
    			  From Product2 
    			 WHERE Id = :customBike.Wheel__c
    		]);
		if(customBike.Turn_Signal__c!=null)
    		accessoryList.add([
    			SELECT Name
    				 , Stock__c 
    			  From Product2 
    			 WHERE Id = :customBike.Turn_Signal__c
    		]);
    	if(customBike.Tail_Light__c!=null)
    		accessoryList.add([
    			SELECT Name
    			 	 , Stock__c 
    			  From Product2 
    			 WHERE Id = :customBike.Tail_Light__c
    		]);
    	if(customBike.Mirror__c!=null)
    		accessoryList.add([
    			SELECT Name
    				 , Stock__c 
    			  From Product2 
    			 WHERE Id = :customBike.Mirror__c
    		]);
    	if(customBike.LogoOrSticker__c!=null)
    		accessoryList.add([
    			SELECT Name
    				 , Stock__c 
    			  From Product2 
    			 WHERE Id = :customBike.LogoOrSticker__c
    		]);
    	if(customBike.Head_Light__c!=null)
    		accessoryList.add([
    			SELECT Name
    				 , Stock__c 
    			  From Product2 
    			 WHERE Id = :customBike.Head_Light__c
    		]);
    	if(customBike.Gauge__c!=null)
    		accessoryList.add([
    			SELECT Name
    				 , Stock__c 
    			  From Product2 
    			 WHERE Id = :customBike.Gauge__c
    		]);
    	if(customBike.Exhaust__c!=null)
    		accessoryList.add([
    			SELECT Name
    				 , Stock__c 
    			  From Product2 
    			 WHERE Id = :customBike.Exhaust__c
    		]);
    	if(customBike.Engine__c!=null)
    		accessoryList.add([
    			SELECT Name
    				 , Stock__c 
    			  From Product2 
    			 WHERE Id = :customBike.Engine__c
    		]);
    }
    public void updateAccessoryList() {
    	List<Id> productIdList = new List<Id>();
    	for(Product2 productObj : accessoryList) {
    		productObj.Stock__c -= 1;
    		productIdList.add(productObj.Id);
    	}
    	added = true;
    	update accessoryList;
    	List<PriceBookEntry> priceBookEntryList = [
    		SELECT UnitPrice 
    		  FROM PriceBookEntry 
    		 WHERE Product2Id IN :productIdList
    	];
    	PriceBookEntry customBikePriceBookEntryObj = [
    		SELECT UnitPrice 
    		  FROM PriceBookEntry 
    		 WHERE Product2Id = :customBike.Id
    	];
    	for(PriceBookEntry priceBookEntryObj : priceBookEntryList)
    		customBikePriceBookEntryObj.UnitPrice += priceBookEntryObj.UnitPrice;
    	update customBikePriceBookEntryObj;
    }
    public Product2 getCustomBike() {
    	return customBike;
    }
}