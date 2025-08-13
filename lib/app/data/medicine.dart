class Medicine {
  final String name;
  final String dose;
  final String route;
  final String description;
  final List<String> timings;
  final int tablets;
  final double progress;
  final int daysLeft;
  final String imagePath;
  final String frequency;
  final String doctorName;

  Medicine({
    required this.name,
    required this.dose,
    required this.route,
    required this.description,
    required this.timings,
    required this.tablets,
    required this.progress,
    required this.daysLeft,
    required this.imagePath,
    required this.frequency,
    required this.doctorName,
  });
}

List<Medicine> medicines = [
  Medicine(
    name: "Aspirin 100 mg",
    dose: "3",
    route: "oral",
    description: "Blood thinner",
    timings: ["10:00", "16:00", "24:00"],
    tablets: 3,
    progress: 0.5,
    daysLeft: 12,
    imagePath: "assets/images/medicine_1.png",
    frequency: "OD",
    doctorName: 'Dr. Ahmed Khaled',
  ),
  Medicine(
    name: "Ibuprofen 200 mg",
    dose: "3",
    route: "oral",
    description: "Anti-inflammatory",
    timings: ["10:00", "16:00", "24:00"],
    tablets: 3,
    progress: 0.5,
    daysLeft: 12,
    imagePath: "assets/images/medicine_1.png",
    frequency: "OD",
    doctorName: 'Dr. Ahmed Khaled',
  ),
  Medicine(
    name: "Paracetamol 500 mg",
    dose: "3",
    route: "oral",
    description: "Blood thinner",
    timings: ["10:00", "16:00", "24:00"],
    tablets: 3,
    progress: 0.5,
    daysLeft: 12,
    imagePath: "assets/images/medicine_1.png",
    frequency: "OD",
    doctorName: 'Dr. Ahmed Khaled',
  ),
];
