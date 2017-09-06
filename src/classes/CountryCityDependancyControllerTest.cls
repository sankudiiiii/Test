@isTest
private class CountryCityDependancyControllerTest {
	@isTest public static void GetCountriesTest(){
		TestDataFactory.generateCountryCityTestData();
		CountryCityDependancyController pm = new CountryCityDependancyController();
		list<selectoption> so = pm.getCountries();
		System.assertNotEquals(0,so.size(),'No test values for custom setting of country');
	}
	@isTest public static void GetCitiesPositiveTest(){
		TestDataFactory.generateCountryCityTestData();
		CountryCityDependancyController pm = new CountryCityDependancyController();
		pm.c1='India';
		list<selectoption> so = pm.getCities();
		System.assertNotEquals(0,so.size(),'No test values for custom setting of country');
	}
	@isTest public static void GetCitiesNegativeTest(){
		TestDataFactory.generateCountryCityTestData();
		CountryCityDependancyController pm = new CountryCityDependancyController();
		pm.c1='France';
		list<selectoption> so = pm.getCities();
		System.assertEquals(0,so.size(),'No test values for custom setting of country');
	}
}