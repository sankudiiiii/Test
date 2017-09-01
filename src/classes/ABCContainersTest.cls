@isTest
private class ABCContainersTest {
	public static testmethod void ABCContainersInvoicesExtensionTest(){
		TestDataFactory.generateABCContainersTestData();
		Opportunitylineitem oli = [select id from Opportunitylineitem];
		ApexPages.StandardController sc = new ApexPages.StandardController(oli);
		ABCContainersInvoicesExtension ae = new ABCContainersInvoicesExtension(sc);
		System.assertNotEquals(null,ae.li,'Constructor not initialized');
		System.assertNotEquals(null,ae.controller,'Constructor not initialized');
		System.assertNotEquals(null,ae.lineitems,'Constructor not initialized');
		System.assertEquals(0,ae.labour,'Constructor not initialized');
		System.assertEquals(0,ae.taxamount,'Constructor not initialized');
		System.assertEquals(0,ae.discount,'Constructor not initialized');
		System.assertEquals(0,ae.total,'Constructor not initialized');
		System.assertEquals(0,ae.licost,'Constructor not initialized');
	}
	public static testmethod void getLineitemsSizeGreaterThanZeroTest(){
		TestDataFactory.generateABCContainersTestData();
		Opportunitylineitem oli = [select id from Opportunitylineitem];
		ApexPages.StandardController sc = new ApexPages.StandardController(oli);
		ABCContainersInvoicesExtension ae = new ABCContainersInvoicesExtension(sc);
		list<opportunitylineitem> li = [select id from opportunitylineitem];
		ae.lineitems = li;
		System.assertEquals(li,ae.getLineitems(),'Line item not initialized');
	}
	public static testmethod void getLineitemsSizeZeroTest(){
		TestDataFactory.generateABCContainersTestData();
		Opportunitylineitem oli = [select id from Opportunitylineitem];
		ApexPages.StandardController sc = new ApexPages.StandardController(oli);
		ABCContainersInvoicesExtension ae = new ABCContainersInvoicesExtension(sc);
		list<opportunitylineitem> li = [select UnitPrice, TotalPrice, Quantity, Product2Id, Opportunityid, Name, ListPrice from opportunitylineitem];
		System.assertEquals(li,ae.getLineitems(),'Line item not initialized');
	}
	public static testmethod void getLiPositiveTest(){
		TestDataFactory.generateABCContainersTestData();
		Opportunitylineitem oli = [select name, UnitPrice, ServiceDate, Quantity,  OpportunityId,discount, service_fee__c,labour_hour__c,labour_rate__c,tax__c from Opportunitylineitem];
		ApexPages.StandardController sc = new ApexPages.StandardController(oli);
		ABCContainersInvoicesExtension ae = new ABCContainersInvoicesExtension(sc);
		System.assertEquals(oli,ae.getLi(),'Opportunitylineitem not defined by the controller');
		System.assertNotEquals(null,ae.opp,'Opportunitylineitem not defined by the controller');
		System.assertNotEquals(null,ae.acc,'Opportunitylineitem not defined by the controller');
		System.assertNotEquals(null,ae.usr,'Opportunitylineitem not defined by the controller');
		Decimal labour=oli.labour_hour__c*oli.labour_rate__c;
    	Decimal licost=Math.round(oli.unitprice*oli.quantity/10)*10.00;
    	Decimal discount = Math.round((oli.service_fee__c+labour+licost)*oli.discount/100/10)*10.00;
    	Decimal taxamount = Math.round((oli.service_fee__c+labour+licost-discount)*oli.tax__c/100/10)*10.00;
    	Decimal total = oli.service_fee__c+labour+licost-discount+taxamount;
		System.assertEquals(labour,ae.labour,'Line Item not initialized');
		System.assertEquals(taxamount,ae.taxamount,'Line Item not initialized');
		System.assertEquals(discount,ae.discount,'Line Item not initialized');
		System.assertEquals(total,ae.total,'Line Item not initialized');
		System.assertEquals(licost,ae.licost,'Line Item not initialized');
	}
	public static testmethod void getLiNegativeTest(){
		TestDataFactory.generateABCContainersTestData();
		Opportunitylineitem oli = [select name, UnitPrice, ServiceDate, Quantity,  OpportunityId,discount, service_fee__c,labour_hour__c,labour_rate__c,tax__c from Opportunitylineitem];
		ApexPages.StandardController sc = new ApexPages.StandardController(oli);
		ABCContainersInvoicesExtension ae = new ABCContainersInvoicesExtension(sc);
		System.assertEquals(oli,ae.getLi(),'Controller record mismatch');
	}
	public static testmethod void getCountTest(){
		TestDataFactory.generateABCContainersTestData();
		Opportunitylineitem oli = [select name, UnitPrice, ServiceDate, Quantity,  OpportunityId,discount, service_fee__c,labour_hour__c,labour_rate__c,tax__c from Opportunitylineitem];
		ApexPages.StandardController sc = new ApexPages.StandardController(oli);
		ABCContainersInvoicesExtension ae = new ABCContainersInvoicesExtension(sc);
		System.assertEquals(1,ae.getCount(),'Count not initialized');
	}
	public static testmethod void getDtTest(){
		TestDataFactory.generateABCContainersTestData();
		Opportunitylineitem oli = [select name, UnitPrice, ServiceDate, Quantity,  OpportunityId,discount, service_fee__c,labour_hour__c,labour_rate__c,tax__c from Opportunitylineitem];
		ApexPages.StandardController sc = new ApexPages.StandardController(oli);
		ABCContainersInvoicesExtension ae = new ABCContainersInvoicesExtension(sc);
		String dt = oli.servicedate.day().format()+'/'+oli.servicedate.month().format()+'/'+oli.servicedate.year().format().remove(',');
    	System.assertEquals(dt,ae.getDt(),'No date found');
	}
}