@istest
public class EFTAddressVerificationTriggerTest {
    public static testmethod void EFTAddressVerificationAfterInsertTest(){
        list<sObject> slist = new list<sObject>();
        Account acc = new account(name='acc');
        insert acc;
        System.debug(acc);
        Contact con = new contact(lastname='con',experience__c=10);
        insert con;
        System.debug(con);
        SalesHeader__c sh = new SalesHeader__c(Status__c='Open',Bill_to_Customer_Account__c=acc.id,Bill_to_Customer_Contact__c=con.id);
        insert sh;
        System.debug(sh);
        Group g = new Group(name='AVS',Type='Queue');
        insert g;
        System.debug(g);
        aggregateresult agg = [select count(id) from case];
        Integer beforeCount = (Integer)agg.get('expr0');
        EFT_Transaction_Status__c eft = new EFT_Transaction_Status__c(name='eft',method_name__c='Credit Card Address Verify',transaction_status__c='Declined',SalesHeader__c=sh.id);
        insert eft;
        case c = [select id from case];
        System.debug(c.id);
        agg = [select count(id) from case];
        Integer afterCount = (Integer)agg.get('expr0');
        System.assert(afterCount>beforeCount);
    }
}