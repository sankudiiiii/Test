@isTest
public class QueryBuilder_TestDataFactory {
    public static void QueryBuilderTestData(){
    	List<Account> accountList = new List<Account>();
    	for(Integer i = 65 ; i <= 75 ; i++)
    		accountList.add(new Account(Name = 'Account' + i , Website = 'www.salesforce.com'));
    	insert accountList;
    }
}