public with sharing class Custom_Designs_Controller {
    public List<Product2> productList;
    public Id documentId;
    public Custom_Designs_Controller(){
    	productList = new List<Product2>();
    	setProductList();
    }
    public void setProductList(){
    	productList = [SELECT Wheel__c, Turn_Signal__c, Image_Document_Id__c,Tail_Light__c, Name, Mirror__c, LogoOrSticker__c, Image__c,  Head_Light__c,Gauge__c, Exhaust__c,Engine__c, Description From Product2 WHERE IsActive = true AND Family='Custom Bike'];
    }
    public List<Product2> getProductList(){
    	return productList;
    }
    public Blob getImage(){
    	Document doc = [SELECT Body FROM Document WHERE Id = :documentId];
    	return doc.Body;
    }
}