public with sharing class PM1S1OOP extends PM1S1ParentOOP{
    public PM1S1OOP(){
    	System.debug('Default Constructor');
    }
    
    public Integer calculator(String operator, Integer input1,Integer input2){
    	if(operator=='SUM')
    		return input1+input2;
    	else if(operator=='SUB')
    		return input1-input2;
    	else if(operator=='MUL')
    		return input1*input2;
    	else if(operator=='DIV')
    		return input1/input2;
    	else
    		return 0;
    }
    
    public override void sayHi(){
    	System.debug('Hi');
    }
}
/*
PM1S1OOP pm = new PM1S1OOP();

System.debug(pm.calculator('SUM',3,2));
System.debug(pm.calculator('SUB',3,2));
System.debug(pm.calculator('MUL',3,2));
System.debug(pm.calculator('DIV',3,2));
System.debug(pm.calculator('S',3,2));

pm.sayHi();
*/