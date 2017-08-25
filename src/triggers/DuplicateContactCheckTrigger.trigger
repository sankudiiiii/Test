trigger DuplicateContactCheckTrigger on Contact (before insert,before update) {
    for(contact con : trigger.new){
        for(contact c : [select id,name from contact where id!=:con.id and (email!='' and phone!='') and (email=:con.email or phone=:con.Phone)]){
            con.adderror('A Contact with the same email address or phone number already exists in system.');
            break;
        }
    }
}