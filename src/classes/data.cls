public with sharing class data {
    public String status{get; set;}
    public distance distance{get; set;}
    public duration duration{get; set;}
    public class distance {
    	public String text{get; set;}
    	public Decimal value{get; set;}
    }
    public class duration {
    	public String text{get; set;}
    	public Decimal value{get; set;}
    }
}