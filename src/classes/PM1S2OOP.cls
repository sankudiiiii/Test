public with sharing class PM1S2OOP extends PM1S2ParentOOP{
    Integer id;
    String name;
    public static Integer staticInteger = 0;
    
    public PM1S2OOP(){
        staticInteger++;
    }
    
    public PM1S2OOP(Integer id, String name) {
        this.id = id;
        this.name = name;
    }
    public override void changeID() {
        id=20;
    }
}
/*
PM1S2OOP oopObject = new PM1S2OOP(100,'Sanket');
System.debug(oopObject);

PM1S2OOP oopObject = new PM1S2OOP();
oopObject.changeID();
System.debug(oopObject);

PM1S2OOP oopObject1 = new PM1S2OOP();
PM1S2OOP oopObject2 = new PM1S2OOP();
PM1S2OOP oopObject3 = new PM1S2OOP();
System.debug(OOP.staticInteger);
*/