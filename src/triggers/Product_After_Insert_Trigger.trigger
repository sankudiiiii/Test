trigger Product_After_Insert_Trigger on Product2 (after insert) {
    Add_Price_Handler.executable(trigger.new);
}