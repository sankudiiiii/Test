public with sharing class PM1S3Basic {
    public void fibonacci(Integer i){
    	list<Integer> integerList = new list<Integer>();
    	integerList.add(0);
    	integerList.add(1);
    	while((integerList[integerList.size()-1]+integerList[integerList.size()-2])<i){
    		integerList.add(integerList[integerList.size()-1]+integerList[integerList.size()-2]);
    	}
    	System.debug(integerList);
    }
    
    public void reverseString(String str){
    	System.debug(str.reverse());
    }
    
    public void fibonacciIndex(Integer i){
    	list<Integer> integerList = new list<Integer>();
    	integerList.add(0);
    	integerList.add(1);
    	while(integerList.size()<i){
    		integerList.add(integerList[integerList.size()-1]+integerList[integerList.size()-2]);
    	}
    	System.debug(integerList);
    }
    
    public void stringOperations(String str){
    	str = str.replace('@','A');
    	System.debug(str);
    	String substr = 'Apex Programming';
    	Integer i = str.indexOf(substr);
    	if(i!=-1){
    		System.debug(str.substring(i,i+substr.length()));
    	}
    	List<String> splitstr = str.split(' ');
    	System.debug(splitstr);
    	System.debug(str.deletewhiteSpace());
    	System.debug(str.touppercase());
    	System.debug(str.tolowercase());
    }
    
    public void countCharacters(String str){
    	Map<String,Integer> countMap = new Map<String,Integer>();
    	for(Integer i = 0; i<str.length();i++){
    		if(countMap.containsKey(str.subString(i,i+1))){
    			countMap.put(str.subString(i,i+1),countMap.get(str.subString(i,i+1))+1);
    		}
    		else{
    			countMap.put(str.subString(i,i+1),1);
    		}
    	}
    	for(String character : countMap.keySet()){
    		System.debug(character+' '+countMap.get(character));
    	}
    }
}
/*
PM1S3Basic pm = new PM1S3Basic();
pm.fibonacci(30);

pm.reverseString('abc');

pm.fibonacciIndex(5);

pm.stringOperations('Welcome to @pex Programming');

pm.countCharacters('Welcome to @pex Programming');
*/