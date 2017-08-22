trigger CaseTrigger on Case (before insert,before update) {
    for(Case c : trigger.new){
        if(c.Origin=='Web' || c.Origin=='Chat' || c.Origin=='Email'){
            account acc = [select id,(select id from contacts where email=:c.SuppliedEmail limit 1) from account where email_address__c=:c.SuppliedEmail limit 1];
            c.AccountId=acc.id;
            Contact con = acc.contacts;
            c.ContactId= con.id;
            System.debug(c);
        }
    }
}