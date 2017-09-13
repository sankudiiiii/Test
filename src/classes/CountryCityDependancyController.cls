public with sharing class CountryCityDependancyController {
    public String selectedCountry{get; set;}
    public String selectedCity{get; set;}
    
    public CountryCityDependancyController() {}
    
    public list<selectoption> getCountries() {
    	Map<String , Country__c> countryMap = Country__c.getAll();
    	List<SelectOption> optionList = new List<SelectOption>();
    	for(String country : countryMap.keySet())
    		optionList.add(new selectOption(country , country));
    	return optionList;
    }
    
    public list<selectoption> getCities() {
    	Map<String,City__c> cityMap = City__c.getAll();
    	List<SelectOption> optionList = new List<SelectOption>();
    	for(String city : cityMap.keySet()){
    		if(cityMap.get(city).country__c == selectedCountry)
    		optionList.add(new selectOption(city , city));
    	}
    	return optionList;
    }
}