public with sharing class JSONWrapperDemo {
    public String[] destination_addresses{get; set;}
    public String[] origin_addresses{get; set;}
    public String status{get; set;}
    public elements[] rows{get; set;}
    public class elements {
    	public data[] elements{get; set;}
    }
}