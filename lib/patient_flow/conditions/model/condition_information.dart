class ConditionInformation {
  bool over50 = false;
  bool hasDiabetes = false;
  bool hasHypertension = false;
  bool hasHeartDisease = false;
  bool hasLiverDisease = false;
  bool isObese = false;
  bool hasBoneMarrowOrOrganTransplant = false;
  bool hasLungDisease = false;
  bool hasCancer = false;
  bool hasKidneyDisease = false;
  bool hasStroke = false;
  bool hasDementia = false;
}

enum ConditionType {
  age,
  diabetes,
  hypertension,
  heart,
  liver,
  obese,
  marrow,
  lung,
  cancer,
  kidney,
  storke,
  dementia
}

extension CategoryString on ConditionType {
  String get string {
    switch (this) {
      case ConditionType.age:
        return "Age > 50 years";
      case ConditionType.cancer:
        return "Cancer";
      case ConditionType.dementia:
        return "Dementia";
      case ConditionType.diabetes:
        return "Diabetes";
      case ConditionType.heart:
        return "Heart Disease";
      case ConditionType.hypertension:
        return "Hypertensions";
      case ConditionType.kidney:
        return "Kidney Diseases";
      case ConditionType.liver:
        return "Liver Disease";
      case ConditionType.lung:
        return "Lung Disease";
      case ConditionType.marrow:
        return "Bone Marrow or Organ transplant";
      case ConditionType.obese:
        return "Overweight or Obese";
      case ConditionType.storke:
        return "Stroke";
    }
  }
}
