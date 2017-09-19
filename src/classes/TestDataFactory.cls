@isTest
public class TestDataFactory {
    public static void generateTestData() {
    	List<Account> accountList = new List<Account>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		accountList.add(new Account(Name = String.fromCharArray(new List<Integer>{i}) + 'Account'));
    	insert accountList;
    	List<Contact> contactList = new List<Contact>();
    	for(Account accountInstance :accountList)
    		for(Integer i = 65 ; i <=75 ; i++)
    			contactList.add(new Contact(LastName = String.fromCharArray(new List<integer>{i}) + 'ContactOf' + accountInstance.Name , experience__c = i));
    	insert contactList;
    }
    public static void generateABCContactTriggerTestData() {
    	List<Account> accountList = new List<Account>();
    	accountList.add(new Account(Name = 'ESPL' , Website = 'www.eternussolutions.com'));
    	accountList.add(new Account(Name = 'SFDC' , Website = 'www.salesforce.com'));
    	for(Integer i = 0; i <= 200 ; i++){
    		accountList.add(new Account(Name = String.fromCharArray(new List<integer>{i}) + 'Account'));
    	}
    	insert accountList;
    }
    public static void generateABCContainersTestData() {
    	product2 productInstance = new product2(Name = 'pro' , isActive = true);
    	insert productInstance;
    	Account accountInstance = new Account(Name = 'acc' , BillingStreet = 'JM Road' , BillingState = 'Delhi' , email_address__c = 'a@b.c' , BillingPostalCode = '411030' , Phone='1234567');
    	insert accountInstance;
    	user userInstance = new user(LastName = 'ln' , Phone = '5684239' , Email = 'ln@user.com' , UserName = 'ln@user.com' , Alias = 'ln' , CommunityNickName = 'ln' , TimeZoneSIdKey = 'America/Los_Angeles' , LocaleSIdKey = 'en_US' , EmailEncodingKey = 'UTF-8', ProfileId = '00e7F000001TR4x' , LanguageLocaleKey = 'en_US');
    	insert userInstance;
    	Opportunity OpportunityInstance = new Opportunity(Name = 'opp' , AccountId = accountInstance.Id , OwnerId = userInstance.Id , StageName = 'qualification' , Closedate = System.today());
    	insert OpportunityInstance;
		Id pricebookId = Test.getStandardPricebookId();
		Product2 productInstance2 = new Product2(Name = 'Product X' , ProductCode = 'Pro-X' , isActive = true);
		insert productInstance2;
		PricebookEntry priceBookEntryInstance = new PricebookEntry(Pricebook2Id = pricebookId , Product2Id = productInstance2.Id , UnitPrice = 100.00 , IsActive = true);
		insert priceBookEntryInstance;
		OpportunityLineItem OpportunityLineItemInstance = new OpportunityLineItem(OpportunityId = OpportunityInstance.Id , Quantity = 5 , PricebookEntryId = priceBookEntryInstance.Id , Discount = 5 , service_fee__c = 500 , labour_hour__c = 8 , labour_rate__c = 300 , tax__c = 5 , ServiceDate = System.today());
		OpportunityLineItemInstance.Totalprice = OpportunityLineItemInstance.Quantity * priceBookEntryInstance.UnitPrice;
		insert OpportunityLineItemInstance;
    }    
    public static void generateSearchData() {
    	List<Account> accountList = new List<Account>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		accountList.add(new Account(Name = i + 'Account'));
    	insert accountList;
    	List<Contact> contactList = new List<Contact>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		contactList.add(new Contact(LastName = i + 'Contact' , experience__c = i));
    	insert contactList;
    	List<Lead> leadList = new List<Lead>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		leadList.add(new Lead(LastName = i + 'Lead' , Company = 'Test'));
    	insert leadList;
    	List<Opportunity> opportunityList = new List<Opportunity>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		opportunityList.add(new Opportunity(Name = i + 'Opportunity' , Closedate = System.today() , StageName = 'Prospecting'));
    	insert opportunityList;
    }
    public static void generateRelatedSearchData() {
    	List<Account> accountList = new List<Account>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		accountList.add(new Account(Name = String.fromCharArray(new List<Integer>{i}) + 'Account'));
    	insert accountList;
    	List<Contact> contactList = new List<Contact>();
    	List<Opportunity> opportunityList = new List<Opportunity>();
    	for(Account accountInstance : accountList)
    		for(Integer i = 65 ; i <= 70 ; i++){
    			contactList.add(new Contact(LastName = i + 'ContactOf' + accountInstance.Name , experience__c = i , AccountId = accountInstance.Id));
    			opportunityList.add(new Opportunity(Name = i + 'Opportunity' , Closedate = System.today() , StageName = 'Prospecting' , AccountId = accountInstance.Id));
    		}
    	insert contactList;
    	insert opportunityList;
    }
    public static void generateCountryCityTestData() {
    	Country__c countrySettingInsatnce = new Country__c();
    	countrySettingInsatnce.Name = 'India';
    	insert countrySettingInsatnce;
    	City__c citySettingInstance = new City__c();
    	citySettingInstance.Name = 'Kolkata';
    	citySettingInstance.Country__c = 'India';
    	insert citySettingInstance;
    }
    public static void generateStudentRegistrationTestData() {
    	Student__c studentInstance = new Student__c(Name = 'ABC');
    	insert studentInstance;
    }
    public static void generateOpportunitiesClosedTodayTestData() {
    	List<Account> accountList = new List<Account>();
    	for(Integer i = 65; i <= 75 ; i++)
    		accountList.add(new Account(Name = String.fromCharArray(new List<integer>{i}) + 'Account'));
    	insert accountList;
    	List<Contact> contactList = new List<Contact>();
    	List<Opportunity> opportunityList = new List<Opportunity>();
    	for(Account accountInstance : accountList)
    		for(Integer i = 65 ; i <= 70 ; i++){
    			contactList.add(new Contact(LastName = i + 'ContactOf' + accountInstance.Name , experience__c = i , AccountId = accountInstance.Id , level__c = 'Primary' , Email = 'abc@xyz.com'));
    			opportunityList.add(new Opportunity(Name = i + 'Opportunity' , CloseDate = System.today() , StageName = 'Closed Won' , AccountId = accountInstance.Id , Amount = 1000));
    		}
    	insert contactList;
    	insert opportunityList;
    	List<Contact> contactList1 = new List<Contact>();
    	List<Opportunity> opportunityList1 = new List<Opportunity>();
    	for(Account accountInstance : accountList)
    		for(Integer i = 65 ; i <= 70 ; i++){
    			contactList1.add(new Contact(LastName = i + 'ContactOf' + accountInstance.Name , experience__c = i , AccountId = accountInstance.Id));
    			opportunityList1.add(new Opportunity(Name = i + 'Opportunity' , CloseDate = System.today() , StageName = 'Prospecting' , AccountId = accountInstance.Id , Amount = 2000));
    		}
    	insert contactList1;
    	insert opportunityList1;
    }
    public static void generateLeadDuplicateCheckerTestData() {
    	Lead leadList = new Lead(LastName = 'Lead' , Company = 'Test' , Email = 'abc@xyz.com');
    	insert leadList;
    	List<Lead> leadList1 = new List<Lead>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		leadList1.add(new Lead(LastName = i + 'Lead' , Company = 'Test' , Email = 'abc@xyz.com'));
    	insert leadList1;
    }
    public static void generateSObjectRecordCreationTestData() {
    	List<Event> eventList = new List<Event>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		eventList.add(new event(Subject = i + 'Event' , StartDateTime = System.today() , EndDateTime = System.today() , event_processed__c = false , Object_Record__c = '{"JSON" : {"Name" : "Eternus Solutions Pune"} , "Object Name" : "Account"}'));
    	insert eventList;
    }
    public static void generateLeadManipulatorServiceTestData() {
    	Lead leadInstance = new Lead(FirstName = 'A' , LastName = 'B' , Email = 'c@d.e' , Phone = '6' , Company = 'g');
    	insert leadInstance;
    }
    public static void QueryBuilderTestData(){
    	List<Account> accountList = new List<Account>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		accountList.add(new Account(Name = 'Account' + i , Website = 'www.salesforce.com'));
    	insert accountList;
    }
}