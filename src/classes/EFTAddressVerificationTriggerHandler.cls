public class EFTAddressVerificationTriggerHandler {
    public static void EFTAddressVerificationAfterInsertHandler(list<EFT_Transaction_Status__c> eftlist){
        list<case> caselist = new list<case>();
        group g = [select Id from Group where Name = 'AVS' and Type = 'Queue' limit 1];
        for(EFT_Transaction_Status__c eft : eftlist){
            SalesHeader__c sh = [select Bill_to_Customer_Account__c,Bill_to_Customer_Contact__c,Bill_to_Customer_Account__r.name,name from SalesHeader__c where id =: eft.SalesHeader__c];
            String cType='Address Did Not Verify';
            caselist.add(new case(accountid=sh.Bill_to_Customer_Account__c,
                                  contactId=sh.Bill_to_Customer_Contact__c,
                                 recordtypeid=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Assignment').getRecordTypeId(),
                                 origin='Internal',
                                 ownerid=g.id,
                                 reason='Address Did Not Verify	',
                                 priority='high',
                                 status='New',
                                 Type=cType,
                                 subject=sh.Bill_to_Customer_Account__r.name+' '+cType,
                                 Open_Sales_Order__c=eft.SalesHeader__c,
                                 Transaction_Status__c=eft.Transaction_Status__c,
                                 Sales_Order_Number__c=sh.Name,
                                 Order_Date__c=eft.Transaction_Date__c));
        }
        insert caselist;
        System.debug(caselist);
    }
}