global with sharing class LeadManipulatorWebService {
    global class WrapperResponse {
    	webservice boolean isSuccess;
    	webservice String lead;
    	webservice String status;
    }
    webservice static WrapperResponse createLeadRecord (String firstname , String lastname , String email , String phone , String company){
    	WrapperResponse wrapperResponseObj = new WrapperResponse();
    	Lead leadInstance = new Lead(firstname = firstname , lastname = lastname , email = email , phone = phone , company = company);
    	try{
    		insert leadInstance;
    		wrapperResponseObj.isSuccess = true;
    		wrapperResponseObj.lead = leadInstance.Id;
    		wrapperResponseObj.status = 'Success';
    	} catch (Exception e) {
    		wrapperResponseObj.isSuccess = false;
    		wrapperResponseObj.lead = '';
    		wrapperResponseObj.status = e.getMessage();
    	}
    	return wrapperResponseObj;
    }
    webservice static WrapperResponse deleteLeadRecord (String firstname , String lastname , String email , String phone) {
    	WrapperResponse wrapperResponseObj = new WrapperResponse();
    	Lead leadInstance = new Lead();
    	try{
    		leadInstance = [
    			SELECT Id
    				 , Firstname
    				 , Lastname 
    			  FROM Lead 
    			 WHERE Firstname = :firstname 
    			   AND Lastname = :lastname 
    			   AND Email = :email 
    			   AND Phone = :phone
    		];
    		delete leadInstance;
    		wrapperResponseObj.isSuccess = true;
    		wrapperResponseObj.lead = leadInstance.firstname + ' ' + leadInstance.lastName;
    		wrapperResponseObj.status = 'Success';
    	} catch (Exception e) {
    		wrapperResponseObj.isSuccess = false;
    		wrapperResponseObj.lead = '';
    		wrapperResponseObj.status = e.getMessage();
    	}
    	return wrapperResponseObj;
    }
    webservice static WrapperResponse updateLeadRecord (String firstname , String lastname , String email , String phone){
    	WrapperResponse wrapperResponseObj = new WrapperResponse();
    	Lead leadInstance = new Lead();
    	try{
    		leadInstance = [
    			SELECT Id
    				 , Email
    				 , Phone 
    			  FROM Lead 
    			 WHERE Firstname = :firstname 
    			   AND lastname = :lastname
    		];
    		leadInstance.Email = email;
    		leadInstance.Phone = phone;
    		update leadInstance;
    		wrapperResponseObj.isSuccess = true;
    		wrapperResponseObj.lead = leadInstance.Id;
    		wrapperResponseObj.status = 'Success';
    	} catch (Exception e) {
    		wrapperResponseObj.isSuccess = false;
    		wrapperResponseObj.lead = '';
    		wrapperResponseObj.status = e.getMessage();
    	}
    	return wrapperResponseObj;
    }
}