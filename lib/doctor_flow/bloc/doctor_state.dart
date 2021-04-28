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

  PatientsLoaded({required this.patients, this.isValidDoctorInput = false});

  PatientsLoaded copyWith({required bool validInput}) {
    return PatientsLoaded(
        patients: this.patients, isValidDoctorInput: validInput);
  }

  @override
  List<Object> get props => [isValidDoctorInput];
}
