@isTest
private class PM4S1A1ControllerTest {
	@isTest public static void PM4S1A1ControllerTest(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		System.assertNotEquals(null,pm.acclist,'Constructor not initialized');
		System.assertNotEquals(null,pm.conlist,'Constructor not initialized');
		System.assertNotEquals(null,pm.opplist,'Constructor not initialized');
		System.assertNotEquals(null,pm.llist,'Constructor not initialized');
	}
	@isTest public static void searchAccountPositive(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='Account';
		pm.search();
		System.assertEquals(true,pm.isacc,'Records with name containing given string not available');
	}
	@isTest public static void searchAccountNegative(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='Lead';
		pm.search();
		System.assertEquals(false,pm.isacc,'Records with name containing given string available');
	}
	@isTest public static void searchContactPositive(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='Contact';
		pm.search();
		System.assertEquals(true,pm.iscon,'Records with name containing given string not available');
	}
	@isTest public static void searchContactNegative(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='Lead';
		pm.search();
		System.assertEquals(false,pm.iscon,'Records with name containing given string available');
	}
	@isTest public static void searchOpportunityPositive(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='Opportunity';
		pm.search();
		System.assertEquals(true,pm.isopp,'Records with name containing given string not available');
	}
	@isTest public static void searchOpportunityNegative(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='Lead';
		pm.search();
		System.assertEquals(false,pm.isopp,'Records with name containing given string available');
	}
	@isTest public static void searchLeadPositive(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='Lead';
		pm.search();
		System.assertEquals(true,pm.isl,'Records with name containing given string not available');
	}
	@isTest public static void searchLeadNegative(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='Account';
		pm.search();
		System.assertEquals(false,pm.isl,'Records with name containing given string available');
	}
	@isTest public static void searchAllPositive(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='1';
		pm.search();
		System.assertEquals(true,pm.isacc,'Records with name containing given string not available');
		System.assertEquals(true,pm.iscon,'Records with name containing given string not available');
		System.assertEquals(true,pm.isopp,'Records with name containing given string not available');
		System.assertEquals(true,pm.isl,'Records with name containing given string not available');
	}
	@isTest public static void searchAllNegative(){
		TestDataFactory.generateSearchData();
		PM4S1A1Controller pm = new PM4S1A1Controller();
		pm.searchString='abcdefg';
		pm.search();
		System.assertEquals(false,pm.isacc,'Records with name containing given string available');
		System.assertEquals(false,pm.iscon,'Records with name containing given string available');
		System.assertEquals(false,pm.isopp,'Records with name containing given string available');
		System.assertEquals(false,pm.isl,'Records with name containing given string available');
	}
}