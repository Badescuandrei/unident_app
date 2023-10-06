class DoctorItem {
  final String name;
  final String job;
  final String imagePath;
  const DoctorItem({
    required this.name,
    required this.job,
    required this.imagePath,
  });
}

class Clinic {
  final String imagePath;
  final String clinicName;
  final String location;
  final String? nume;

  Clinic({required this.imagePath, required this.clinicName, required this.location, this.nume});
}
