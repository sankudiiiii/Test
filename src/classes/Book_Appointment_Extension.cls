public with sharing class Book_Appointment_Extension {
	public Event eventObj{get; set;}
	public Id opportunityId;
    public Book_Appointment_Extension(ApexPages.StandardController controller) {
		opportunityId = ApexPages.currentPage().getParameters().get('OppId');
		eventObj = (Event) controller.getRecord();
	}
	public PageReference saveRecord() {
		Organization orgObj = [
			SELECT Street
				 , City
				 , State
				 , Country
				 , PostalCode 
			  FROM Organization 
			 WHERE Id = :UserInfo.getOrganizationId()
		];
		eventObj.Location = orgObj.Street + ' , ' + orgObj.City + ' , ' + orgObj.State + ' , ' + orgObj.PostalCode + ' , ' + orgObj.Country;
		eventObj.Subject = 'Appointment';
		eventObj.WhatId = opportunityId;
		eventObj.DurationInMinutes = 30;
		upsert eventObj;
		return new PageReference('https://ap5.salesforce.com/' + eventObj.Id);
	}
}