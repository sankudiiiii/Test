trigger EFTAddressVerificationTrigger on EFT_Transaction_Status__c (after insert) {
    list<EFT_Transaction_Status__c> eftlist = new list<EFT_Transaction_Status__c>();
    for(EFT_Transaction_Status__c eft : trigger.new){
        SalesHeader__c sh = [select status__c from SalesHeader__c where id =: eft.SalesHeader__c];
        if(eft.method_name__c=='Credit Card Address Verify' && eft.transaction_status__c=='Declined' && sh.status__c=='Open'){
            eftlist.add(eft);
        }
    }
    EFTAddressVerificationTriggerHandler.EFTAddressVerificationAfterInsertHandler(eftlist);
}