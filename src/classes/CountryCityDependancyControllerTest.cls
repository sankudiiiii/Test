@isTest
private class CountryCityDependancyControllerTest {
	@isTest public static void GetCountriesTest() {
		TestDataFactory.generateCountryCityTestData();
		CountryCityDependancyController controller = new CountryCityDependancyController();
		List<SelectOption> option = controller.getCountries();
		System.assertNotEquals(0 , option.size() , 'No test values for custom setting of country');
	}
	@isTest public static void GetCitiesPositiveTest() {
		TestDataFactory.generateCountryCityTestData();
		CountryCityDependancyController controller = new CountryCityDependancyController();
		controller.selectedCountry = 'India';
		List<SelectOption> option = controller.getCities();
		System.assertNotEquals(0 , option.size() , 'No test values for custom setting of city');
	}
	@isTest public static void GetCitiesNegativeTest() {
		TestDataFactory.generateCountryCityTestData();
		CountryCityDependancyController controller = new CountryCityDependancyController();
		controller.selectedCountry = 'France';
		List<SelectOption> option = controller.getCities();
		System.assertEquals(0 , option.size() , 'Test values for custom setting of country city');
	}
}