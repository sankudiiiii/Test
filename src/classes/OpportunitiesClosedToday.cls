global with sharing class OpportunitiesClosedToday implements Database.Batchable<sObject> , Database.Stateful {
	global Map<Account , Decimal> amountMap = new Map<Account , Decimal>(); 
	global Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator('SELECT Id, Name, (SELECT Email FROM Contacts WHERE level__c = \'Primary\' ), (SELECT Name, Amount FROM Opportunities WHERE Stagename = \'closed won\' ) FROM Account WHERE Id IN (SELECT accountId FROM Opportunity WHERE Closedate = today)');
	}
	global void execute(Database.BatchableContext BC, list<sObject> sObjectList) {
		List<Account> accountList = (List<Account>) sObjectList;
		for(Account accountObject : accountList) {
			for(Opportunity opportunityObject : accountObject.opportunities){
				if(amountMap.containsKey(accountObject))
					amountMap.put(accountObject , amountMap.get(accountObject) + opportunityObject.amount);
				else
					amountMap.put(accountObject , opportunityObject.amount);
			}
		}
	}
	global void finish(Database.BatchableContext BC) {
		List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
		for(Account accountObject : amountMap.keySet()) {
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[]{};
			for(contact contactObject : accountObject.contacts)
				toAddresses.add(contactObject.email);
			mail.setToAddresses(toAddresses);
			mail.setSubject('Closed Won Opportunities of Account ' + accountObject.name);
			String textBody = 'Opportunities :';
			for(Opportunity opportunityObject : accountObject.opportunities)
				textBody += ' ' + opportunityObject.name + ' : ' + opportunityObject.amount;
			textBody += ' Aggregated Amount : ' + amountMap.get(accountObject);
			mail.setPlainTextBody(textBody);
			mailList.add(mail);
		}
		Messaging.sendEmail(mailList , false);
	}	
}