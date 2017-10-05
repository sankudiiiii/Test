@isTest
public class GoelBikers_TestDataFactory {
    public static void generateGoelBikersTestData(){
    	Pricebook2 standardPricebook = new Pricebook2(Id = Test.getStandardPricebookId() , IsActive = true);
		update standardPricebook;
		Account accountObj = new Account(Name = 'AccountA' , Email_Address__c = 'a@b.c');
		insert accountObj;
		Contact contactObj = new Contact(LastName = 'ContactA' , Experience__c = 30 , AccountId = accountObj.Id , Level__c = 'Primary' , Email = 'c@b.a');
		insert contactObj;
		Opportunity opportunityObj = new Opportunity(Name = 'OpportunityA' , AccountId = accountObj.Id , StageName = 'Prospecting' , CloseDate = System.today());
		insert opportunityObj;
    	Product2 wheel = new Product2(Name='wheel' , Stock__c = 10 , Family = 'Wheel');
		insert wheel;
		Product2 engine = new Product2(Name='engine' , Stock__c = 10 , Family = 'Engine');
		insert engine;
		Product2 exhaust = new Product2(Name='exhaust' , Stock__c = 10 , Family = 'Exhaust');
		insert exhaust;
		Product2 mirror = new Product2(Name='mirror' , Stock__c = 10 , Family = 'Mirror');
		insert mirror;
		Product2 head = new Product2(Name='head' , Stock__c = 10 , Family = 'Head Light');
		insert head;
		Product2 turn = new Product2(Name='turn' , Stock__c = 10 , Family = 'Turn Signal');
		insert turn;
		Product2 tail = new Product2(Name='tail' , Stock__c = 10 , Family = 'Rear Light');
		insert tail;
		Product2 logo = new Product2(Name='logo' , Stock__c = 10 , Family = 'LogoOrSticker');
		insert logo;
		Product2 gauge = new Product2(Name='gauge' , Stock__c = 10 , Family = 'Gauge');
		insert gauge;
		Product2 bike = new Product2(Name='bike' , Wheel__c = wheel.Id , Turn_Signal__c = turn.Id , Tail_Light__c = tail.Id , Mirror__c = mirror.Id , LogoOrSticker__c = logo.Id , Head_Light__c = head.Id , Gauge__c = gauge.Id , Exhaust__c = exhaust.Id , Engine__c = engine.Id , Deal__c = opportunityObj.Id);
		insert bike;
		System.debug(bike);
    }
}