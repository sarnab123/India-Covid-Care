import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:india_covid_care/doctor_flow/repository/doctor_repository.dart';
import 'package:india_covid_care/network/patient_details.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorInitial());

  final DoctorRepository repo = DoctorRepository();

  @override
  Stream<DoctorState> mapEventToState(
    DoctorEvent event,
  ) async* {
    if (event is FetchPatients) {
      yield* _mapFetchPatientsToState(event, state);
    } else if (event is MarkPatientAsCompleted) {
      yield* _mapMarkPatientCompleteToState(event, state);
    }
  }

  Stream<DoctorState> _mapMarkPatientCompleteToState(
      MarkPatientAsCompleted event, DoctorState state) async* {
    yield DoctorLoading();
    try {
      await repo.markAsCompleted(event.id);
      add(FetchPatients());
    } catch (error) {
      // Handle error state
    }
  }

  Stream<DoctorState> _mapFetchPatientsToState(
      FetchPatients event, DoctorState state) async* {
    yield DoctorLoading();
    try {
      final patients = await repo.getPatients();
      print('Here are patients: $patients');
      yield PatientsLoaded(patients: patients);
    } catch (error) {
      // Handle error state
    }
  }
}
