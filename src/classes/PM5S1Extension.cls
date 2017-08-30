global with sharing class PM5S1Extension {
    public String searchString{get;set;}
    public list<Account> acclist{get;set;}
    public Integer countacc{get;set;}
    public ID accid{get;set;}
    public String start{get;set;}
    public list<Contact> conlist{get;set;}
    public list<String> alphaList = new list<String> {'All', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
    public list<String> getAlphaList(){
    	return alphaList;
    }
    public PM5S1Extension(){}
    public PM5S1Extension(ApexPages.StandardSetController controller){
    	countacc=0;
    	acclist=new list<account>();
    	conlist=new list<contact>();
    }
    public pagereference search(){
    	if(searchString.length()<3){
    	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Input at least 3 characters to perform search.'));
        return null;
    	}
    	else {
    	String str = '%'+searchString+'%';
    	acclist=[select id,name,enrollment_year__c,(select id,name from contacts) from account where name like :str];
    	countacc=acclist.size();
    	return null;
    	}
    }
    public pagereference clear(){
    	if(acclist!=null){
    		acclist.clear();
    		countacc=acclist.size();
    	} else
    		countacc=0;
    	if(conlist!=null){
    		conlist.clear();
    	}
    	return null;
    }
    public pagereference getContacts(){
    	if(start=='All')
    		start='%';
    	start+='%';
    	conlist=[select id,name,accountid from contact where accountid=:accid and name like :start];
    	return null;
    } 
    public pagereference setContacts(){
    	conlist=[select id,name,accountid from contact where accountid=:accid];
    	return null;
    } 
    @RemoteAction
    global static boolean deleteContact(id cid){
    	Contact c = new contact();
    	if(cid!=null){
    		for(contact cn : [select id from contact]){
    			if(cn.id==cid){
    				c = [select accountid from contact where id=:cid];
    			}
    		}
    	}
    	//System.debug(c.accountid);
    	c.accountid=null;
    	//System.debug(c.accountid);
    	Database.SaveResult sr = Database.update(c,false);
    	//System.debug(c);
    	//System.debug(sr);
    	//System.debug(sr.issuccess());
    	if(sr.issuccess())
    	return true;
    	else
    	return false;
    }
}