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

  PatientsLoaded({required this.patients});
}
