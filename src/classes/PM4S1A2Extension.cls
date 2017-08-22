public with sharing class PM4S1A2Extension {
    public list<contact> conlist{get;set;}
    public list<opportunity> opplist{get;set;}
    public id i{get;set;}
    public PM4S1A2Extension(ApexPages.StandardSetController controller){
    }
    public pagereference fetchContacts(){
    	conlist = [select name from contact where accountId =: i];
    	opplist = [select name from opportunity where accountId =: i];
    	return null;
    }
}