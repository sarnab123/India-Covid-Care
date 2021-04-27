import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/patient_flow/bloc/patient_bloc.dart';
import 'package:india_covid_care/patient_flow/conditions/model/condition_information.dart';
import 'package:india_covid_care/patient_flow/conditions/view/conditions_checkbox.dart';
import 'package:india_covid_care/patient_flow/information/view/information_page.dart';

class ConditionsPage extends StatelessWidget {
  final List<ConditionType> conditions = [
    ConditionType.age,
    ConditionType.diabetes,
    ConditionType.hypertension,
    ConditionType.heart,
    ConditionType.liver,
    ConditionType.obese,
    ConditionType.marrow,
    ConditionType.lung,
    ConditionType.cancer,
    ConditionType.kidney,
    ConditionType.storke,
    ConditionType.dementia
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Health Conditions'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < conditions.length; i++)
                ConditionsCheckboxTile(type: conditions[i]),
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
                                      child: PatientInformationPage(),
                                    )));
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ))
            ],
          ),
        ));
  }
}
