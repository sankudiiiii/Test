public class SalesHeaderTriggerHelper {
    public static void generateCase(list<SalesHeader__c> shlist){
        list<case> caselist = new list<case>();
        group g = [select Id from Group where Name = 'Unable to Cross Ship Queue' and Type = 'Queue' limit 1];
        for(SalesHeader__c sh : shlist){
            EFT_Transaction_Status__c eft = [select Transaction_Status__c,Transaction_Date__c from EFT_Transaction_Status__c where 	SalesHeader__r.id =: sh.id order by createddate desc limit 1];
            Account acc = [select name from account where id=:sh.Bill_to_Customer_Account__c];
            String cType='Unable to Cross Ship';
            caselist.add(new case(accountid=sh.Bill_to_Customer_Account__c,
                                  contactId=sh.Bill_to_Customer_Contact__c,
                                 recordtypeid=Schema.SObjectType.Case.getRecordTypeInfosByName().get('Assignment').getRecordTypeId(),
                                 origin='Internal',
                                 ownerid=g.id,
                                 reason='Unable to Cross Ship',
                                 priority='Medium',
                                 status='New',
                                 Type=cType,
                                 subject=acc.name+' '+cType,
                                 Open_Sales_Order__c=sh.id,
                                 Transaction_Status__c=eft.Transaction_Status__c,
                                 Sales_Order_Number__c=sh.Name,
                                 Order_Date__c=eft.Transaction_Date__c));
        }
        insert caselist;
        System.debug(caselist);
    }
}