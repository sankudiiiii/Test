<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Design_Approved</fullName>
        <description>Design Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Design_Approved</template>
    </alerts>
    <alerts>
        <fullName>Design_Rejected</fullName>
        <description>Design Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Design_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Parts_Added</fullName>
        <description>Parts Added</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Parts_Added</template>
    </alerts>
    <alerts>
        <fullName>Parts_Available</fullName>
        <description>Parts Available</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Parts_Available</template>
    </alerts>
    <alerts>
        <fullName>Parts_Not_Added</fullName>
        <description>Parts Not Added</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Parts_Not_Added</template>
    </alerts>
    <alerts>
        <fullName>Parts_Not_Available</fullName>
        <description>Parts Not Available</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Parts_Not_Available</template>
    </alerts>
    <alerts>
        <fullName>Review_Design</fullName>
        <description>Review Design</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>Service_Agent</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Review_Design</template>
    </alerts>
    <alerts>
        <fullName>Track_Design_Process</fullName>
        <description>Track Design Process</description>
        <protected>false</protected>
        <recipients>
            <field>Customer_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Track_Design_Process</template>
    </alerts>
    <fieldUpdates>
        <fullName>Init</fullName>
        <field>Product_Status__c</field>
        <literalValue>Deign Sent for Approval</literalValue>
        <name>Init</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Init</fullName>
        <actions>
            <name>Init</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.Product_Status__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
