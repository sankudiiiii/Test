@isTest
public class CloneAccountTriggerTest {
    public static testmethod void CloneAccountTriggerTest(){
        aggregateresult agg = [select count(id) from account];
        Integer beforeCount = (Integer)agg.get('expr0');
        Account acc = new Account(name='Acc');
        insert acc;
        agg = [select count(id) from account];
        Integer afterCount = (Integer)agg.get('expr0');
        System.assertEquals(beforeCount+2, afterCount);
    }
}