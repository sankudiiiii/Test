public with sharing class LineItem_Add_CustomerEmail_Handler {
    public static void executable(Map<Id,Opportunity> opportunityMap){
    	execute(opportunityMap);
    }
    public static void execute(Map<Id,Opportunity> opportunityMap){
    	List<OpportunityLineItem> opportunityLineItemList = [SELECT OpportunityId,Customer_Email__c FROM OpportunityLineItem WHERE OpportunityId IN :opportunityMap.keySet()];
    	List<Id> accountIdList = new List<Id>();
    	for(Opportunity opportunityObj : opportunityMap.values())
    		accountIdList.add(opportunityObj.AccountId);
    	List<Account> accountList = [SELECT Id,Email_Address__c,(SELECT Email FROM Contacts WHERE Level__c='Primary' AND Email != '' LIMIT 1) FROM Account WHERE Id IN :accountIdList];
    	for(OpportunityLineItem opportunityLineItemObj : opportunityLineItemList){
    		for(Opportunity opportunityObj : opportunityMap.values()){
    			if(opportunityLineItemObj.OpportunityId == opportunityObj.Id){
    				for(Account accountObj : accountList){
    					if(opportunityObj.AccountId == accountObj.Id){
    						if(accountObj.Email_Address__c != null){
    							opportunityLineItemObj.Customer_Email__c = accountObj.Email_Address__c;
    						} else {
    							Contact contactObj = accountObj.Contacts;
    							opportunityLineItemObj.Customer_Email__c = contactObj.Email;
    						}
    					}
    				}
    			}
    		}
    	}
    	update opportunityLineItemList;
    }
}