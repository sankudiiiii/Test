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
    public static void generateABCContainersTestData(){
    	product2 p = new product2(name='pro',isActive = true);
    	insert p;
    	account a = new account(name='acc',billingstreet='JM Road',billingstate='Delhi',email_address__c='a@b.c',billingpostalcode='411030',phone='1234567');
    	insert a;
    	user u = new user(lastname='ln',phone='5684239',email='ln@user.com',Username='ln@user.com', Alias='ln', CommunityNickname='ln', TimeZoneSidKey='America/Los_Angeles', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', ProfileId='00e7F000001TR4x', LanguageLocaleKey='en_US');
    	insert u;
    	opportunity opp = new opportunity(name='opp',accountid=a.id,ownerid=u.id,stagename='qualification',closedate=System.today());
    	insert opp;
		Id pricebookId = Test.getStandardPricebookId();
		Product2 prod = new Product2(Name = 'Product X',ProductCode = 'Pro-X',isActive = true);
		insert prod;
		PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookId,Product2Id = prod.Id,UnitPrice = 100.00,IsActive = true);
		insert pbEntry;
		OpportunityLineItem oli = new OpportunityLineItem(OpportunityId = opp.Id,Quantity = 5,PricebookEntryId = pbEntry.Id,discount=5,service_fee__c=500,labour_hour__c=8,labour_rate__c=300,tax__c=5,servicedate=System.today());
		oli.totalprice=oli.quantity*pbEntry.UnitPrice;
		insert oli;
    }    
}