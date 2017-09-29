public with sharing class Bike_Parts_Availability_Controller {
    public Product2 customBike;
    public List<Product2> accessoryList{get; set;}
    public String availability;
    public Bike_Parts_Availability_Controller() {
    	accessoryList = new List<Product2>();
    	setCustomBike(apexpages.currentpage().getparameters().get('id'));
    	setAvailability();
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
    public Product2 getCustomBike() {
    	return customBike;
    }
    public void setAvailability() {
    	availability = 'Available';
    	for(Product2 productObj : accessoryList)
    		if(productObj.Stock__c == 0){
    			availability = 'Not Available';
    			break;
    		}
    }
    public String getAvailability() {
    	return availability;
    }
}