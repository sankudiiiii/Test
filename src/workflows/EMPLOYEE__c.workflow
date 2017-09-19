<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Employee_Deactivation</fullName>
        <description>Employee Deactivation</description>
        <protected>false</protected>
        <recipients>
            <field>Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Deactivated_Employee</template>
    </alerts>
    <fieldUpdates>
        <fullName>Non_Technical_Employee</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Non_Technical</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Non Technical Employee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OTO</fullName>
        <field>Role_Name__c</field>
        <formula>Role__r.Name</formula>
        <name>OTO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Employee Deactivation</fullName>
        <actions>
            <name>Employee_Deactivation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EMPLOYEE__c.Is_Active__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>No Current Employee</fullName>
        <actions>
            <name>Non_Technical_Employee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EMPLOYEE__c.Current_Employee__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>One To One</fullName>
        <actions>
            <name>OTO</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EMPLOYEE__c.Role_Name__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
