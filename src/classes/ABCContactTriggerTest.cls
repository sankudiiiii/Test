@isTest
private class ABCContactTriggerTest {
	@isTest public static void ABCContactTriggerPositiveTest() {
		TestDataFactory.generateABCContactTriggerTestData();
		Account accountInstance = [
			SELECT Id 
			  FROM Account 
			 WHERE Website = 'www.eternussolutions.com'
		];
		Contact contactInstance = new Contact(Lastname = 'xyz' , experience__c = 10 , Email = 'xyz@eternussolutions.com');
		insert contactInstance;
		contactInstance = [
			SELECT AccountId 
			  FROM Contact
		];
		System.assertEquals(accountInstance.Id , contactInstance.AccountId , 'No matching domain');
	}
	@isTest public static void ABCContactTriggerNegativeTest() {
		TestDataFactory.generateABCContactTriggerTestData();
		Contact contactInstance = new Contact(Lastname = 'xyz' , experience__c = 10 , Email = 'xyz@eternus.com');
		insert contactInstance;
		contactInstance = [
			SELECT AccountId 
			  FROM Contact
		];
		System.assertEquals(null , contactInstance.AccountId , 'Matching domain found');
	}
	@isTest public static void ABCContactTriggerNullTest() {
		TestDataFactory.generateABCContactTriggerTestData();
		Contact contactInstance = new Contact(Lastname = 'xyz' , experience__c = 10);
		insert contactInstance;
		contactInstance = [
			SELECT AccountId 
			  FROM Contact
		];
		System.assertEquals(null , contactInstance.AccountId , 'Email found');
	}
	@isTest public static void ABCContactTriggerBulkPositiveTest() {
		TestDataFactory.generateABCContactTriggerTestData();
		Account accountInstance = [
			SELECT Id 
			  FROM Account 
			 WHERE website = 'www.eternussolutions.com'
		];
		List<Contact> contactList = new List<Contact>();
		contactList.add(new Contact(Lastname = 'xyz' , experience__c = 10 , Email = 'xyz@eternussolutions.com'));
		contactList.add(new Contact(Lastname = 'pqr' , experience__c = 0 , Email = 'xyz@eternussolutions.com'));
		contactList.add(new Contact(Lastname = 'abc' , experience__c = 40 , Email = 'xyz@eternussolutions.com'));
		insert contactList;
		List<Contact> contactList1 = new List<Contact>();
    	for(Integer i = 0 ; i <= 202 ; i++)
    		contactList1.add(new Contact(Lastname = 'xyz' , experience__c = 10 , Email = 'xyz@eternussolutions.com'));
    	insert contactList1;
		List<Contact> resultList = [
			SELECT AccountId 
			  FROM Contact
		];
		for(Contact contactInstance : resultList)
			System.assertEquals(accountInstance.Id , contactInstance.AccountId , 'No matching domain');
	}
	@isTest public static void ABCContactTriggerBulkNegativeTest() {
		TestDataFactory.generateABCContactTriggerTestData();
		List<Contact> contactList = new List<Contact>();
		contactList.add(new Contact(Lastname = 'xyz' , experience__c = 10));
		contactList.add(new Contact(Lastname = 'pqr' , experience__c = 0));
		contactList.add(new Contact(Lastname = 'abc' , experience__c = 40));
		insert contactList;
		List<Contact> contactList1 = new List<Contact>();
    	for(Integer i = 0 ; i <= 202 ; i++)
    		contactList1.add(new Contact(Lastname = 'xyz' , experience__c = 10));
    	insert contactList1;
		List<Contact> resultList = [
			SELECT AccountId 
			  FROM Contact
		];
		for(Contact contactInstance : resultList)
			System.assertEquals(null , contactInstance.AccountId , 'Matching domain found.');
	}
}