import 'dart:developer';

import 'package:india_covid_care/network/base_api_manager.dart';
import 'package:india_covid_care/network/patient_details.dart';
import 'package:india_covid_care/patient_flow/bloc/patient_bloc.dart';
import 'package:india_covid_care/patient_flow/conditions/model/condition_information.dart';
import 'package:india_covid_care/patient_flow/symptoms/model/symptom_information.dart';

class PatientRepository {
  final BaseAPIManager apiClient = BaseAPIManager();

  Future<void> saveDetails(PatientEditing info, SymptomInformation sympInfo,
      ConditionInformation condInfo) async {
    final Map<String, dynamic> patientDetails = PatientDetails(
            name: info.name.value,
            location: info.location.value,
            number: info.number.value,
            age: int.parse(info.age.value),
            symptoms: _createSymptomList(sympInfo),
            highPriority: _determineIsHighPriority(sympInfo),
            language: info.language.value,
            existingCondition: _createExistingConditionList(condInfo))
        .toJson();
    log('HERE IS THE DTO: $patientDetails');
    final resp = await apiClient.post(
        CovidCareEndpoints.savePatient, patientDetails, null);
    print('HERE IS THE RESPONSE: $resp');
    return Future.value();
  }

  bool _determineIsHighPriority(SymptomInformation info) {
    return info.hasShortnessOfBreah ||
        info.hasChestPain ||
        info.hasConfusion ||
        info.hasSkinProblem;
  }

  String _createExistingConditionList(ConditionInformation info) {
    List<String> conditionList = [];
    if (info.hasBoneMarrowOrOrganTransplant) {
      conditionList.add(ConditionType.marrow.string);
    }
    if (info.hasCancer) {
      conditionList.add(ConditionType.cancer.string);
    }
    if (info.hasDementia) {
      conditionList.add(ConditionType.dementia.string);
    }
    if (info.hasDiabetes) {
      conditionList.add(ConditionType.diabetes.string);
    }
    if (info.hasHeartDisease) {
      conditionList.add(ConditionType.heart.string);
    }
    if (info.hasHypertension) {
      conditionList.add(ConditionType.hypertension.string);
    }
    if (info.hasKidneyDisease) {
      conditionList.add(ConditionType.kidney.string);
    }
    if (info.hasLiverDisease) {
      conditionList.add(ConditionType.liver.string);
    }
    if (info.hasLungDisease) {
      conditionList.add(ConditionType.lung.string);
    }
    if (info.hasStroke) {
      conditionList.add(ConditionType.storke.string);
    }
    if (info.isObese) {
      conditionList.add(ConditionType.obese.string);
    }
    if (info.over50) {
      conditionList.add(ConditionType.age.string);
    }
    final String concat = conditionList.join(";");
    log('HERE IS CONCATENATED: $concat');
    return conditionList.join(";");
  }

  String _createSymptomList(SymptomInformation info) {
    List<String> symptomList = [];
    symptomList.add('fever${info.temperature.toStringAsFixed(1)}');
    if (info.hasChestPain) {
      symptomList.add(SymptomQuestionaireType.chestPain.string);
    }
    if (info.hasConfusion) {
      symptomList.add(SymptomQuestionaireType.confused.string);
    }
    if (info.hasCough) {
      symptomList.add(SymptomQuestionaireType.cough.string);
    }
    if (info.hasDiarrhea) {
      symptomList.add(SymptomQuestionaireType.diarrhea.string);
    }
    if (info.hasFatigue) {
      symptomList.add(SymptomQuestionaireType.fatigue.string);
    }
    if (info.hasLossOfSmellOrTaste) {
      symptomList.add(SymptomQuestionaireType.lossSense.string);
    }
    if (info.hasNauseaOrVomitting) {
      symptomList.add(SymptomQuestionaireType.nausea.string);
    }
    if (info.hasShortnessOfBreah) {
      symptomList.add(SymptomQuestionaireType.breathing.string);
    }
    if (info.hasSkinProblem) {
      symptomList.add(SymptomQuestionaireType.skin.string);
    }
    if (info.hasSoreThroat) {
      symptomList.add(SymptomQuestionaireType.throat.string);
    }
    return symptomList.join(";");
  }
}
