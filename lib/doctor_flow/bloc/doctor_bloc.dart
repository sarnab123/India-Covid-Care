import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:india_covid_care/doctor_flow/model/doctor_information.dart';
import 'package:india_covid_care/doctor_flow/repository/doctor_repository.dart';
import 'package:india_covid_care/network/patient_details.dart';
import 'package:url_launcher/url_launcher.dart';

part 'doctor_event.dart';
part 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorInitial());

  final DoctorRepository repo = DoctorRepository();
  final DoctorInformation info = DoctorInformation();

  @override
  Stream<DoctorState> mapEventToState(
    DoctorEvent event,
  ) async* {
    if (event is FetchPatients) {
      yield* _mapFetchPatientsToState(event, state);
    } else if (event is MarkPatientAsCompleted) {
      yield* _mapMarkPatientCompleteToState(event, state);
    } else if (event is DoctorInformationUpdated) {
      if (event.type == DoctorInformationFields.location) {
        info.location = event.value;
      } else {
        info.name = event.value;
      }
      final PatientsLoaded s = state as PatientsLoaded;
      yield s.copyWith(
          validInput: info.location.length >= 2 && info.name.length > 3);
    } else if (event is DoctorInitiatedCall) {
      try {
        await repo.postDoctorCall(
            info.name, info.location, event.id, event.number);
        launch("whatsapp://send?phone=+91${event.number}");
      } catch (error) {
        print('Error with Doctor Initiated Call: $error');
      }
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
