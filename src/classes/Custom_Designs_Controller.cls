public with sharing class Custom_Designs_Controller {
    public List<Product2> productList;
    public Custom_Designs_Controller() {
    	productList = new List<Product2>();
    	setProductList();
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
}