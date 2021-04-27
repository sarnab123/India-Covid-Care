import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/patient_flow/bloc/patient_bloc.dart';
import 'package:india_covid_care/patient_flow/conditions/view/conditions_page.dart';
import 'package:india_covid_care/patient_flow/symptoms/model/symptom_information.dart';
import 'package:india_covid_care/patient_flow/symptoms/view/symptoms_checkbox.dart';
import 'package:india_covid_care/patient_flow/symptoms/view/symptoms_slider.dart';

class SymptomsPage extends StatelessWidget {
//   @override
//   _SymptomsPageState createState() => _SymptomsPageState();
// }

// class _SymptomsPageState extends State<SymptomsPage> {
//   ScrollController? _scrollController;

  final List<SymptomQuestionaireType> questions = [
    SymptomQuestionaireType.fever,
    SymptomQuestionaireType.cough,
    SymptomQuestionaireType.throat,
    SymptomQuestionaireType.fatigue,
    SymptomQuestionaireType.lossSense,
    SymptomQuestionaireType.nausea,
    SymptomQuestionaireType.diarrhea,
    SymptomQuestionaireType.breathing,
    SymptomQuestionaireType.chestPain,
    SymptomQuestionaireType.confused,
    SymptomQuestionaireType.skin
  ];

  // @override
  // void initState() {
  //   _scrollController = ScrollController();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Symptoms'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < questions.length; i++) _buildWidgetOnIndex(i),
              Padding(
                  padding: EdgeInsets.only(right: 16, top: 8, bottom: 32),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => BlocProvider.value(
                                      value:
                                          BlocProvider.of<PatientBloc>(context),
                                      child: ConditionsPage(),
                                    )));
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ))
            ],
          ),
        ));
  }

  Widget _buildWidgetOnIndex(int idx) {
    if (idx == 0) {
      return SymptomsSlider();
    } else {
      return SymptomsCheckboxTile(type: questions[idx]);
    }
  }
}
