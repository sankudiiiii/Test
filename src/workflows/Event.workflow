<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Survey_Appointment_Email_Alert</fullName>
        <description>Survey Appointment Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Survey_Appointment_Email_Template</template>
    </alerts>
    <alerts>
        <fullName>Survey_Appointment_Reminder_Alert</fullName>
        <description>Survey Appointment Reminder Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Survey_Appointment_Reminder_Email_Template</template>
    </alerts>
</Workflow>
