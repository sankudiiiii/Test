public with sharing class ABCContactTriggerHelper {
	public static void executable(list<contact> conlist){
		list<contact> con = new list<contact>();
		for(Integer i = 0 ; i<conlist.size();i++){
			if(conlist[i].email!=null){
				con.add(conlist.get(i));
			}
		}
		execute(con);
	}	
    public static void execute(list<contact> conlist){
    	Map<id,String> emailMap = new Map<id,String>();
    	for(Account acc : [select id,website from account where website != null]){
    		emailMap.put(acc.id,acc.website);
    	}
    	for(contact con : conlist){
   			for(id i : emailMap.keySet()){
   				if(emailMap.get(i).endswithignorecase(con.email.substringafterlast('@'))){
   					con.accountid=i;
    				break;
   				}
    		}
    	}
    }
}