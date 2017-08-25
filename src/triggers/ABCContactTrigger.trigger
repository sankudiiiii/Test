trigger ABCContactTrigger on Contact (before insert) {
    ABCContactTriggerHelper.executable(trigger.new);
}