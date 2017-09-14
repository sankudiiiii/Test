@isTest
private class ABCContainersTest {
	public static testmethod void ABCContainersInvoicesExtensionTest() {
		TestDataFactory.generateABCContainersTestData();
		OpportunityLineItem opportunityLineItemInstance = [
			SELECT id 
			  FROM OpportunityLineItem
		];
		ApexPages.StandardController controller = new ApexPages.StandardController(opportunityLineItemInstance);
		ABCContainersInvoicesExtension extensionInstance = new ABCContainersInvoicesExtension(controller);
		System.assertNotEquals(null , extensionInstance.opportunityLineItemInstance , 'Constructor not initialized');
		System.assertNotEquals(null , extensionInstance.controller , 'Constructor not initialized');
		System.assertNotEquals(null , extensionInstance.opportunityLineItemList , 'Constructor not initialized');
		System.assertEquals(0 , extensionInstance.labour , 'Constructor not initialized');
		System.assertEquals(0 , extensionInstance.taxamount , 'Constructor not initialized');
		System.assertEquals(0 , extensionInstance.discount , 'Constructor not initialized');
		System.assertEquals(0 , extensionInstance.total , 'Constructor not initialized');
		System.assertEquals(0 , extensionInstance.lineItemCost , 'Constructor not initialized');
	}
	public static testmethod void getLineitemsSizeGreaterThanZeroTest() {
		TestDataFactory.generateABCContainersTestData();
		OpportunityLineItem opportunityLineItemInstance = [
			SELECT id 
			  FROM OpportunityLineItem
		];
		ApexPages.StandardController controller = new ApexPages.StandardController(opportunityLineItemInstance);
		ABCContainersInvoicesExtension extensionInstance = new ABCContainersInvoicesExtension(controller);
		List<OpportunityLineItem> opportunityLineItemList = [
			SELECT id 
			  FROM OpportunityLineItem
		];
		extensionInstance.opportunityLineItemList = opportunityLineItemList;
		System.assertEquals(opportunityLineItemList , extensionInstance.getopportunityLineItemList() , 'Line item not initialized');
	}
	public static testmethod void getLineitemsSizeZeroTest() {
		TestDataFactory.generateABCContainersTestData();
		OpportunityLineItem opportunityLineItemInstance = [
			SELECT id 
			  FROM OpportunityLineItem
		];
		ApexPages.StandardController controller = new ApexPages.StandardController(opportunityLineItemInstance);
		ABCContainersInvoicesExtension extensionInstance = new ABCContainersInvoicesExtension(controller);
		List<OpportunityLineItem> opportunityLineItemList = [
			SELECT UnitPrice
				 , TotalPrice
				 , Quantity
				 , Product2Id
				 , Opportunityid
				 , Name
				 , ListPrice 
			 FROM OpportunityLineItem
		];
		System.assertEquals(opportunityLineItemList , extensionInstance.getopportunityLineItemList() , 'Line item not initialized');
	}
	public static testmethod void getLiPositiveTest() {
		TestDataFactory.generateABCContainersTestData();
		OpportunityLineItem opportunityLineItemInstance = [
			SELECT Name
				 , UnitPrice
				 , ServiceDate
				 , Quantity
				 , OpportunityId
				 , discount
				 , service_fee__c
				 , labour_hour__c
				 , labour_rate__c
				 , tax__c 
			 FROM OpportunityLineItem
		];
		ApexPages.StandardController controller = new ApexPages.StandardController(opportunityLineItemInstance);
		ABCContainersInvoicesExtension extensionInstance = new ABCContainersInvoicesExtension(controller);
		System.assertEquals(opportunityLineItemInstance , extensionInstance.getopportunityLineItemInstance() , 'opportunityLineItem not defined by the controller');
		System.assertNotEquals(null , extensionInstance.opportunityInstance , 'opportunityLineItem not defined by the controller');
		System.assertNotEquals(null , extensionInstance.accountInstance , 'opportunityLineItem not defined by the controller');
		System.assertNotEquals(null , extensionInstance.userInstance , 'opportunityLineItem not defined by the controller');
		Decimal labour = opportunityLineItemInstance.labour_hour__c * opportunityLineItemInstance.labour_rate__c;
    	Decimal licost = Math.round(opportunityLineItemInstance.unitprice * opportunityLineItemInstance.quantity / 10) * 10.00;
    	Decimal discount = Math.round((opportunityLineItemInstance.service_fee__c + labour + licost) * opportunityLineItemInstance.discount / 100 / 10) * 10.00;
    	Decimal taxamount = Math.round((opportunityLineItemInstance.service_fee__c + labour + licost - discount) * opportunityLineItemInstance.tax__c / 100 / 10) * 10.00;
    	Decimal total = opportunityLineItemInstance.service_fee__c + labour + licost - discount + taxamount;
		System.assertEquals( labour , extensionInstance.labour , 'Line Item not initialized');
		System.assertEquals( taxamount , extensionInstance.taxamount , 'Line Item not initialized');
		System.assertEquals( discount , extensionInstance.discount , 'Line Item not initialized');
		System.assertEquals( total , extensionInstance.total , 'Line Item not initialized');
		System.assertEquals( licost , extensionInstance.lineItemCost , 'Line Item not initialized');
	}
	public static testmethod void getLiNegativeTest() {
		TestDataFactory.generateABCContainersTestData();
		OpportunityLineItem opportunityLineItemInstance = [
			SELECT Name
				 , UnitPrice
				 , ServiceDate
				 , Quantity
				 , OpportunityId
				 , discount
				 , service_fee__c
				 , labour_hour__c
				 , labour_rate__c
				 , tax__c 
			 FROM OpportunityLineItem
		];
		ApexPages.StandardController controller = new ApexPages.StandardController(opportunityLineItemInstance);
		ABCContainersInvoicesExtension extensionInstance = new ABCContainersInvoicesExtension(controller);
		System.assertEquals(opportunityLineItemInstance , extensionInstance.getopportunityLineItemInstance() , 'Controller record mismatch');
	}
	public static testmethod void getCountTest() {
		TestDataFactory.generateABCContainersTestData();
		OpportunityLineItem opportunityLineItemInstance = [
			SELECT Name
				 , UnitPrice
				 , ServiceDate
				 , Quantity
				 , OpportunityId
				 , discount
				 , service_fee__c
				 , labour_hour__c
				 , labour_rate__c
				 , tax__c 
			 FROM OpportunityLineItem
		];
		ApexPages.StandardController controller = new ApexPages.StandardController(opportunityLineItemInstance);
		ABCContainersInvoicesExtension extensionInstance = new ABCContainersInvoicesExtension(controller);
		System.assertEquals(1 , extensionInstance.getCount() , 'Count not initialized');
	}
	public static testmethod void getDtTest() {
		TestDataFactory.generateABCContainersTestData();
		OpportunityLineItem opportunityLineItemInstance = [
			SELECT Name
				 , UnitPrice
				 , ServiceDate
				 , Quantity
				 , OpportunityId
				 , discount
				 , service_fee__c
				 , labour_hour__c
				 , labour_rate__c
				 , tax__c 
			  FROM OpportunityLineItem
		];
		ApexPages.StandardController controller = new ApexPages.StandardController(opportunityLineItemInstance);
		ABCContainersInvoicesExtension extensionInstance = new ABCContainersInvoicesExtension(controller);
		String dt = opportunityLineItemInstance.servicedate.day().format() + '/' + opportunityLineItemInstance.servicedate.month().format() + '/' + opportunityLineItemInstance.servicedate.year().format().remove(',');
    	System.assertEquals(dt , extensionInstance.getDt() , 'No date found');
	}
}