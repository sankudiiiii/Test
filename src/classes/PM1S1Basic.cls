public with sharing class PM1S1Basic {
    public void evenOdd(Integer i){
    	if(Math.mod(i,2)==0)
    		System.debug(i+' is Even');
    	else
    		System.debug(i+' is Odd');
    }
    
    public void arrayOfSize(Integer i){
    	String [] stringArray = new String[i];
    	System.debug(stringArray.size());
    }
    
    public void integerArrayOperations(Integer[] integerArray){
    	Integer max = 0,min = 0;
    	Map<Integer,Integer> integerMap = new Map<Integer,Integer>();
    	for(Integer i = 0; i<integerArray.size()-1;i++){
    		for(Integer j = 0; j<integerArray.size()-1;j++){
    			if(integerArray[j]>integerArray[j+1]){
    				Integer temp = integerArray[j];
    				integerArray[j] = integerArray[j+1];
    				integerArray[j+1] = temp;
    			}
    		}
    	}
    	System.debug('Ascending Order : '+integerArray);
    	for(Integer i = 0; i<integerArray.size()-1;i++){
    		for(Integer j = 0; j<integerArray.size()-1;j++){
    			if(integerArray[j]<integerArray[j+1]){
    				Integer temp = integerArray[j];
    				integerArray[j] = integerArray[j+1];
    				integerArray[j+1] = temp;
    			}
    		}
    	}
    	System.debug('Descending Order : '+integerArray);    	
    	for(Integer j = 0; j<integerArray.size();j++){
    			if(integerArray[j]>max)
    				max = integerArray[j];
    		}
    	System.debug('Maximum Number : '+max);
    	min=max;
    	for(Integer j = 0; j<integerArray.size();j++){
    			if(integerArray[j]<min)
    				min = integerArray[j];
    		}
    	System.debug('Minimum Number : '+min);
    	for(Integer i : integerArray){
    		if(integerMap.containsKey(i)){
    			integerMap.put(i,integerMap.get(i)+1);
    		}
    		else{
    			integerMap.put(i,1);
    		}
    	}
    	System.debug('Occurrences : '+integerMap);
    }
    
    public void summation(Integer i){
    	Integer sum=0;
    	for(Integer j=0;j<=i;j++){
    		sum +=j;
    	}
    	System.debug(sum);
    }
    
    public void calculateSimpleInterest(Decimal p, Integer n,Decimal r){
    	Decimal interest = p*n*r/100;
    	System.debug(interest);
    }
}
/*
PM1S1Basic pm = new PM1S1Basic();
pm.evenOdd(55);

pm.arrayOfSize(8);

Integer[] ia = new list<Integer>();
ia.add(2);
ia.add(1);
ia.add(-3);
ia.add(-3);
pm.integerArrayOperations(ia);

pm.summation(10);

pm.calculateSimpleInterest(10000,2,3);
*/