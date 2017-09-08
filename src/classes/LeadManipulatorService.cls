@RestResource(URLMapping='/LeadManipulatorService/*')
global with sharing class LeadManipulatorService {
    global class ResponseWrapper{
    	public boolean isSuccess;
    	public id leadId;
    	public String leadName;
    	public String status;
    }
    @HTTPPost
    global static ResponseWrapper createLeadRecord(String firstName, String lastName, String email, String phone, String company){
    	ResponseWrapper rw = new ResponseWrapper();
    	Lead leadObject = new lead(firstname=firstName,lastname=lastName,email=email,phone=phone,company=company);
    	try{
    		insert leadObject;
    		rw.isSuccess = true;
    		rw.leadId = leadObject.id;
    		rw.leadName = leadObject.firstname + ' ' +leadObject.lastName;
    		rw.status = 'Success';
    	} catch (Exception e){
    		rw.isSuccess = false;
    		rw.leadId = null;
    		rw.leadName = leadObject.firstname + ' ' +leadObject.lastName;
    		rw.status = e.getMessage();
    	}
    	return rw;
    }
    @HTTPDelete
    global static ResponseWrapper deleteLeadRecord(){
    	ResponseWrapper rw = new ResponseWrapper();
    	RestRequest request = RestContext.request;
    	String fn = RestContext.request.params.get('firstName');
    	String ln = RestContext.request.params.get('lastName');
    	String em = RestContext.request.params.get('email');
    	String ph = RestContext.request.params.get('phone');
    	Lead leadObject = new Lead();
    	try{
    		leadObject = [select id,firstname,lastname from lead where firstname=:fn and lastname=:ln and email=:em and phone=:ph limit 1];
    		delete leadObject;
    		rw.isSuccess = true;
    		rw.leadId = null;
    		rw.leadName = leadObject.firstname + ' ' +leadObject.lastName;
    		rw.status = 'Success';
    	} catch (Exception e){
    		rw.isSuccess = false;
    		rw.leadId = leadObject.id;
    		rw.leadName = leadObject.firstname + ' ' +leadObject.lastName;
    		rw.status = e.getMessage();
    	}
    	return rw;
    }
    @HTTPPatch
    global static ResponseWrapper updateLeadRecord(String firstName, String lastName, String email, String phone){
    	ResponseWrapper rw = new ResponseWrapper();
    	Lead leadObject = new Lead();
    	try{
    		leadObject = [select id,firstname,lastname,email,phone from lead where firstname=:firstname and lastname=:lastname limit 1];
    		leadObject.email=email;
    		leadObject.phone=phone;
    		update leadObject;
    		rw.isSuccess = true;
    		rw.leadId = leadObject.id;
    		rw.leadName = leadObject.firstname + ' ' +leadObject.lastName;
    		rw.status = 'Success';
    	} catch (Exception e){
    		rw.isSuccess = false;
    		rw.leadId = leadObject.id;
    		rw.leadName = leadObject.firstname + ' ' +leadObject.lastName;
    		rw.status = e.getMessage();
    	}
    	return rw;
    }
}
/*
{
"firstName":"abc",
"lastName":"xyz",
"email":"abc@xyz.com",
"phone":"1234567",
"company":"ABC"
}

/services/apexrest/LeadManipulatorService?firstname=abc&lastname=xyz&email=abc@xyz.com&phone=1234567
*/