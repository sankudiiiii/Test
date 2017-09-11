public with sharing class ABCContactTriggerHelper {
	public static void executable(list<Contact> contactList) {
		list<Contact> contactListtoExecute = new list<Contact>();
		for(Integer i = 0 ; i < contactList.size() ; i++) {
			if(contactList[i].Email != null){
				contactListtoExecute.add(contactList.get(i));
			}
		}
		execute(contactListtoExecute);
	}	
    public static void execute(list<Contact> contactList) {
    	Map<Id,String> emailMap = new Map<Id,String>();
    	for(Account accountInstance : [SELECT Id
    						  			  , Website 
    						  			  FROM Account 
    						  			  WHERE Website != null
    					  			  ]) {
    		emailMap.put(accountInstance.Id , accountInstance.Website);
    	}
    	for(Contact contactInstance : contactList){
   			for(Id accountId : emailMap.keySet()){
   				if(emailMap.get(accountId).endswithignorecase(contactInstance.Email.substringafterlast('@'))){
   					contactInstance.accountid = accountId;
    				break;
   				}
    		}
    	}
    }
}