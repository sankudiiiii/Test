@isTest
private class PM4S1A2ExtensionTest {
	@isTest public static void PM4S1A2ExtensionAllPositiveTest(){
		TestDataFactory.generateRelatedSearchData();
		list<account> acclist = [select id from account];
		ApexPages.StandardSetController controller = new ApexPages.StandardSetController(acclist);
		PM4S1A2Extension pm = new PM4S1A2Extension(controller);
		contact con = [select accountid from contact where accountid!=null limit 1];
		account acc = [select id from account where id =:con.accountid];
		pm.i = acc.id;
		pm.fetchContacts();
		System.assertNotEquals(0,pm.conlist.size(),'No contact for given account');
		System.assertNotEquals(0,pm.opplist.size(),'No opportunity for given account');
	}
	@isTest public static void PM4S1A2ExtensionAllNegativeTest(){
		TestDataFactory.generateRelatedSearchData();
		list<account> acclist = [select id from account];
		ApexPages.StandardSetController controller = new ApexPages.StandardSetController(acclist);
		PM4S1A2Extension pm = new PM4S1A2Extension(controller);
		list<contact> conlist = [select accountid from contact where accountid!=null];
		list<id> accl = new list<id>();
		for(contact con : conlist){
			accl.add(con.accountid);
		}
		account acc = [select id from account where id not in :accl limit 1];
		pm.i = acc.id;
		pm.fetchContacts();
		System.assertEquals(0,pm.conlist.size(),'No contact for given account');
		System.assertEquals(0,pm.opplist.size(),'No opportunity for given account');
	}
}