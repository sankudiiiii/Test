global with sharing class LeadManipulatorWebService {
    global class WrapperResponse{
    	webservice boolean isSuccess;
    	webservice String lead;
    	webservice String status;
    }
    webservice static WrapperResponse createLeadRecord(String firstname,String lastname,String email,String phone,String company){
    	WrapperResponse wr = new WrapperResponse();
    	Lead leadInstance = new Lead(firstname=firstname,lastname=lastname,email=email,phone=phone,company=company);
    	try{
    		insert leadInstance;
    		wr.isSuccess=true;
    		wr.lead=leadInstance.id;
    		wr.status='Success';
    	} catch (Exception e) {
    		wr.isSuccess=false;
    		wr.lead='';
    		wr.status=e.getMessage();
    	}
    	return wr;
    }
    webservice static WrapperResponse deleteLeadRecord(String firstname,String lastname,String email,String phone){
    	WrapperResponse wr = new WrapperResponse();
    	Lead leadInstance = new lead();
    	try{
    		leadInstance = [select id,firstname,lastname from lead where firstname=:firstname and lastname=:lastname and email=:email and phone=:phone];
    		delete leadInstance;
    		wr.isSuccess=true;
    		wr.lead=leadInstance.firstname + ' ' +leadInstance.lastName;
    		wr.status='Success';
    	} catch (Exception e) {
    		wr.isSuccess=false;
    		wr.lead='';
    		wr.status=e.getMessage();
    	}
    	return wr;
    }
    webservice static WrapperResponse updateLeadRecord(String firstname,String lastname,String email,String phone){
    	WrapperResponse wr = new WrapperResponse();
    	Lead leadInstance = new lead();
    	try{
    		leadInstance = [select id,email,phone from lead where firstname=:firstname and lastname=:lastname];
    		leadInstance.email=email;
    		leadInstance.phone=phone;
    		update leadInstance;
    		wr.isSuccess=true;
    		wr.lead=leadInstance.id;
    		wr.status='Success';
    	} catch (Exception e) {
    		wr.isSuccess=false;
    		wr.lead='';
    		wr.status=e.getMessage();
    	}
    	return wr;
    }
}