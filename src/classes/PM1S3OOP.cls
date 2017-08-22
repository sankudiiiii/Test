public with sharing class PM1S3OOP extends PM1S3ParentOOP{
	public Integer i=10;
	public String str='String';
    public void printHelloWorld(){
    	System.debug('Hello World');
    }
    public override void sayHi(){
    	System.debug('Hi');
    }
    public void callStaticMethod(){
    	PM1S3ParentOOP.staticMethod();
    }
}
/*
PM1S3OOP pm = new PM1S3OOP();
pm.callStaticMethod();

pm.printHelloWorld();

System.debug(pm.i);
System.debug(pm.str);

pm.sayHi();
*/