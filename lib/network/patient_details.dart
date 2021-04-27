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

  PatientDetails(
      {required this.name,
      required this.location,
      required this.number,
      required this.age,
      required this.symptoms,
      required this.highPriority,
      required this.language,
      required this.existingCondition,
      this.id,
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
