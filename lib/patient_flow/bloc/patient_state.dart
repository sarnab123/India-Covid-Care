part of 'patient_bloc.dart';

@immutable
abstract class PatientState extends Equatable {}

class PatientInitial extends PatientState {
  @override
  List<Object> get props => [];
}

class PatientEditing extends PatientState {
  final NameLanguageLocation name;
  final NameLanguageLocation language;
  final NameLanguageLocation location;
  final FormzStatus status;
  final Age age;
  final PhoneNumber number;

  bool apiSuccess = false;
  bool apiError = false;

  PatientEditing(
      {this.name = const NameLanguageLocation.pure(),
      this.language = const NameLanguageLocation.pure(),
      this.location = const NameLanguageLocation.pure(),
      this.number = const PhoneNumber.pure(),
      this.age = const Age.pure(),
      this.apiSuccess = false,
      this.apiError = false,
      this.status = FormzStatus.invalid});

  PatientEditing copyWith(
      {NameLanguageLocation? newName,
      NameLanguageLocation? newLang,
      NameLanguageLocation? newLoc,
      Age? newAge,
      bool? apiSuccess,
      bool? apiError,
      FormzStatus? newStatus,
      PhoneNumber? newPhone}) {
    return PatientEditing(
        name: newName ?? this.name,
        age: newAge ?? this.age,
        location: newLoc ?? this.location,
        number: newPhone ?? this.number,
        status: newStatus ?? this.status,
        apiSuccess: apiSuccess ?? false,
        apiError: apiError ?? false,
        language: newLang ?? this.language);
  }

  @override
  List<Object> get props =>
      [name, language, location, status, age, number, apiError, apiSuccess];
}
