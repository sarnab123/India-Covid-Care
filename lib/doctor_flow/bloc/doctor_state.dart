part of 'doctor_bloc.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class PatientsLoaded extends DoctorState {
  final List<PatientDetails> patients;
  bool isValidDoctorInput;
  bool cannotOpenWhatsapp;

  PatientsLoaded(
      {required this.patients,
      this.isValidDoctorInput = false,
      this.cannotOpenWhatsapp = false});

  PatientsLoaded copyWith({required bool validInput, bool? connectWhatsapp}) {
    return PatientsLoaded(
        patients: this.patients,
        isValidDoctorInput: validInput,
        cannotOpenWhatsapp: connectWhatsapp ?? false);
  }

  @override
  List<Object> get props => [isValidDoctorInput, cannotOpenWhatsapp, patients];
}
