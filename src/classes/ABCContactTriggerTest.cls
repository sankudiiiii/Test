@isTest
private class ABCContactTriggerTest {
	@isTest public static void ABCContactTriggerPositiveTest(){
		TestDataFactory.generateABCContactTriggerTestData();
		Account a = [select id from account where website='www.eternussolutions.com'];
		contact c = new contact(lastname='xyz',experience__c=10,email='xyz@eternussolutions.com');
		insert c;
		c = [select accountid from contact];
		System.assertEquals(a.id,c.accountid,'No matching domain');
	}
	@isTest public static void ABCContactTriggerNegativeTest(){
		TestDataFactory.generateABCContactTriggerTestData();
		contact c = new contact(lastname='xyz',experience__c=10,email='xyz@eternus.com');
		insert c;
		c = [select accountid from contact];
		System.assertEquals(null,c.accountid,'Matching domain found');
	}
	@isTest public static void ABCContactTriggerNullTest(){
		TestDataFactory.generateABCContactTriggerTestData();
		contact c = new contact(lastname='xyz',experience__c=10);
		insert c;
		c = [select accountid from contact];
		System.assertEquals(null,c.accountid,'Email found');
	}
	@isTest public static void ABCContactTriggerBulkPositiveTest(){
		TestDataFactory.generateABCContactTriggerTestData();
		Account a = [select id from account where website='www.eternussolutions.com'];
		list<contact> cl = new list<contact>();
		cl.add(new contact(lastname='xyz',experience__c=10,email='xyz@eternussolutions.com'));
		cl.add(new contact(lastname='pqr',experience__c=0,email='xyz@eternussolutions.com'));
		cl.add(new contact(lastname='abc',experience__c=40,email='xyz@eternussolutions.com'));
		insert cl;
		cl = [select accountid from contact];
		for(contact c : cl){
			System.assertEquals(a.id,c.accountid,'No matching domain');
		}
	}
}