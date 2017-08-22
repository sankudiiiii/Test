public with sharing class PM4S1A1Controller {
    public String searchString{get;set;}
    public list<contact> conlist{get;set;}
    public list<account> acclist{get;set;}
    public list<opportunity> opplist{get;set;}
    public list<lead> llist{get;set;}
    public boolean isacc{get;set;}
    public boolean iscon{get;set;}
    public boolean isopp{get;set;}
    public boolean isl{get;set;}
    public PM4S1A1Controller(){
    	acclist=new list<account>();
    	conlist=new list<contact>();
    	opplist=new list<opportunity>();
    	llist=new list<lead>();
    }
    public PageReference search(){
    	acclist.clear();
    	conlist.clear();
    	opplist.clear();
    	llist.clear();
    	String str = '%'+searchString+'%';
    	acclist = [select name from account where name like :str];
    	if(acclist.size()>0)
    		isacc=true;
    	else
    		isacc=false;
    	conlist = [select name from contact where name like :str];
    	if(conlist.size()>0)
    		iscon=true;
    	else
    		iscon=false;
    	opplist = [select name from opportunity where name like :str];
    	if(opplist.size()>0)
    		isopp=true;
    	else
    		isopp=false;
    	llist = [select name from lead where name like :str];
    	if(llist.size()>0)
    		isl=true;
    	else
    		isl=false;
    	return null;
    }
}