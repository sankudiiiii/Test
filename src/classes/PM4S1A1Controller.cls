public with sharing class PM4S1A1Controller {
    public String searchString{get; set;}
    public list<list<sObject>> resultList{get; set;}
    public PM4S1A1Controller() {
    	list<list<sObject>> resultList = new list<list<sObject>>();
    	for(Integer i = 0 ; i < 4 ; i++)
    		resultList.add(new list<sObject>());
    }
    public PM4S1A1Controller(ApexPages.StandardController controller) {
    	list<list<sObject>> resultList = new list<list<sObject>>();
    	for(Integer i = 0 ; i < 4 ; i++)
    		resultList.add(new list<sObject>());
    }
    public PageReference search() {
    	if(searchString.deleteWhiteSpace().length() > 1) {
    		searchString += '*';
    		resultList = [FIND 		:searchString 
    					  IN 		NAME FIELDS 
    					  RETURNING Account (Name)
    					  		  , Contact (Name)
    					  		  , Opportunity (Name) 
    					  		  , Lead (Name)
    					 ];
    	}
    	return null;
    }
}