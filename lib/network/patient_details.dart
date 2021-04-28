class PatientDetails {
  final String? name;
  final String? location;
  final String? number;
  final int? age;
  final String? symptoms;
  final bool? highPriority;
  final String? language;
  final String? existingCondition;

  String? id;
  bool? attended;

  String doctorName;
  String doctorLocation;
  final bool? vaccineTaken;
  final String? vaccine1Date;
  final String? vaccine2Date;

  PatientDetails(
      {required this.name,
      required this.location,
      required this.number,
      required this.age,
      required this.symptoms,
      required this.highPriority,
      required this.language,
      required this.existingCondition,
      this.doctorName = "",
      this.doctorLocation = "",
      this.id,
      this.vaccine1Date,
      this.vaccineTaken,
      this.vaccine2Date,
      this.attended});

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
        name: json['name'],
        location: json['location'],
        number: json['number'],
        age: json['age'],
        symptoms: json['symptoms'],
        highPriority: json['highPriority'],
        language: json['language'],
        existingCondition: json['existingCondition'],
        attended: json['attended'],
        doctorName: json['doctor'] ?? "",
        doctorLocation: json['doctorLocation'] ?? "",
        vaccineTaken: json['vaccineTaken'],
        vaccine1Date: json['vaccine1Date'],
        vaccine2Date: json['vaccine2Date'],
        id: json['_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'location': this.location,
      'number': this.number,
      'age': this.age,
      'symptoms': this.symptoms,
      'highPriority': this.highPriority,
      'language': this.language,
      'existingCondition': this.existingCondition
    };
  }
}
