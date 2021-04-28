part of 'doctor_bloc.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class FetchPatients extends DoctorEvent {}

class MarkPatientAsCompleted extends DoctorEvent {
  final String id;
  MarkPatientAsCompleted({required this.id});
}

class DoctorInformationUpdated extends DoctorEvent {
  final String value;
  final DoctorInformationFields type;

  DoctorInformationUpdated({required this.value, required this.type});
}

class DoctorInitiatedCall extends DoctorEvent {
  final String id;
  final String number;

  DoctorInitiatedCall({required this.id, required this.number});
}
