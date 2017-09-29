trigger Product_After_Update_Trigger on Product2 (after update) {
    Update_LineItem_ProductStatus_Handler.executable(trigger.newMap);
}