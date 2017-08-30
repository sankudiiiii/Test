trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete) {
    Trigger_Setting__c m = Trigger_Setting__c.getvalues((ID)UserInfo.getUserId());
    System.debug(m);
    if(m.AccountTrigger__c==true){
    if(trigger.isinsert){
        if(trigger.isbefore) {
            for(account acc : trigger.new){
            system.debug('Before Insert New : '+acc);
            }
        } else {
            for(account acc : trigger.new){
                system.debug('After Insert New : '+acc);
            }
            for(Id i : trigger.newmap.keyset()){
                System.debug('After Insert NewMap : '+trigger.newmap.get(i));
            }
        }
    } else if(trigger.isupdate) {
        if(trigger.isbefore){
            for(account acc : trigger.old){
                system.debug('Before Update Old : '+acc);
            }
            for(Id i : trigger.oldmap.keyset()){
                System.debug('Before Update OldMap : '+trigger.oldmap.get(i));
            }
            for(account acc : trigger.new){
                system.debug('Before Update New : '+acc);
            }
            for(Id i : trigger.newmap.keyset()){
                System.debug('Before Update NewMap : '+trigger.newmap.get(i));
            }
        } else {
            for(account acc : trigger.old){
                system.debug('After Update Old : '+acc);
            }
            for(Id i : trigger.oldmap.keyset()){
                System.debug('After Update OldMap : '+trigger.oldmap.get(i));
            }
            for(account acc : trigger.new){
                system.debug('After Update New : '+acc);
            }
            for(Id i : trigger.newmap.keyset()){
                System.debug('After Update NewMap : '+trigger.newmap.get(i));
            }
        }
    } else if(trigger.isdelete) {
        if(trigger.isbefore){
            for(account acc : trigger.old){
                system.debug('Before Delete Old : '+acc);
            }
            for(Id i : trigger.oldmap.keyset()){
                System.debug('Before Delete OldMap : '+trigger.oldmap.get(i));
            }
        } else {
            for(account acc : trigger.old){
                system.debug('After Delete Old : '+acc);
            }
            for(Id i : trigger.oldmap.keyset()){
                System.debug('After Delete OldMap : '+trigger.oldmap.get(i));
            }
        }
    }
    }
}