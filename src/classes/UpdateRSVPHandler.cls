public with sharing class UpdateRSVPHandler {
    public static void executable(list<campaignmember> cmList){
    	Map<campaignmember,lead> cmMap = new Map<campaignmember,lead>();
    	set<ID> idset = new set<ID>();
    	for(campaignmember c : cmList){
    		if(c.leadid!=null && c.RSVP__c==null){
    			idset.add(c.leadid);
    			cmMap.put(c,null);
    		}
    	}
    	list<lead> leadlist = [select id,RSVP__c from lead where id in :idset];
    	for(lead l : leadlist){
    		for(campaignmember c : cmMap.keySet()){
    			if(c.leadid==l.id){
    				cmMap.put(c,l);
    			}
    		}
    	}
    	UpdateRSVP(cmMap);
    }
    public static void UpdateRSVP(Map<campaignmember,lead> cmMap){
    	for(campaignmember c : cmMap.keyset()){
    		System.debug(c.RSVP__c);
    		lead l = cmMap.get(c);
    		System.debug(l.RSVP__C);
    		c.RSVP__c=cmMap.get(c).RSVP__C;
    	}
    }
}