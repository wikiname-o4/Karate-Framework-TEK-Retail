package data;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

import net.datafaker.Faker;

public class DataGenerator {
	public static String getEmail() {
		Faker faker = new Faker();
		return faker.name().firstName() + faker.name().lastName() + "@gmail.com";
	}

	public static String getCompanyName() {
		Faker faker = new Faker();
		return faker.company().name();

	}

	public static String getFirstName() {
		Faker faker = new Faker();
		return faker.name().firstName();

	}

	public static String getLastName() {
		Faker faker = new Faker();
		return faker.name().lastName();
	}

	public static String getFullName() {
		Faker faker = new Faker();
		return faker.name().fullName();
	}

	public static String getTitle() {
		Faker faker = new Faker();
		return faker.name().prefix().toUpperCase();
	}

	public static String getPhoneNumber() {
		Faker faker = new Faker();
		return faker.phoneNumber().cellPhone();
	}

	public static String getPhoneExtension() {
		Faker faker = new Faker();
		return faker.phoneNumber().extension();
	}

	public static String getDateOfBirth() {
		Faker faker = new Faker();
		Date date = faker.date().birthday();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(date);
	}

	public static String getGender() {
		Faker faker = new Faker();
		return faker.dog().gender().toUpperCase();
	}

	public static String getEmploymentStatus() {
		Faker faker = new Faker();
		return faker.job().position();
	}

	public static String getMaritalStatus() {
		ArrayList<String> maritalStatus = new ArrayList<String>();
		maritalStatus.add("SINGLE");
		maritalStatus.add("MARRIED");
		maritalStatus.add("DIVORCED");
		maritalStatus.add("WIDOW");
		maritalStatus.add("WIDOWER");
		Collections.shuffle(maritalStatus);
		return maritalStatus.get(0);
	}

	public static String getCountryCode() {
		Faker faker = new Faker();
		return faker.address().countryCode();
	}

	public static String getPostalCode() {
		Faker faker = new Faker();
		return faker.address().zipCode();

	}

	public static String getState() {
		Faker faker = new Faker();
		return faker.address().state();
	}

	public static String getStreetAddress() {
		Faker faker = new Faker();
		return faker.address().streetAddress();
	}

	public static String getCity() {
		Faker faker = new Faker();
		return faker.address().cityName();
	}

	public static String getFullAddress() {
		Faker faker = new Faker();
		return faker.address().fullAddress();
	}

	public static String getCarMake() {
		Faker faker = new Faker();
		return faker.vehicle().make();
	}

	public static String getCarModel() {
		Faker faker = new Faker();
		return faker.vehicle().model();
	}

	public static String getCarLicensePlate() {
		Faker faker = new Faker();
		return faker.vehicle().licensePlate();
	}

	public static String getCardNumber() {
		return "46476348" + new java.text.SimpleDateFormat("ddHHmmss").format(new java.util.Date());
	}
}
