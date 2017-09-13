public with sharing class Demo {
    public List<String> str{get;set;}
    public List<SelectOption> so{get;set;}
    public List<String> abc{get;set;}
    public List<Account> acc{get;set;}
    public String w{get;set;}
    public String q{get;set;}
    public Demo(ApexPages.StandardController controller){
    	str = new List<String>();
    	abc = new List<String>();
    	so = new List<SelectOption>();
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	so.add(new SelectOption('a','a'));
    	abc.add('name');
    	abc.add('phone');
    	acc = [select id,name,phone from Account limit 10];
    }
    public void abc(){
    	
    }
    public List<String> getLList(){
    	List<String> sl = new List<String>();
    	sl.add('a');
    	sl.add('b');
    	sl.add('c');
    	sl.add('cc');
    	sl.add('ccc');
    	sl.add('cccc');
    	return sl;
    }
    public String getQaz(){
    	return w+'.'+q;
    }
}