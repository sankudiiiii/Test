public with sharing class QueryBuilderController {
    public String objectName{get; set;}
    public List<SelectOption> objectNameList;
    public String recordSortOrder{get; set;}
    public List<SelectOption> recordSortOrderList;
    public String recordLimit{get; set;}
    public List<SelectOption> recordLimitList;
    public List<String> addFieldList{get; set;}
    public List<SelectOption> toSelectList;
    public List<String> removeFieldList{get; set;}
    public List<SelectOption> selectedList;
    public String orderByField{get; set;}
    public List<SelectOption> orderByList;
    public String searchString;
    public List<sObject> sObjectList{get; set;}
    public List<String> fieldValues;
    
    public QueryBuilderController(){
    	objectNameList = new List<SelectOption>();
    	setObjectNameList(new List<SelectOption>());
    	recordSortOrderList = new List<SelectOption>();
    	setRecordSortOrderList(new List<SelectOption>());
    	recordLimitList = new List<SelectOption>();
    	setRecordLimitList(new List<SelectOption>());
    	addFieldList = new List<String>();
    	toSelectList = new List<SelectOption>();
		removeFieldList = new List<String>();
		selectedList = new List<SelectOption>();
		orderByList = new List<SelectOption>();
    	orderByList.add(new SelectOption('NONE','--- SELECT ORDER BY FIELD ---'));
    	fieldValues = new List<String>();
    }
    
    public void setObjectNameList(List<SelectOption> oNameList){
    	objectNameList.add(new SelectOption('NONE','--- SELECT OBJECT ---'));
    	for(Schema.SObjectType objectNames : Schema.getGlobalDescribe().values())
    		if(objectNames.getDescribe().isAccessible() && objectNames.getDescribe().isCreateable() && objectNames.getDescribe().isQueryable())
    			oNameList.add(new SelectOption(objectNames.getDescribe().getName(),objectNames.getDescribe().getName()));
    	oNameList.sort();
    	objectNameList.addall(oNameList);
    }
    public List<SelectOption> getObjectNameList(){
    	return objectNameList;
    }
    public void setRecordSortOrderList(List<SelectOption> rSortOrderList){
    	rSortOrderList.add(new SelectOption('ASC','Ascending'));
    	rSortOrderList.add(new SelectOption('DESC','Descending'));
    	recordSortOrderList = rSortOrderList;
    	recordSortOrder='ASC';
    }
    public List<SelectOption> getRecordSortOrderList(){
    	return recordSortOrderList;
    }
    public void setRecordLimitList(List<SelectOption> rLimitList){
    	rLimitList.add(new SelectOption('500','500'));
    	rLimitList.add(new SelectOption('1000','1000'));
    	rLimitList.add(new SelectOption('5000','5000'));
    	rLimitList.add(new SelectOption('50000','50000'));
    	recordLimitList.addAll(rLimitList);
    	recordLimit = '500';
    }
    public List<SelectOption> getRecordLimitList(){
    	return recordLimitList;
    }
    public void setToSelectList(List<SelectOption> tSelect){
    	if(objectName != '' && objectName != 'NONE'){
    		Schema.SObjectType token = Schema.getGlobalDescribe().get(objectName);
	    	Schema.DescribeSObjectResult tokenDescribe = token.getDescribe();
    		for(Schema.SObjectField fieldName : tokenDescribe.fields.getMap().values())
    			if(fieldName.getDescribe().isAccessible() && fieldName.getDescribe().getType()!=Schema.DisplayType.address && fieldName.getDescribe().getType()!=Schema.DisplayType.base64 && fieldName.getDescribe().getType()!=Schema.DisplayType.DataCategoryGroupReference && fieldName.getDescribe().getType()!=Schema.DisplayType.EncryptedString)
    				tSelect.add(new SelectOption(fieldName.getDescribe().getName(),fieldName.getDescribe().getName()));
    		tSelect.sort();
    	}
    	toSelectList.addAll(tSelect);
    }
    public List<SelectOption> getToSelectList(){
    	return toSelectList;
    }
    public void setSelectedList(List<SelectOption> slected){
    	selectedList.addAll(slected);
    }
    public List<SelectOption> getSelectedList(){
    	return selectedList;
    }
    public void setOrderByList(List<SelectOption>  oByList){
    	if(objectName != '' && objectName != 'NONE'){
    		Schema.SObjectType token = Schema.getGlobalDescribe().get(objectName);
	    	Schema.DescribeSObjectResult tokenDescribe = token.getDescribe();
    		for(Schema.SObjectField fieldName : tokenDescribe.fields.getMap().values())
    			if(fieldName.getDescribe().isAccessible() && fieldName.getDescribe().getType()!=Schema.DisplayType.MultiPicklist && fieldName.getDescribe().getType()!=Schema.DisplayType.address && fieldName.getDescribe().getType()!=Schema.DisplayType.EncryptedString && fieldName.getDescribe().getType()!=Schema.DisplayType.TextArea && fieldName.getDescribe().getType()!=Schema.DisplayType.base64)
    				oByList.add(new SelectOption(fieldName.getDescribe().getName(),fieldName.getDescribe().getName()));
    		oByList.sort();
    	}
    	orderByList.add(new SelectOption('NONE','--- SELECT ORDER BY FIELD ---'));
    	orderByList.addAll(oByList);
    }
    public List<SelectOption> getOrderByList(){
    	return orderByList;
    }
    public String getSearchString(){
    	return searchString;
    }
    public void setSearchString(){
    	searchString='';
    	if(selectedList.size()>0 && objectName != null && objectName != 'NONE' && orderByField != null && orderByField != 'NONE' && recordLimit != null && recordLimit != 'NONE'){
    	String fieldString = '';
    	for(SelectOption option : selectedList){
    		if(fieldString != '')
    			fieldString += ',';
    		fieldString += option.getValue();
    	}
    	searchString = 'SELECT ' + fieldString + ' FROM ' + objectName + ' ORDER BY ' + orderByField + ' ' + recordSortOrder + ' NULLS LAST LIMIT ' + recordLimit;
    	}
    }
    public List<String> getFieldValues(){
    	return fieldValues;
    }
    public List<String> setFieldValues(){
    	for(SelectOption option : selectedList){
    		fieldValues.add(option.getValue());
    	}
    	System.debug(fieldValues);
    	return fieldValues;
    }
    
    public void setFieldAndOrderLists(){
    	toSelectList.clear();
    	selectedList.clear();
    	orderByList.clear();
    	setToSelectList(new List<SelectOption>());
    	setOrderByList(new List<SelectOption>());
    	setSearchString();
    }
    public PageReference add(){
    	for(String str : addFieldList){
    		Integer j;
    		for(Integer i = 0 ; i < toSelectList.size() ; i++){
    			if(toSelectList[i].getLabel()==str){
    				j=i;
    				break;
    			}
    		}
    		selectedList.add(toSelectList.get(j));
    		toSelectList.remove(j);
    	}
    	setSearchString();
    	return null;
    }
    public PageReference remove(){
    	for(String str : removeFieldList){
    		Integer j;
    		for(Integer i = 0 ; i < selectedList.size() ; i++){
    			if(selectedList[i].getLabel()==str){
    				j=i;
    				break;
    			}
    		}
    		toSelectList.add(selectedList.get(j));
    		selectedList.remove(j);
    	}
    	setSearchString();
    	return null;
    }
    public PageReference executeQuery(){
    	setSearchString();
    	fieldValues.clear();
    	setFieldValues();
    	if(searchString=='' || searchString==null)
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR , 'Please Select All Fields'));
    	else
    		sObjectList = Database.query(searchString);
    	return null;
    }
}