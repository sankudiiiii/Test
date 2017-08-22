trigger CloneLeadTrigger on Lead (after insert) {
    if(CLoneLeadTriggerHelper.runOnce){
        CloneLeadTriggerHelper.runOnce=false;
        List<lead> leadlist = new list<Lead>();
        for(lead l : trigger.new){
            leadlist.add(l.clone());
        }
        CloneLeadTriggerHelper.cloneLead(leadlist);
    }
}