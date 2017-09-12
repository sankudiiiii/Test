public with sharing class Demo {
    public List<String> str{get;set;}
    public List<SelectOption> so{get;set;}
    public Demo(ApexPages.StandardController controller){
    	str = new List<String>();
    	so = new List<SelectOption>();
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    }
    public void abc(){
    	
    }
}