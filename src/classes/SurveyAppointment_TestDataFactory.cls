@isTest
public class SurveyAppointment_TestDataFactory {
    public static void generateSurveyAppointmentCustomSettingTestData(){
    	Survey_Appointment_Time_Setting__c timeSetting = new Survey_Appointment_Time_Setting__c();
    	timeSetting.End_Time_Hours__c = 19; 
    	timeSetting.End_Time_Minutes__c = 30;
    	timeSetting.Start_Time_Hours__c = 7;
    	timeSetting.Start_Time_Minutes__c = 30;
    	timeSetting.Time_Slot_Difference__c = 30;
    	timeSetting.Name = 'Survey Appointment Time';
    	insert timeSetting;
    	Survey_Appointment_Company_Setting__c companySetting = new Survey_Appointment_Company_Setting__c();
    	companySetting.AssignTo_User__c = 'System Administrator';
    	companySetting.Company_Postal_Code__c = '411007';
    	companySetting.Event_Subject__c = 'Survey Appointment';
    	companySetting.Reachable_Time_in_Seconds__c = 18000;
    	companySetting.Name = 'Company Location';
    	insert companySetting;
    	Google_Distance_Matrix_API_Setting__c apiSetting = new Google_Distance_Matrix_API_Setting__c();
    	apiSetting.Base_URL__c = 'http://maps.googleapis.com/maps/api/distancematrix/';
    	apiSetting.Language__c = 'en-EN';
    	apiSetting.Response_Type__c = 'json';
    	apiSetting.Sensor__c = 'false';
    	apiSetting.Name = 'Google Distance Matrix API';
    	insert apiSetting;
    	Survey_Appointment_Message_Setting__c messageSetting = new Survey_Appointment_Message_Setting__c();
    	messageSetting.Name = 'Survey Appointment Message';
    	messageSetting.API_Failure_Message__c = 'Sorry..! We are unable to process your request. Please try again after some time. For further queries drop us an email at "support@xyzcompany.com" and we will be glad to assist you.';
    	messageSetting.API_Result_Failure_Message__c = 'Sorry..! We are unable to track the specified address. Please drop us an email at "support@xyzcompany.com" and we will be glad to assist you.';
    	messageSetting.Failed_to_Reach_Message__c = 'Sorry..! We are unable to reach you at the specified address. Please drop us an email at "support@xyzcompany.com" and we will be glad to assist you.';
    	messageSetting.Success_Message__c = 'Thank You. Your appointment is been booked. For any queries drop us an email at "support@xyzcompany.com" and we will be glad to assist you.';
    	messageSetting.Today_Timeout_Message__c = 'Sorry..! You can not book an appointment for today now. Please book an appointment for tommorrow. For further queries drop us an email at "support@xyzcompany.com" and we will be glad to assist you.';
    	insert messageSetting;
    }
    public static void generateSurveyAppointmentRecordTestData(){
    	User userObj = new User(LastName = 'ln' , Phone = '5684239' , Email = 'ln@user.com' , UserName = 'ln@user.com' , Alias = 'ln' , CommunityNickName = 'ln' , TimeZoneSIdKey = 'America/Los_Angeles' , LocaleSIdKey = 'en_US' , EmailEncodingKey = 'UTF-8', ProfileId = '00e7F000001TR4x' , LanguageLocaleKey = 'en_US');
    	insert userObj;
    	Contact contactObj = new Contact(LastName = 'Mandhare' , email = 's@m.com');
    	insert contactObj;
    	Event eventObj = new Event(OwnerId = userObj.Id , Subject = 'Survey Appointment' , StartDateTime = DateTime.newInstance(System.today() , Time.newInstance(15,0,0,0)) , EndDateTime = DateTime.newInstance(System.today() , Time.newInstance(15,30,0,0)));
    	insert eventObj;
    }
}