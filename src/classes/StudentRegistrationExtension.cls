public with sharing class StudentRegistrationExtension {
	public Student__c s{get;set;}
	public String lang{get;set;}
	public list<selectoption> so{get;set;}
    public StudentRegistrationExtension(ApexPages.StandardController controller){
    	so = new list<selectoption>();
    	s = (Student__c)controller.getrecord();
    	for(String s : System.label.Language.split(',')){
    		so.add(new selectoption(s,s));
    	}
    	
	}
	public pagereference insertRecord(){
		upsert s;
		return null;
	}
	public pagereference changelang(){
		PageReference pageRef = new PageReference(ApexPages.currentPage().getUrl());
		pageRef.setRedirect(true);
		System.debug(pageRef);
		return null;
	}
}