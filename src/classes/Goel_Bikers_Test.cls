@isTest
private class Goel_Bikers_Test {/*
	public static testmethod void test_Product_After_Insert_Trigger() {
		TestDataFactory.generateGoelBikersTestData();
		Product2 productObj = new Product2(Name = 'P1');
		Test.startTest();
			insert productObj;
		Test.stopTest();
		List<PriceBookEntry> priceBookEntryList = [
			SELECT Id 
			  FROM PriceBookEntry
		];
		System.assert(priceBookEntryList.size() > 0 , 'Trigger handler failed');
	}
	public static testmethod void test_Product_After_Update_Trigger() {
		TestDataFactory.generateGoelBikersTestData();
		Product2 productObj = new Product2(Name = 'P1');
		Opportunity opportunityObj = [
			SELECT Id 
			  FROM Opportunity
		];
		insert productObj;
		PriceBookEntry priceBookEntryObj = [
			SELECT Id 
			  FROM PriceBookEntry
		];
		OpportunityLineItem opportunityLineItemObj = new OpportunityLineItem(OpportunityId = opportunityObj.Id , PriceBookEntryId = priceBookEntryObj.id , UnitPrice = 100 , Quantity = 1 , ServiceDate = System.today());
		insert opportunityLineItemObj;
		Test.startTest();
			productObj.Design_Process_Status__c = 'Review';
			update productObj;
		Test.stopTest();
		opportunityLineItemObj = [
			SELECT Product_Status__c 
			  FROM OpportunityLineItem 
			 WHERE PriceBookEntryId = :priceBookEntryObj.id
		];
		System.assertEquals('Review' , opportunityLineItemObj.Product_Status__c , 'Failed to update line item status');
	}
	public static testmethod void LineItem_Add_CustomerEmail_Handler() {
		TestDataFactory.generateGoelBikersTestData();
		Product2 productObj = new Product2(Name = 'P1');
		Opportunity opportunityObj = [
			SELECT Id 
			  FROM Opportunity
		];
		Account accountObj = [
			SELECT Email_Address__c 
			  FROM Account
		];
		accountObj.Email_Address__c = null;
		update accountObj;
		insert productObj;
		PriceBookEntry priceBookEntryObj = [
			SELECT Id 
			  FROM PriceBookEntry
		];
		OpportunityLineItem opportunityLineItemObj = new OpportunityLineItem(OpportunityId = opportunityObj.Id , PriceBookEntryId = priceBookEntryObj.id , UnitPrice = 100 , Quantity = 1 , ServiceDate = System.today());
		insert opportunityLineItemObj;
		Test.startTest();
			productObj.Design_Process_Status__c = 'Review';
			update productObj;
		Test.stopTest();
		opportunityLineItemObj = [
			SELECT Product_Status__c 
			  FROM OpportunityLineItem 
			 WHERE PriceBookEntryId = :priceBookEntryObj.id
		];
		System.assertEquals('Review' , opportunityLineItemObj.Product_Status__c , 'Failed to update line item status');
	}*/
	public static testmethod void test_Bike_Parts_Availability_Controller(){
		TestDataFactory.generateBikePartsTestData();
		Product2 productObj = [SELECT Id FROM Product2 WHERE Name = 'bike'];
		apexpages.currentpage().getparameters().put('id',productObj.Id);
		Test.startTest();
			Bike_Parts_Availability_Controller controller = new Bike_Parts_Availability_Controller();
		Test.stopTest();
		System.assertEquals(productObj.Id,controller.getCustomBike().Id,'setter failed');
		System.assertEquals('Available',controller.getAvailability(),'setter failed');
		
	}
}