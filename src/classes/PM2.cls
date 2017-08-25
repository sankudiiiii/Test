public class PM2 {
	public void getContactList(){
		list<contact> conlist = [select id,name from contact];
for(contact con : conlist){
    System.debug(con);
}
	}
	
	public void activeUserMap(){
		map<id,user> userMap = new Map<id,user>();
list<user> userlist = [select id,name from user where isactive=true];
for(user u : userlist){
    userMap.put(u.id,u);
}
for(id i : userMap.keyset()){
    System.debug('Id : '+i+' User : '+userMap.get(i));
}
	}
	
	public void getAccountMap1(){
		map<String,id> accMap = new Map<String,id>();
list<account> acclist = [select id,name from account];
for(account acc : acclist){
    accMap.put(acc.name,acc.id);
}
for(String i : accMap.keyset()){
    System.debug('Name : '+i+' Id : '+accMap.get(i));
}
	}
	
	public void getAccountMap2(){
		map<id,account> accMap = new Map<id,account>();
list<account> acclist = [select id,name from account];
for(account acc : acclist){
    accMap.put(acc.id,acc);
}
for(id i : accMap.keyset()){
    System.debug('Id : '+i+' Account : '+accMap.get(i));
}
	}
	
	public void getAccountEnrollmentYear2010(){
		list<account> acclist = [select id,enrollment_year__c from account where enrollment_year__c includes ('2010')];
for(account acc : acclist){
    System.debug('Id : '+acc.id+' Enrollment Year : '+acc.enrollment_year__c);
}
	}
	
	public void getAccountEnrollmentYear20132014(){
		list<account> acclist = [select id,enrollment_year__c from account where enrollment_year__c includes ('2013','2014')];
for(account acc : acclist){
    System.debug('Id : '+acc.id+' Enrollment Year : '+acc.enrollment_year__c);
}
	}
	
	public void getAccountBillingState(){
		list<account> acclist = [select id,billingstate from account where billingstate not in ('Maharashtra','Kerala') order by billingstate desc nulls last limit 10000];
for(account acc : acclist){
    System.debug('Id : '+acc.id+' Billing State : '+acc.billingstate);
}
	}
	
	public void getOpportunityFromBin(){
		list<opportunity> opplist = [select id,amount from opportunity where amount > 10000 order by createddate limit 100 offset 50 all rows];
for(opportunity opp : opplist){
    System.debug('Id : '+opp.id+' Amount : '+opp.amount);
}
	}
	
	public void getClosedOpportunityForCurrentFiscalYear(){
		Map<Integer,Decimal> stat = new Map<Integer,Decimal>();
aggregateresult agg = [select sum(amount) from opportunity where stagename in ('Closed Won','Closed Lost') and closedate = this_fiscal_year];
stat.put(System.today().year(),(Decimal)agg.get('expr0'));
for(Integer i : stat.keyset()){
	System.debug('Year : '+i+' Total Amount : '+stat.get(i));
}
	}
	
	public void getCountOfLeadBySource(){
		aggregateresult[] agglist = [select leadsource,count_distinct(name) from lead group by leadsource having count_distinct(name)>10];
for(aggregateresult agg : agglist){
	System.debug(agg);
}
	}
	
	public void countLeadByStatusBySource(){
		Map<String,Map<String,Integer>> map2 = new Map<String,Map<String,Integer>>();
List<Schema.PicklistEntry> statuslist = lead.status.getdescribe().getpicklistvalues();
List<Schema.PicklistEntry> sourcelist = lead.leadsource.getdescribe().getpicklistvalues();
list<lead> leadlist = [select id,name,status,leadsource from lead];
for(Schema.PicklistEntry s1 : sourcelist){
	String  source = s1.getlabel();
	Map<String,Integer> map1 = new Map<String,Integer>();
	for(Schema.PicklistEntry s2 : statuslist){
		String  status = s2.getlabel();
		Integer count = 0;
		for(lead l : leadlist){
			if(l.leadsource == source && l.status == status)
				count++;
		}
		map1.put(status,count);		
	}
	map2.put(source,map1);
}
/*
for(Schema.PicklistEntry sl : sourcelist){
    String  source = sl.getlabel();
	Map<String,Integer> map1 = new Map<String,Integer>();
    aggregateresult[] agglist = [select status,count(name) from lead where leadsource = :source group by status ];
    for(aggregateresult agg : agglist){
        map1.put((String)agg.get('status'),(Integer)agg.get('expr0'));
    }
    map2.put(sl.getlabel(),map1);
}*/
for(String str : map2.keyset()){
    System.debug('Lead Source : '+str+' Status Map : '+map2.get(str));
}
	}
	
	public void getContactsWithMediaIndustry(){
		List<contact> conlist = [select id,name,account.industry from contact where account.industry = 'Media'];
for(contact con : conlist){
    System.debug(con);
}
	}
	
	public void searchJohnInC(){
list<c__c> clist = [select name,A_MD__r.name,b_md__r.name from c__c where name = 'John'];
for(c__c c : clist){
    System.debug('Name : '+c.name+' A Parent : '+c.a_md__r.name+' B Parent : '+c.b_md__r.name);
}
	}
	
	public void getAccountChildJohn(){
		List<account> acclist = [select id,name,(select id,name from contacts where name like '%John%') from account];
for(account acc : acclist){
    	System.debug('Account : '+acc+' Contacts : '+acc.contacts);
}
	}
	
	public void getAccountWithClosedWonOpportunity(){
list<account> acclist = [select id,name,(select id,name,stagename from opportunities where stagename = 'Closed Won') from account where id in (select accountid from opportunity where stagename = 'Closed Won')];
for(account acc : acclist){
    System.debug('Account : '+acc+' Opportunity : '+acc.opportunities);
}
	}
	
	public void getAChildJohn(){
		List<a__c> alist = [select id,name,(select id,name from cs__r) from a__c where id in (select a_md__c from c__c where name='John')];
for(a__c a : alist){
    	System.debug('A : '+a+' C : '+a.cs__r);
}
	}
	
	public void searchTestInName(){
		list<list<sObject>> slist = [find 'test' in name fields returning contact(id,name),account(id,name),lead(id,name),user(id,name)];
for(list<sobject> s : slist){
    System.debug(s);
}
	}
	
	public void generateErrorLog(){
		String lastname = 'lead';
String leadcompany = 'ESPL';
list<lead> leadlist = new list<lead>();
list<log__c> loglist = new list<log__c>();
for(Integer i = 1; i<=100;i++){
    leadlist.add(new lead(lastname=lastname+i,company=leadcompany));
}
System.debug(leadlist);
Database.SaveResult[] srList = Database.insert(leadlist, false);
for(Database.SaveResult sr : srList){
    if (!sr.isSuccess()){
        for(Database.Error err : sr.getErrors()){
            loglist.add(new log__c(name=sr.getId(),error__c=err.getmessage()));
        }
    }
}
System.debug(loglist);
insert loglist;
	}
	
	public void deleteInactiveAccounts(){
		list<account> acclist= [select id from account where active__c='No'];
for(account acc : acclist){
    System.debug(acc);
}
delete acclist;
	}
}
/*
PM2 pm = new PM2();
pm.getContactList();

pm.activeUserMap();

pm.getAccountMap1();

pm.getAccountMap2();

pm.getAccountEnrollmentYear2010();

pm.getAccountEnrollmentYear20132014();

pm.getAccountBillingState();

pm.getOpportunityFromBin();

pm.getClosedOpportunityForCurrentFiscalYear();

pm.getCountOfLeadBySource();

pm.countLeadByStatusBySource();

pm.getContactsWithMediaIndustry();

pm.searchJohnInC();

pm.getAccountChildJohn();

pm.getAccountWithClosedWonOpportunity();

pm.getAChildJohn();

pm.searchTestInName();

pm.generateErrorLog();

pm.deleteInactiveAccounts();
*/