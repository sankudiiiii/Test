trigger Opportunity_After_Update_Trigger on Opportunity (after update) {
    LineItem_Add_CustomerEmail_Handler.executable(trigger.newMap);
}