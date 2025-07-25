class UserProfile {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String idNumber;
  final String country;
  final String city;
  final String address;
  final DateTime dateOfBirth;
  final String gender;
  final int age;
  final String race;
  final double weight;
  final double height;
  final double bsa;
  final double bmi;
  final String maritalStatus;
  final String language;

  UserProfile({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.idNumber,
    required this.country,
    required this.city,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
    required this.age,
    required this.race,
    required this.weight,
    required this.height,
    required this.bsa,
    required this.bmi,
    required this.maritalStatus,
    required this.language,
  });
}

final fakeUser = UserProfile(
  firstName: "Ahmed",
  lastName: "Ali",
  phoneNumber: "+971501234567",
  email: "ahmed.ali@gmail.com",
  idNumber: "123456789",
  country: "UAE",
  city: "Dubai",
  address: "Downtown, Business Bay",
  dateOfBirth: DateTime(1995, 4, 10),
  gender: "Male",
  age: 29,
  race: "Arab",
  weight: 75.0,
  height: 180.0,
  bsa: 1.9,
  bmi: 23.1,
  maritalStatus: "Single",
  language: "English",
);
