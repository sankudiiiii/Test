@istest
public class AccountTriggerTest {
    public static testmethod void accountTriggerInsertTest(){
        aggregateresult agg = [select count(id) from account];
        Integer beforeCount = (Integer)agg.get('expr0');
        Account acc = new Account(name='Acc');
        insert acc;
        agg = [select count(id) from account];
        Integer afterCount = (Integer)agg.get('expr0');
        System.assert(afterCount>beforeCount);
    }
    public static testmethod void accountTriggerUpdateTest(){
        Account acc = new Account(name='Acc');
        insert acc;
        String newName = 'New Acc';
        Id i = acc.Id;
        acc.Name=newName;
        update acc;
        Account acc1 = [select name from account where id =:i];
        System.assertEquals('New Acc',acc1.Name);
    }
    public static testmethod void accountTriggerDeleteTest(){
        Account acc = new Account(name='Acc');
        insert acc;
        Id i = acc.Id;
        delete acc;
        list<Account> acc1 = [select id from account where id =:i];
        System.assert(acc1.size()==0);
    }
}