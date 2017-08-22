@istest
public class DuplicateContactCheckTriggerTest {
    public static testmethod void DuplicateContactCheckTriggerBeforeInsertUpdateTest(){
    	Contact con1 = new contact(lastname='ln',experience__c=10,email='a@b.c',phone='123');
    	insert con1;
        Contact con2 = new contact(lastname='ln1',experience__c=12,email='a@b.c',phone='123');
    	Database.SaveResult sr = Database.insert(con2, false);
        System.assert(!sr.isSuccess());
        for(Database.Error err : sr.getErrors()){
        	System.debug(err.getmessage());
        }
    }
}