class SymptomInformation {
  double temperature = 98.6;
  bool hasChestPain = false;
  bool hasConfusion = false;
  bool hasFatigue = false;
  bool hasShortnessOfBreah = false;
  bool hasLossOfSmellOrTaste = false;
  bool hasNauseaOrVomitting = false;
  bool hasDiarrhea = false;
  bool hasSkinProblem = false;
  bool hasCough = false;
  bool hasSoreThroat = false;
}

enum SymptomQuestionaireType {
  fever,
  cough,
  throat,
  fatigue,
  breathing,
  lossSense,
  nausea,
  diarrhea,
  chestPain,
  confused,
  skin
}

extension SymptomString on SymptomQuestionaireType {
  String get string {
    switch (this) {
      case SymptomQuestionaireType.breathing:
        return "Trouble breathing";
      case SymptomQuestionaireType.diarrhea:
        return "Diarrhea";
      case SymptomQuestionaireType.fatigue:
        return "Fatigue and muscle pain";
      case SymptomQuestionaireType.fever:
        return "Fever";
      case SymptomQuestionaireType.lossSense:
        return "New loss of sense of taste or smell";
      case SymptomQuestionaireType.nausea:
        return "Nausea or Vomitting";
      case SymptomQuestionaireType.throat:
        return "Sore throat";
      case SymptomQuestionaireType.chestPain:
        return "Persistent pain or pressure in Chest";
      case SymptomQuestionaireType.confused:
        return "Change on mental status or confused";
      case SymptomQuestionaireType.skin:
        return "Pale, gray, or blue skin, lips, or nail beds";
      case SymptomQuestionaireType.cough:
        return "Cough";
    }
  }
}
