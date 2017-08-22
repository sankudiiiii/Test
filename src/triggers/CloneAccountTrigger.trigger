trigger CloneAccountTrigger on Account (after insert) {
    if(CloneAccountTriggerHelper.runOnce){
        CloneAccountTriggerHelper.runOnce=false;
        list<Account> acclist = new list<account>();
        for(account acc : trigger.new){
            acclist.add(acc.clone());
        }
        CloneAccountTriggerHelper.cloneAccountRecord(acclist);
    }
}