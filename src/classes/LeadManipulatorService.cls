@RestResource(URLMapping = '/LeadManipulatorService/*')
global with sharing class LeadManipulatorService {
    global class ResponseWrapper{
    	public Boolean isSuccess;
    	public Id leadId;
    	public String leadName;
    	public String status;
    }
    @HTTPPost
    global static ResponseWrapper createLeadRecord(String firstName , String lastName , String email , String phone , String company) {
    	ResponseWrapper responseWrapperInstance = new ResponseWrapper();
    	Lead leadObject = new lead(firstname = firstName , lastname = lastName , email = email , phone = phone , company = company);
    	try{
    		insert leadObject;
    		responseWrapperInstance.isSuccess = true;
    		responseWrapperInstance.leadId = leadObject.id;
    		responseWrapperInstance.leadName = leadObject.firstname + ' ' + leadObject.lastName;
    		responseWrapperInstance.status = 'Success';
    	} catch (Exception e){
    		responseWrapperInstance.isSuccess = false;
    		responseWrapperInstance.leadId = null;
    		responseWrapperInstance.leadName = leadObject.firstname + ' ' + leadObject.lastName;
    		responseWrapperInstance.status = e.getMessage();
    	}
    	return responseWrapperInstance;
    }
    @HTTPDelete
    global static ResponseWrapper deleteLeadRecord() {
    	ResponseWrapper responseWrapperInstance = new ResponseWrapper();
    	RestRequest request = RestContext.request;
    	String firstname = RestContext.request.params.get('firstName');
    	String lastName = RestContext.request.params.get('lastName');
    	String email = RestContext.request.params.get('email');
    	String phone = RestContext.request.params.get('phone');
    	Lead leadObject = new Lead();
    	try{
    		leadObject = [
    			SELECT Id
    				 , Firstname
    				 , Lastname 
    			  FROM Lead 
    			 WHERE Firstname = :firstName 
    			   AND Lastname = :lastName 
    			   AND Email = :email 
    			   AND phone = :phone 
    			 LIMIT 1
    		];
    		delete leadObject;
    		responseWrapperInstance.isSuccess = true;
    		responseWrapperInstance.leadId = null;
    		responseWrapperInstance.leadName = leadObject.firstname + ' ' + leadObject.lastName;
    		responseWrapperInstance.status = 'Success';
    	} catch (Exception e){
    		responseWrapperInstance.isSuccess = false;
    		responseWrapperInstance.leadId = leadObject.id;
    		responseWrapperInstance.leadName = leadObject.firstname + ' ' + leadObject.lastName;
    		responseWrapperInstance.status = e.getMessage();
    	}
    	return responseWrapperInstance;
    }
    @HTTPPatch
    global static ResponseWrapper updateLeadRecord(String firstName , String lastName , String email , String phone) {
    	ResponseWrapper responseWrapperInstance = new ResponseWrapper();
    	Lead leadObject = new Lead();
    	try{
    		leadObject = [
    			SELECT Id
    				 , Firstname
    				 , Lastname
    				 , Email
    				 , Phone 
    			  FROM Lead 
    			 WHERE Firstname = :firstName 
    			   AND Lastname=:lastName 
    			 LIMIT 1
    		];
    		leadObject.Email = email;
    		leadObject.Phone = phone;
    		update leadObject;
    		responseWrapperInstance.isSuccess = true;
    		responseWrapperInstance.leadId = leadObject.id;
    		responseWrapperInstance.leadName = leadObject.firstname + ' ' + leadObject.lastName;
    		responseWrapperInstance.status = 'Success';
    	} catch (Exception e){
    		responseWrapperInstance.isSuccess = false;
    		responseWrapperInstance.leadId = leadObject.id;
    		responseWrapperInstance.leadName = leadObject.firstname + ' ' + leadObject.lastName;
    		responseWrapperInstance.status = e.getMessage();
    	}
    	return responseWrapperInstance;
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