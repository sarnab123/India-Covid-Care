part of 'patient_bloc.dart';

@immutable
abstract class PatientEvent {}

class SymptomToggled extends PatientEvent {
  final SymptomQuestionaireType type;
  final bool value;

  SymptomToggled({required this.type, required this.value});
}

class TemperatureUpdated extends PatientEvent {
  final double value;

  TemperatureUpdated({required this.value});
}

class ConditionToggled extends PatientEvent {
  final ConditionType type;
  final bool value;

  ConditionToggled({required this.type, required this.value});
}

class PatientInformationFieldUpdated extends PatientEvent {
  final PatientInformationFields type;
  final String value;

  PatientInformationFieldUpdated({required this.type, required this.value});
}

class PatientInformationSubmitted extends PatientEvent {}

class VaccineToggled extends PatientEvent {
  final bool value;

  VaccineToggled({required this.value});
}

class VaccineDateSelected extends PatientEvent {
  final DateTime newDate;
  final bool isFirstShot;

  VaccineDateSelected({required this.newDate, required this.isFirstShot});
}
