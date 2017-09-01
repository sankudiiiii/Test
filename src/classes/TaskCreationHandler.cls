public with sharing class TaskCreationHandler {
    public static void createTask(list<account> accountList){
    	list<task> tasklist = new list<task>();
    	for(Account accountRecord : accountList){
    		tasklist.add(new task(subject='Meeting with '+accountRecord.name,
    							  status='Not Started',
    							  priority='Normal'));
    	}
    	insert taskList; 
    }
}