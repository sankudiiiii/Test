public with sharing class Demo {
    public List<String> acc{get;set;}
    public Demo(ApexPages.StandardController controller){
    	acc = new List<String>();
    	List<Account> accList = [select name from Account limit 10];
    	for(Account ac : accList)
    		acc.add(ac.Name);
    }
    @RemoteAction
    public static List<String> getList(String alpha){
    	List<String> acc = new List<String>();
    	String lk = '%'+alpha+'%';
    	List<Account> accList = [select name from Account where name like :lk limit 10];
    	for(Account ac : accList)
    		acc.add(ac.Name);
    	return acc;
    }
}