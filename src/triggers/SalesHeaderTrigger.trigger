trigger SalesHeaderTrigger on SalesHeader__c (after insert, after update) {
    list<SalesHeader__c> shlist = new list<SalesHeader__c>();
    for(SalesHeader__c sh : trigger.new){
        if(sh.Status__c=='Open' && sh.Pick_Status__c=='Open' && sh.Total_Amount__c>300){
            if(sh.Bill_to_City__c!=sh.Ship_to_City__c || sh.Bill_to_Street__c!=sh.Ship_to_Street__c || sh.Bill_to_State__c!=sh.Ship_to_State__c || sh.Bill_to_Postal_Code__c!=sh.Ship_to_Postal_Code__c){
            	shlist.add(sh);
            }
        }
    }
    SalesHeaderTriggerHelper.generateCase(shlist);
}