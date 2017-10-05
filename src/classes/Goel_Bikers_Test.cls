@isTest
private class Goel_Bikers_Test {
	public static testmethod void test_Product_After_Insert_Trigger() {
		GoelBikers_TestDataFactory.generateGoelBikersTestData();
		Opportunity opportunityObj = [
			SELECT Id 
			  FROM Opportunity
		];
		Product2 productObj = new Product2(Name = 'P1' , Deal__c = opportunityObj.Id);
		Test.startTest();
			insert productObj;
		Test.stopTest();
		List<PriceBookEntry> priceBookEntryList = [
			SELECT Id 
			  FROM PriceBookEntry
			 WHERE Product2Id = :productObj.Id
		];
		System.assert(priceBookEntryList.size() > 0 , 'Trigger handler failed');
	}
	public static testmethod void test_Product_After_Update_Trigger() {
		GoelBikers_TestDataFactory.generateGoelBikersTestData();
		Opportunity opportunityObj = [
			SELECT Id 
			  FROM Opportunity
		];
		Product2 productObj = new Product2(Name = 'P1' , Deal__c = opportunityObj.Id);
		insert productObj;
		PriceBookEntry priceBookEntryObj = [
			SELECT Id 
			  FROM PriceBookEntry
			 WHERE Product2Id = :productObj.Id
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
			 WHERE Id = :opportunityLineItemObj.id
		];
		System.assertEquals('Review' , opportunityLineItemObj.Product_Status__c , 'Failed to update line item status');
	}
	public static testmethod void LineItem_Add_CustomerEmail_Handler() {
		GoelBikers_TestDataFactory.generateGoelBikersTestData();
		Opportunity opportunityObj = [
			SELECT Id 
			  FROM Opportunity
		];
		Product2 productObj = new Product2(Name = 'P1' , Deal__c = opportunityObj.Id);
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
			 WHERE Product2Id = :productObj.Id
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
			 WHERE Id = :opportunityLineItemObj.id
		];
		System.assertEquals('Review' , opportunityLineItemObj.Product_Status__c , 'Failed to update line item status');
	}
	public static testmethod void test_Bike_Parts_Availability_Controller() {
		GoelBikers_TestDataFactory.generateGoelBikersTestData();
		Product2 productObj = [
			SELECT Id 
			  FROM Product2 
			 WHERE Name = 'bike'
		];
		apexpages.currentpage().getparameters().put('id' , productObj.Id);
		Test.startTest();
			Bike_Parts_Availability_Controller controller = new Bike_Parts_Availability_Controller();
		Test.stopTest();
		System.assertEquals(productObj.Id , controller.getCustomBike().Id , 'setter failed');
		System.assertEquals('Available' , controller.getAvailability() , 'setter failed');
	}
	public static testmethod void test_Bike_Parts_Availability_Controller_Negative() {
		GoelBikers_TestDataFactory.generateGoelBikersTestData();
		Product2 productObj = [
			SELECT Id 
			  FROM Product2 
			 WHERE Name = 'bike'
		];
		Product2 engine = [
			SELECT Id 
				 , stock__c 
			  FROM Product2 
			 WHERE Name = 'engine'
		];
		engine.stock__c = 0;
		update engine;
		apexpages.currentpage().getparameters().put('id' , productObj.Id);
		Test.startTest();
			Bike_Parts_Availability_Controller controller = new Bike_Parts_Availability_Controller();
		Test.stopTest();
		System.assertEquals(productObj.Id , controller.getCustomBike().Id , 'setter failed');
		System.assertEquals('Not Available' , controller.getAvailability() , 'accessory list failed');
	}
	public static testmethod void test_Add_Bike_Parts_Controller() {
		GoelBikers_TestDataFactory.generateGoelBikersTestData();
		Product2 productObj = [
			SELECT Id 
			  FROM Product2 
			 WHERE Name = 'bike'
		];
		apexpages.currentpage().getparameters().put('id' , productObj.Id);
		Test.startTest();
			Add_Bike_Parts_Controller controller = new Add_Bike_Parts_Controller();
		Test.stopTest();
		System.assertEquals(productObj.Id , controller.getCustomBike().Id , 'setter failed');
	}
	public static testmethod void test_Add_Bike_Parts_Controller_updateAccessoryList() {
		GoelBikers_TestDataFactory.generateGoelBikersTestData();
		Product2 productObj = [
			SELECT Id 
			  FROM Product2 
			 WHERE Name = 'bike'
		];
		
		apexpages.currentpage().getparameters().put('id' , productObj.Id);
		Test.startTest();
			Add_Bike_Parts_Controller controller = new Add_Bike_Parts_Controller();
			controller.updateAccessoryList();
		Test.stopTest();
		System.assertEquals(true , controller.added , 'update stock failed failed');
	}
	public static testmethod void test_Custom_Bike_Invoice_Extension() {
		GoelBikers_TestDataFactory.generateGoelBikersTestData();
		Opportunity opportunityObj = [
			SELECT Id 
				 , OwnerId
			  FROM Opportunity
		];
		Product2 productObj = new Product2(Name = 'P1' , Deal__c = opportunityObj.Id);
		insert productObj;
		PriceBookEntry priceBookEntryObj = [
			SELECT Id 
			  FROM PriceBookEntry
			 WHERE Product2Id = :productObj.Id
		];
		OpportunityLineItem opportunityLineItemObj = new OpportunityLineItem(OpportunityId = opportunityObj.Id , PriceBookEntryId = priceBookEntryObj.id , UnitPrice = 100 , Quantity = 1 , ServiceDate = System.today());
		insert opportunityLineItemObj;
		ApexPages.StandardController controller = new ApexPages.StandardController(opportunityObj);
		Test.startTest();
			Custom_Bike_Invoice_Extension ext = new Custom_Bike_Invoice_Extension(controller);
		Test.stopTest();
		System.assertEquals(opportunityObj.Id , ext.getOpportunityInstance().Id , 'setter failed');
		System.assertEquals(opportunityObj.OwnerId , ext.getUserInstance().Id , 'setter failed');
	}
	public static testmethod void test_Book_Appointment_Extension() {
		GoelBikers_TestDataFactory.generateGoelBikersTestData();
		Opportunity opportunityObj = [
			SELECT Id 
				 , OwnerId
			  FROM Opportunity
		];
		Event eventObj = new Event(StartDateTime = System.today());
		ApexPages.StandardController controller = new ApexPages.StandardController(eventObj);
		apexpages.currentpage().getparameters().put('id' , opportunityObj.Id);
		Test.startTest();
			Book_Appointment_Extension ext = new Book_Appointment_Extension(controller);
			ext.saveRecord();
		Test.stopTest();
		System.assertNotEquals(null , eventObj.Id , 'Upsert failed');
	}
}