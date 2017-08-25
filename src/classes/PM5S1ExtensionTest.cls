@isTest public with sharing class PM5S1ExtensionTest {
    public static ApexPages.StandardSetController controller;
    public static PM5S1Extension pm;
    @testSetup public static void setup(){
    	controller = new ApexPages.StandardSetController(new list<account>([select id from account]));
    	pm = new PM5S1Extension();
    	pm = new PM5S1Extension(controller);
    	pm.searchString=null;
    	pm.accid=null;
    	pm.start='A';
    }
    @isTest public static void utilityTest(){
    	TestDataFactory.generateTestData();
    	setup();
		System.assertNotEquals(null,pm.start);
		Aggregateresult ag = [select count(id) from account];
		System.assertNotEquals(0,ag.get('expr0'),'Test data should be available');
    }    
    @isTest public static void PM5S1ExtensionTest(){
    	TestDataFactory.generateTestData();
    	setup();
    	System.assertNotEquals(null,pm.countacc,'Count of Accounts List should be initialized');
    	System.assertNotEquals(null,pm.acclist,'Accounts List should be initialized');
    	System.assertNotEquals(null,pm.conlist,'Contact List should be initialized');
    }
    @isTest public static void searchNegativeTest(){
    	setup();
    	pm.searchString='ab';
    	pm.search();
    	System.assert(ApexPages.hasMessages(),'Message should be get generated if search string in less than 3 in length');
    }
    @isTest public static void searchPositiveTest(){
    	TestDataFactory.generateTestData();
    	setup();
    	pm.searchString='Acc';
    	pm.search();
    	System.assertNotEquals(0,pm.countacc,'Test data for Account should be available');
    }
    @isTest public static void getAlphaListTest(){
    	setup();
    	list<String> sl = pm.getAlphaList();
    	System.assertNotEquals(0,sl.size(),'Alphabet List should be defined');
    }
    @isTest public static void clearPositiveTest(){
    	setup();
    	pm.clear();
    	System.assertEquals(0,pm.countacc);
    }
    @isTest public static void clearNegativeTest(){
    	setup();
    	pm.acclist=null;
    	pm.clear();
    	System.assertEquals(0,pm.countacc);
    }
    @isTest public static void setContactsNegativeTest(){
    	TestDataFactory.generateTestData();
    	setup();
    	Aggregateresult ag = [select count(id) from contact];
    	Integer expected = (Integer)ag.get('expr0');
    	pm.setContacts();
    	System.assertEquals(expected,pm.conlist.size(),'Test data for Contact should be available');    	
    }
    @isTest public static void setContactsPositiveTest(){
    	TestDataFactory.generateTestData();
    	setup();
    	Account acl = [select id from account limit 1]; 
    	list<contact> cnl = [select id,name,accountid from contact where accountid=:acl.id];
    	pm.accid=acl.id;
    	pm.setContacts();
    	System.assertEquals(cnl,pm.conlist,'Test data for Contact and Account should be available');    	
    }
    @isTest public static void getContactsBTest(){
    	TestDataFactory.generateTestData();
    	setup();
    	pm.start = 'B';
    	Account acl = [select id from account limit 1]; 
    	list<contact> cnl = [select id,name,accountid from contact where accountid=:acl.id and name like :pm.start+'%'];
    	pm.accid=acl.id;
    	pm.getContacts();
    	System.assertEquals(cnl,pm.conlist,'Matching condition should be fulfilled');
    }
    @isTest public static void getContactsAllTest(){
    	TestDataFactory.generateTestData();
    	setup();
    	pm.start = 'All';
    	Account acl = [select id from account limit 1]; 
    	list<contact> cnl = [select id,name,accountid from contact where accountid=:acl.id and name like '%%'];
    	pm.accid=acl.id;
    	pm.getContacts();
    	System.assertEquals(cnl,pm.conlist,'Matching condition should be fulfilled');
    }
    @isTest public static void deleteContactPositiveTest(){
    	TestDataFactory.generateTestData();
    	setup();
    	Contact c = [select id from contact limit 1];
    	boolean actual = PM5S1Extension.deleteContact(c.id);
    	Contact c1 = [select accountid from contact where id=:c.id];
    	System.assertEquals(null,c1.accountid,'Unable to update the Contact record for given ID');
    	System.assertEquals(true,actual,'Database.update threw error');
    }
    @isTest public static void deleteContactNegativeTest(){
    	TestDataFactory.generateTestData();
    	setup();
    	boolean actual = PM5S1Extension.deleteContact(null);
    	System.assertEquals(false,actual,'Contact ID should be null');
    }
    @isTest public static void deleteContactNotPresentTest(){
    	TestDataFactory.generateTestData();
    	setup();
    	id i = '0037F000005NIzB';
    	boolean actual = PM5S1Extension.deleteContact(i);
    	System.assertEquals(false,actual,'Contact with given ID available');
    }
}