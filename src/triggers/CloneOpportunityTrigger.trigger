trigger CloneOpportunityTrigger on Opportunity (after insert) {
    if(CloneOpportunityTriggerHelper.runOnce){
        CloneOpportunityTriggerHelper.runOnce=false;
        list<opportunity> opplist = new list<Opportunity>();
        for(Opportunity opp : trigger.new){
            opplist.add(opp.clone());
        }
        CloneOpportunityTriggerHelper.cloneOpportunity(opplist);
    }
}