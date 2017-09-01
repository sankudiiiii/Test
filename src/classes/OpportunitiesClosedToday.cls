global with sharing class OpportunitiesClosedToday implements Database.Batchable<sObject>,Database.Stateful{
	global Map<Account,Decimal> amountMap = new Map<Account,Decimal>(); 
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('select id,name,(select email from contacts where level__c=\'Primary\'),(select name,amount from opportunities where stagename=\'closed won\') from account where id in (select accountid from opportunity where closedate=today)');
	}
	global void execute(Database.BatchableContext BC, list<sObject> soList){
		list<Account> accountList = (list<account>) soList;
		for(Account accountObject : accountList){
			for(Opportunity opportunityObject : accountObject.opportunities){
				if(amountMap.containsKey(accountObject)){
					amountMap.put(accountObject,amountMap.get(accountObject)+opportunityObject.amount);
				} else {
					amountMap.put(accountObject,opportunityObject.amount);
				}
			}
		}
	}
	global void finish(Database.BatchableContext BC){
		System.debug(amountMap);
		List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
		for(Account accountObject : amountMap.keySet()){
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[]{};
			for(contact contactObject : accountObject.contacts){
				toAddresses.add(contactObject.email);
			}			
			mail.setToAddresses(toAddresses);
			mail.setSubject('Closed Won Opportunities of Account ' + accountObject.name);
			String textBody = 'Opportunities :';
			for(Opportunity opportunityObject : accountObject.opportunities){
				textBody += ' '+opportunityObject.name+' : '+opportunityObject.amount;
			}
			textBody += ' Aggregated Amount : '+amountMap.get(accountObject);
			mail.setPlainTextBody(textBody);
			mailList.add(mail);
		}
		System.debug(mailList);
		Messaging.sendEmail(mailList,false);
	}	
}
/*
OpportunitiesClosedTodaySchedular octs = new OpportunitiesClosedTodaySchedular();
String cron = '0 59 23 * * ?';
System.schedule('Closed Opportunities', cron , octs);
*/