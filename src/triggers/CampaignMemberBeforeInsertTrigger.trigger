trigger CampaignMemberBeforeInsertTrigger on CampaignMember (before insert) {
    UpdateRSVPHandler.executable(trigger.new);
}