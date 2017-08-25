@isTest
public class TestDataFactory {
    public static void generateTestData(){
    	list<account> al = new list<account>();
    	for(Integer i = 65; i<=75 ;i++){
    		al.add(new Account(name=String.fromCharArray(new List<integer>{i})+'Account'));
    	}
    	insert al;
    	list<contact> cl = new list<contact>();
    	for(account a :al){
    		for(Integer i = 65; i<=75 ;i++){
    			cl.add(new Contact(lastname=String.fromCharArray(new List<integer>{i})+'ContactOf'+a.name,experience__c=i));
    		}
    	}
    	insert cl;
    }
    public static void generateABCContactTriggerTestData(){
    	list<account> acclist = new list<account>();
    	acclist.add(new account(name='ESPL',website='www.eternussolutions.com'));
    	acclist.add(new account(name='SFDC',website='www.salesforce.com'));
    	insert acclist;
    }
}