global with sharing class PM5S1Extension {
    public String searchString{get; set;}
    public list<Account> accountList{get; set;}
    public Integer accountCount{get; set;}
    public ID accountId{get; set;}
    public String start{get; set;}
    public list<Contact> contactList{get; set;}
    public list<String> alphaList = new list<String> {'All', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
    public list<String> getAlphaList() {
    	return alphaList;
    }
    public PM5S1Extension() {}
    public PM5S1Extension(ApexPages.StandardSetController controller) {
    	accountCount = 0;
    	accountList = new list<Account>();
    	contactList = new list<Contact>();
    }
    public PageReference search() {
    	if(contactList != null)
    		contactList.clear();
    	if(searchString.length() < 3) {
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Input at least 3 characters to perform search.'));
        	return null;
    	} else {
    		String str = '%' + searchString + '%';
    		accountList = [SELECT id,
    		     				  name,
    		     				  enrollment_year__c,
    		     				  (SELECT id,
    		             				  name 
    		          			   FROM   contacts
    		          			  ) 
    		  			   FROM   account 
    		 			   WHERE  name LIKE :str
    					  ];
    		accountCount = accountList.size();
    		return null;
    	}
    }
    public pagereference clear() {
    	if(accountList != null) {
    		accountList.clear();
    		accountCount = accountList.size();
    	} else
    		accountCount = 0;
    	if(contactList != null)
    		contactList.clear();
    	searchString='';
    	return null;
    }
    public pagereference getContacts() {
    	if(start == 'All')
    		start = '%';
    	start += '%';
    	contactList = [SELECT id
    						, name
    						, accountid 
    				   FROM   contact 
    				   WHERE  accountid=:accountId AND name LIKE :start
    				  ];
    	return null;
    } 
    public pagereference setContacts() {
    	contactList = [SELECT id
    						, name
    						, accountid
    				   FROM   contact 
    				   WHERE  accountid =: accountId
    				  ];
    	return null;
    } 
    @RemoteAction
    global static boolean deleteContact(id cid) {
    	Contact c = new contact();
    	if(cid != null)
    		for(contact cn : [SELECT id FROM contact])
    			if(cn.id == cid)
    				c = [SELECT accountid 
    					 FROM   contact 
    					 WHERE  id=:cid
    					];
    	c.accountid = null;
    	Database.SaveResult sr = Database.update(c,false);
    	if(sr.issuccess())
    		return true;
    	else
    		return false;
    }
    @RemoteAction
    global static list<Account> autoComplete(String str){
    	list<Account> accountAutoList = [SELECT Name FROM Account WHERE Name LIKE :str+'%'];
    	return accountAutoList;
    }
}