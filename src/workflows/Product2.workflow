<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Active_Update</fullName>
        <field>IsActive</field>
        <literalValue>1</literalValue>
        <name>Active Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Design_Approved</fullName>
        <field>Design_Process_Status__c</field>
        <literalValue>Design Approved</literalValue>
        <name>Design Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Design_Rejected</fullName>
        <field>Design_Process_Status__c</field>
        <literalValue>Design Rejected</literalValue>
        <name>Design Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU</fullName>
        <field>Design_Process_Status__c</field>
        <literalValue>Deign Sent for Approval</literalValue>
        <name>FU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Family_Update</fullName>
        <field>Family</field>
        <literalValue>Custom Bike</literalValue>
        <name>Family Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Initial_Owner_Update</fullName>
        <field>Owner__c</field>
        <lookupValue>mandharesanket79284sau@gmail.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Initial Owner Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Parts_Added</fullName>
        <field>Design_Process_Status__c</field>
        <literalValue>Parts Added</literalValue>
        <name>Parts Added</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Parts_Available</fullName>
        <field>Design_Process_Status__c</field>
        <literalValue>Parts Available</literalValue>
        <name>Parts Available</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Parts_Not_Added</fullName>
        <field>Design_Process_Status__c</field>
        <literalValue>Parts Not Added</literalValue>
        <name>Parts Not Added</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Parts_Not_Available</fullName>
        <field>Design_Process_Status__c</field>
        <literalValue>Parts Not Available</literalValue>
        <name>Parts Not Available</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Update</fullName>
        <field>Design_Process_Status__c</field>
        <literalValue>Deign Sent for Approval</literalValue>
        <name>Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Update_Review</fullName>
        <field>Design_Process_Status__c</field>
        <literalValue>Review</literalValue>
        <name>Status Update Review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Custom Bike Initial Field Values</fullName>
        <actions>
            <name>Active_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Family_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Initial_Owner_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Status_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>4 AND (1 OR 2 OR 3)</booleanFilter>
        <criteriaItems>
            <field>Product2.IsActive</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Product2.Owner__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Product2.Design_Process_Status__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Product2.Family</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Custom Bike Review</fullName>
        <actions>
            <name>Status_Update_Review</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Product2.Image_Document_Id__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Follow_Up_task</fullName>
        <assignedTo>mandharesanket79284sau@gmail.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Follow Up task</subject>
    </tasks>
</Workflow>
