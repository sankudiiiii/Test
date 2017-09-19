<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Big_Deal</fullName>
        <description>Big Deal</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Big_Deal</template>
    </alerts>
    <alerts>
        <fullName>abc</fullName>
        <description>abc</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>Product_Manager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Approve</template>
    </alerts>
    <rules>
        <fullName>Big Deal</fullName>
        <actions>
            <name>Big_Deal</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>greaterOrEqual</operation>
            <value>50000</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Negotiation/Review</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
