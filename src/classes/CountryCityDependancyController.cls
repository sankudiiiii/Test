public with sharing class CountryCityDependancyController {
    public String c1{get;set;}
    
    public CountryCityDependancyController(){}
    
    public list<selectoption> getCountries(){
    	Map<String,Country__c> m1 = Country__c.getAll();
    	List<SelectOption> options = new List<SelectOption>();
    	for(String s : m1.keySet()){
    		options.add(new selectOption(s,s));
    	}
    	return options;
    }
    
    public list<selectoption> getCities(){
    	Map<String,City__c> m1 = City__c.getAll();
    	List<SelectOption> options = new List<SelectOption>();
    	for(String s : m1.keySet()){
    		if(m1.get(s).country__c==c1)
    		options.add(new selectOption(s,s));
    	}
    	return options;
    }
}