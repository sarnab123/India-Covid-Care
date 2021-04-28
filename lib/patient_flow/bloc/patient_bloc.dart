import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:india_covid_care/patient_flow/conditions/model/condition_information.dart';
import 'package:india_covid_care/patient_flow/information/model/age.dart';
import 'package:india_covid_care/patient_flow/information/model/name_language_location.dart';
import 'package:india_covid_care/patient_flow/information/model/patient_information_model.dart';
import 'package:india_covid_care/patient_flow/information/model/phone_number.dart';
import 'package:india_covid_care/patient_flow/repository/patient_repository.dart';
import 'package:india_covid_care/patient_flow/symptoms/model/symptom_information.dart';
import 'package:india_covid_care/patient_flow/symptoms/view/symptoms_checkbox.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(PatientEditing());

  final SymptomInformation _symptomInformation = SymptomInformation();
  final ConditionInformation _conditionInformation = ConditionInformation();
  final PatientRepository repo = PatientRepository();

  DateTime? firstShot;
  DateTime? secondShot;

  @override
  Stream<PatientState> mapEventToState(
    PatientEvent event,
  ) async* {
    if (event is TemperatureUpdated) {
      _symptomInformation.temperature = event.value;
    } else if (event is SymptomToggled) {
      _handleSymptomCheckboxUpdate(event.type, event.value);
    } else if (event is ConditionToggled) {
      _handleConditionCheckboxUpdate(event.type, event.value);
    } else if (event is TemperatureUpdated) {
      _symptomInformation.temperature = event.value;
    } else if (event is PatientInformationFieldUpdated) {
      yield* _mapPatientInfoUpdateToState(event, state as PatientEditing);
    } else if (event is PatientInformationSubmitted) {
      yield* _mapSubmittedToState(event, state as PatientEditing);
    } else if (event is VaccineToggled) {
      yield (state as PatientEditing).copyWith(newVaccine: event.value);
    } else if (event is VaccineDateSelected) {
      if (event.isFirstShot) {
        firstShot = event.newDate;
      } else {
        secondShot = event.newDate;
      }
    }
  }

  Stream<PatientState> _mapSubmittedToState(
      PatientInformationSubmitted event, PatientEditing state) async* {
    try {
      final resp = await repo.saveDetails(state, _symptomInformation,
          _conditionInformation, firstShot, secondShot);
      yield state.copyWith(apiSuccess: true);
    } catch (error) {
      yield state.copyWith(apiError: true);
    }
  }

  Stream<PatientState> _mapPatientInfoUpdateToState(
      PatientInformationFieldUpdated event, PatientEditing state) async* {
    switch (event.type) {
      case PatientInformationFields.age:
        final age = Age.dirty(event.value);
        yield state.copyWith(
            newAge: age,
            newStatus: Formz.validate([
              age,
              state.language,
              state.location,
              state.name,
              state.number
            ]));
        return;
      case PatientInformationFields.language:
        final lang = NameLanguageLocation.dirty(event.value);
        yield state.copyWith(
            newLang: lang,
            newStatus: Formz.validate(
                [state.age, lang, state.location, state.name, state.number]));
        return;
      case PatientInformationFields.location:
        final loc = NameLanguageLocation.dirty(event.value);
        yield state.copyWith(
            newLoc: loc,
            newStatus: Formz.validate(
                [state.age, state.language, loc, state.name, state.number]));
        return;
      case PatientInformationFields.name:
        final name = NameLanguageLocation.dirty(event.value);
        yield state.copyWith(
            newName: name,
            newStatus: Formz.validate([
              state.age,
              state.language,
              state.location,
              name,
              state.number
            ]));
        return;
      case PatientInformationFields.number:
        final num = PhoneNumber.dirty(event.value);
        yield state.copyWith(
            newPhone: num,
            newStatus: Formz.validate(
                [state.age, state.language, state.location, state.name, num]));
        return;
    }
  }

  _handleSymptomCheckboxUpdate(SymptomQuestionaireType type, bool value) {
    switch (type) {
      case SymptomQuestionaireType.breathing:
        _symptomInformation.hasShortnessOfBreah = value;
        return;
      case SymptomQuestionaireType.chestPain:
        _symptomInformation.hasChestPain = value;
        return;
      case SymptomQuestionaireType.confused:
        _symptomInformation.hasConfusion = value;
        return;
      case SymptomQuestionaireType.cough:
        _symptomInformation.hasCough = value;
        return;
      case SymptomQuestionaireType.diarrhea:
        _symptomInformation.hasDiarrhea = value;
        return;
      case SymptomQuestionaireType.fatigue:
        _symptomInformation.hasFatigue = value;
        return;
      case SymptomQuestionaireType.fever:
        return;
      case SymptomQuestionaireType.lossSense:
        _symptomInformation.hasLossOfSmellOrTaste = value;
        return;
      case SymptomQuestionaireType.nausea:
        _symptomInformation.hasNauseaOrVomitting = value;
        return;
      case SymptomQuestionaireType.skin:
        _symptomInformation.hasSkinProblem = value;
        return;
      case SymptomQuestionaireType.throat:
        _symptomInformation.hasSoreThroat = value;
        return;
    }
  }

  _handleConditionCheckboxUpdate(ConditionType type, bool value) {
    switch (type) {
      case ConditionType.age:
        _conditionInformation.over50 = value;
        return;
      case ConditionType.cancer:
        _conditionInformation.hasCancer = value;
        return;
      case ConditionType.dementia:
        _conditionInformation.hasDementia = value;
        return;
      case ConditionType.diabetes:
        _conditionInformation.hasDiabetes = value;
        return;
      case ConditionType.heart:
        _conditionInformation.hasHeartDisease = value;
        return;
      case ConditionType.hypertension:
        _conditionInformation.hasHypertension = value;
        return;
      case ConditionType.kidney:
        _conditionInformation.hasKidneyDisease = value;
        return;
      case ConditionType.liver:
        _conditionInformation.hasLiverDisease = value;
        return;
      case ConditionType.lung:
        _conditionInformation.hasLungDisease = value;
        return;
      case ConditionType.marrow:
        _conditionInformation.hasBoneMarrowOrOrganTransplant = value;
        return;
      case ConditionType.obese:
        _conditionInformation.isObese = value;
        return;
      case ConditionType.storke:
        _conditionInformation.hasStroke = value;
        return;
    }
  }
}
