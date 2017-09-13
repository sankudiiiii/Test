public with sharing class StudentRegistrationExtension {
	public Student__c studentInstance{get; set;}
	public String language{get; set;}
	public list<selectoption> optionList{get; set;}
    public StudentRegistrationExtension(ApexPages.StandardController controller) {
    	optionList = new list<selectoption>();
    	studentInstance = (Student__c)controller.getrecord();
    	for(String languageValue : System.label.Language.split(','))
    		optionList.add(new selectoption(languageValue , languageValue));
	}
	public pagereference insertRecord() {
		upsert studentInstance;
		return null;
	}
	public pagereference changelang() {
		PageReference pageRef = new PageReference(ApexPages.currentPage().getUrl());
		pageRef.setRedirect(true);
		return null;
	}
}