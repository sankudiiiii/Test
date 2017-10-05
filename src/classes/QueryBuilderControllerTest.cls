@isTest
private class QueryBuilderControllerTest {
	public static testmethod void controllerTest(){
		QueryBuilderController controller = new QueryBuilderController();
		System.assert(controller.objectNameList.size()>0,'Controller not initialized');
		System.assert(controller.recordSortOrderList.size()>0,'Controller not initialized');
		System.assert(controller.recordLimitList.size()>0,'Controller not initialized');
		System.assert(controller.orderByList.size()==1,'Controller not initialized');
	}
	public static testmethod void listsGetterTest(){
		QueryBuilderController controller = new QueryBuilderController();
		System.assertNotEquals(null,controller.getObjectNameList(),'ObjectNameList not initialized');
		System.assertNotEquals(null,controller.getRecordSortOrderList(),'RecordSortOrderList not initialized');
		System.assertNotEquals(null,controller.getRecordLimitList(),'RecordLimitList not initialized');
		System.assertNotEquals(null,controller.getToSelectList(),'ToSelectList not initialized');
		System.assertNotEquals(null,controller.getSelectedList(),'SelectedList not initialized');
		System.assertNotEquals(null,controller.getOrderByList(),'OrderByList not initialized');
		System.assertNotEquals(null,controller.getFieldValues(),'FieldValues not initialized');
	}
	public static testmethod void fieldSetterTest(){
		QueryBuilderController controller = new QueryBuilderController();
		controller.objectName='Account';
		controller.setFieldAndOrderLists();
		System.assertEquals('NONE',controller.orderByField,'orderByField not instantiated');
		System.assert(controller.toSelectList.size()>0,'toSelectList not instantiated');
		System.assert(controller.selectedList.size()==1,'selectedList not instantiated');
		System.assertNotEquals(null,controller.nameField,'nameField not instantiated');
		System.assert(controller.orderByList.size()>0,'orderByList not instantiated');
	}
	public static testmethod void addTest(){
		QueryBuilderController controller = new QueryBuilderController();
		controller.objectName='Account';
		controller.setFieldAndOrderLists();
		controller.addFieldList.add('Website');
		controller.add();
		boolean actual = false;
		for(SelectOption option : controller.selectedList)
			if(option.getValue() == 'Website')
				actual = true;
		System.assertNotEquals(false,actual,'new picklist value not added in selectedList');
		actual = true;
		for(SelectOption option : controller.toSelectList)
			if(option.getValue() == 'Website')
				actual = false;
		System.assertEquals(true,actual,'new picklist value not removed from toSelectList');
	}
	public static testmethod void removeTest(){
		QueryBuilderController controller = new QueryBuilderController();
		controller.objectName='Account';
		controller.setFieldAndOrderLists();
		controller.addFieldList.add('Website');
		controller.add();
		controller.removeFieldList.add('Website');
		controller.remove();
		boolean actual = false;
		for(SelectOption option : controller.toSelectList)
			if(option.getValue() == 'Website')
				actual = true;
		System.assertNotEquals(false,actual,'new picklist value not added in toSelectList');
		actual = true;
		for(SelectOption option : controller.selectedList)
			if(option.getValue() == 'Website')
				actual = false;
		System.assertEquals(true,actual,'new picklist value not removed from selectedList');
	}
	public static testmethod void searchStringPositiveTest(){
		QueryBuilderController controller = new QueryBuilderController();
		controller.objectName='Account';
		controller.setFieldAndOrderLists();
		controller.addFieldList.add('Website');
		controller.addFieldList.add('Id');
		controller.add();
		controller.recordLimit = '500';
		controller.orderByField = 'Id';
		controller.setsearchString();
		String searchString = controller.getsearchString();
		System.assertNotEquals(null,searchString,'Some values required to form the searchString not initialized');
		System.assertNotEquals('',searchString,'Some values required to form the searchString not initialized');
	}
	public static testmethod void searchStringNegativeTest(){
		QueryBuilderController controller = new QueryBuilderController();
		controller.objectName='Account';
		controller.setFieldAndOrderLists();
		controller.addFieldList.add('Website');
		controller.addFieldList.add('Id');
		controller.add();
		controller.setsearchString();
		String searchString = controller.getsearchString();
		System.assertEquals('',searchString,'All values required to form the searchString are initialized by default');
	}
	public static testmethod void executeQueryNegativeTest(){
		QueryBuilderController controller = new QueryBuilderController();
		controller.objectName='Account';
		controller.setFieldAndOrderLists();
		controller.addFieldList.add('Website');
		controller.addFieldList.add('Id');
		controller.add();
		controller.executeQuery();
		System.assert(ApexPages.hasMessages(),'Message should be get generated if search string is invalid');
	}
	public static testmethod void executeQueryPositiveTest(){
		QueryBuilder_TestDataFactory.QueryBuilderTestData();
		QueryBuilderController controller = new QueryBuilderController();
		controller.objectName='Account';
		controller.setFieldAndOrderLists();
		controller.addFieldList.add('Website');
		controller.addFieldList.add('Id');
		controller.add();
		controller.recordLimit = '500';
		controller.orderByField = 'Id';
		controller.executeQuery();
		System.assertNotEquals(null,controller.sObjectList,'Query not executed');
		System.assert(controller.sObjectList.size()>0,'No records returned by query');
	}
	public static testmethod void getContainFieldNamePositiveTest(){
		QueryBuilder_TestDataFactory.QueryBuilderTestData();
		QueryBuilderController controller = new QueryBuilderController();
		controller.objectName='Account';
		controller.setFieldAndOrderLists();
		controller.executeQuery();
		boolean actual = controller.getContainFieldName();
		System.assertEquals(true, actual , 'NameField not initialized');
	}
	public static testmethod void getContainFieldNameNegativeTest(){
		QueryBuilder_TestDataFactory.QueryBuilderTestData();
		QueryBuilderController controller = new QueryBuilderController();
		controller.objectName='Account';
		controller.setFieldAndOrderLists();
		controller.removeFieldList.add('Name');
		controller.remove();
		controller.executeQuery();
		boolean actual = controller.getContainFieldName();
		System.assertEquals(false, actual , 'NameField not initialized');
	}
}