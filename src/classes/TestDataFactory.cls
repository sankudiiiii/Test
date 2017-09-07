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
    public static void generateSearchData(){
    	list<account> al = new list<account>();
    	for(Integer i = 65; i<=75 ;i++){
    		al.add(new Account(name=i+'Account'));
    	}
    	insert al;
    	list<contact> cl = new list<contact>();
    	for(Integer i = 65; i<=75 ;i++){
    		cl.add(new Contact(lastname=i+'Contact',experience__c=i));
    	}
    	insert cl;
    	list<lead> ll = new list<lead>();
    	for(Integer i = 65; i<=75 ;i++){
    		ll.add(new lead(lastname=i+'Lead',company='Test'));
    	}
    	insert ll;
    	list<opportunity> ol = new list<opportunity>();
    	for(Integer i = 65; i<=75 ;i++){
    		ol.add(new opportunity(name=i+'Opportunity',closedate=System.today(),stagename='Prospecting'));
    	}
    	insert ol;
    }
    public static void generateRelatedSearchData(){
    	list<account> al = new list<account>();
    	for(Integer i = 65; i<=75 ;i++){
    		al.add(new Account(name=String.fromCharArray(new List<integer>{i})+'Account'));
    	}
    	insert al;
    	list<contact> cl = new list<contact>();
    	list<opportunity> ol = new list<opportunity>();
    	for(account a :al){
    		for(Integer i = 65; i<=70 ;i++){
    			cl.add(new Contact(lastname=i+'ContactOf'+a.name,experience__c=i,accountid=a.id));
    			ol.add(new opportunity(name=i+'Opportunity',closedate=System.today(),stagename='Prospecting',accountid=a.id));
    		}
    	}
    	insert cl;
    	insert ol;
    }
    public static void generateCountryCityTestData(){
    	Country__c co = new Country__c();
    	co.name='India';
    	insert co;
    	City__c ct = new City__c();
    	ct.name='Kolkata';
    	ct.Country__c='India';
    	insert ct;
    }
    public static void generateStudentRegistrationTestData(){
    	Student__c s = new Student__c(name='ABC');
    	insert s;
    }
    public static void generateOpportunitiesClosedTodayTestData(){
    	list<account> al = new list<account>();
    	for(Integer i = 65; i<=75 ;i++){
    		al.add(new Account(name=String.fromCharArray(new List<integer>{i})+'Account'));
    	}
    	insert al;
    	list<contact> cl = new list<contact>();
    	list<opportunity> ol = new list<opportunity>();
    	for(account a :al){
    		for(Integer i = 65; i<=70 ;i++){
    			cl.add(new Contact(lastname=i+'ContactOf'+a.name,experience__c=i,accountid=a.id,level__c='Primary',email='abc@xyz.com'));
    			ol.add(new opportunity(name=i+'Opportunity',closedate=System.today(),stagename='Closed Won',accountid=a.id,amount=1000));
    		}
    	}
    	insert cl;
    	insert ol;
    	list<contact> cl1 = new list<contact>();
    	list<opportunity> ol1 = new list<opportunity>();
    	for(account a :al){
    		for(Integer i = 65; i<=70 ;i++){
    			cl1.add(new Contact(lastname=i+'ContactOf'+a.name,experience__c=i,accountid=a.id));
    			ol1.add(new opportunity(name=i+'Opportunity',closedate=System.today(),stagename='Prospecting',accountid=a.id,amount=2000));
    		}
    	}
    	insert cl1;
    	insert ol1;
    }
    public static void generateLeadDuplicateCheckerTestData(){
    	lead ll = new lead(lastname='Lead',company='Test',email='abc@xyz.com');
    	insert ll;
    	list<lead> ll1 = new list<lead>();
    	for(Integer i = 65; i<=75 ;i++){
    		ll1.add(new lead(lastname=i+'Lead',company='Test',email='abc@xyz.com'));
    	}
    	insert ll1;
    }
    public static void generateSObjectRecordCreationTestData(){
    	list<event> el = new list<event>();
    	for(Integer i = 65; i<=75 ;i++){
    		el.add(new event(subject=i+'Event',StartDateTime=System.today(),EndDateTime=System.today(),event_processed__c=false,Object_Record__c='{"JSON":{"Name" : "Eternus Solutions Pune"},"Object Name" : "Account"}'));
    	}
    	insert el;
    }
    public static void generateLeadManipulatorServiceTestData(){
    	lead l = new lead(firstname='A',lastname='B',email='c@d.e',phone='6',company='g');
    	insert l;
    }
}