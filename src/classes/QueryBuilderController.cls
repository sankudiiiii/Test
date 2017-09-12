public with sharing class QueryBuilderController {
    public String objectName{get; set;}
    
    public List<String> fieldList{get; set;}
    public List<String> removeFieldList{get; set;}
    public List<SelectOption> toSelect;
    public List<SelectOption> selected{get; set;}
    public String searchString;
    
    public String recordLimit{get; set;}
    public String recordSortOrder{get; set;}
    
    public QueryBuilderController(){
    	objectName='';
    	fieldList = new List<String>();
    	toSelect = new List<SelectOption>();
    	selected = new List<SelectOption>();
    	searchString='';
    }
    public QueryBuilderController(ApexPages.StandardController controller){
    	objectName='';
    	fieldList = new List<String>();
    	toSelect = new List<SelectOption>();
    	selected = new List<SelectOption>();
    	searchString='';
    }
    public List<SelectOption> getObjectNameList(){
    	List<SelectOption> objectNameOptionList = new List<SelectOption>();
    	List<SelectOption> objectNameOptionList1 = new List<SelectOption>();
    	objectNameOptionList.add(new SelectOption('NONE','--- SELECT OBJECT ---'));
    	for(Schema.SObjectType objectNames : Schema.getGlobalDescribe().values())
    		if(objectNames.getDescribe().isAccessible() && objectNames.getDescribe().isCreateable() && objectNames.getDescribe().isQueryable())
    			objectNameOptionList1.add(new SelectOption(objectNames.getDescribe().getName(),objectNames.getDescribe().getName()));
    	objectNameOptionList1.sort();
    	objectNameOptionList.addall(objectNameOptionList1);
    	objectName=objectNameOptionList[0].getValue();
    	return objectNameOptionList;
    }
    
    
    
    
    
    
    
    
    
    
    public List<SelectOption> getToSelect(){
    	return toSelect;
    }
    public void setToSelect(){
    	if(objectName != '' && objectName != 'NONE'){
    		Schema.SObjectType token = Schema.getGlobalDescribe().get(objectName);
	    	Schema.DescribeSObjectResult tokenDescribe = token.getDescribe();
    		for(Schema.SObjectField fieldName : tokenDescribe.fields.getMap().values())
    			if(fieldName.getDescribe().isAccessible())
    				toSelect.add(new SelectOption(fieldName.getDescribe().getName(),fieldName.getDescribe().getName()));
    		toSelect.sort();
    	}
    	fieldList=new List<String>();
    }
    public PageReference add(){
    	for(String str : fieldList){
    		Integer j;
    		for(Integer i = 0 ; i < toSelect.size() ; i++){
    			if(toSelect[i].getLabel()==str){
    				j=i;
    				break;
    			}
    		}
    		selected.add(toSelect.get(j));
    		toSelect.remove(j);
    	}
    	System.debug(fieldList);
    	return null;
    }
    
    
    
    
    
    
    
    
    
    public List<SelectOption> getRecordLimitList(){
    	List<SelectOption> recordLimitList = new List<SelectOption>();
    	recordLimitList.add(new SelectOption('NONE','--- SELECT LIMIT ---'));
    	recordLimitList.add(new SelectOption('500','500'));
    	recordLimitList.add(new SelectOption('1000','1000'));
    	recordLimitList.add(new SelectOption('5000','5000'));
    	recordLimitList.add(new SelectOption('50000','50000'));
    	return recordLimitList;
    }
    public List<SelectOption> getRecordSortOrderList(){
    	List<SelectOption> recordSortOrderList = new List<SelectOption>();
    	recordSortOrderList.add(new SelectOption('ASC','Ascending'));
    	recordSortOrderList.add(new SelectOption('DESC','Descending'));
    	recordSortOrder='ASC';
    	return recordSortOrderList;
    }
    public String getSearchString(){
    	if(fieldList.size()>0)
    		searchString='asdksjadhjsa hdfj ahs';
    	return searchString;
    }
    public PageReference executeQuery(){
    	
    	return null;
    }
}