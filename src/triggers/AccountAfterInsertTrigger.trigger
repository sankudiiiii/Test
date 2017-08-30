trigger AccountAfterInsertTrigger on Account (after insert) {
    TaskCreationHandler.createTask(trigger.new);
}