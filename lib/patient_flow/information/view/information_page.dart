import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:india_covid_care/patient_flow/bloc/patient_bloc.dart';
import 'package:india_covid_care/patient_flow/information/model/patient_information_model.dart';
import 'package:india_covid_care/patient_flow/information/view/patient_information_textfield.dart';

class PatientInformationPage extends StatelessWidget {
  final List<PatientInformationFields> fields = [
    PatientInformationFields.name,
    PatientInformationFields.age,
    PatientInformationFields.language,
    PatientInformationFields.location,
    PatientInformationFields.number
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Information'),
          centerTitle: true,
        ),
        body: BlocListener<PatientBloc, PatientState>(
            listener: (ctx, state) {
              if (state is PatientEditing) {
                if (state.apiError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                    content: Text(
                      'Error submitting data. Please ensure valid information is filled out and try again',
                      style: TextStyle(color: Colors.white),
                    ),
                  ));
                } else if (state.apiSuccess) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                        content: Text(
                          'You have been added to the queue. A doctor will be in contact shortly',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                      .closed
                      .then((value) {
                    var count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 3;
                    });
                  });
                }
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Column(
                  children: [
                    for (var i = 0; i < fields.length; i++)
                      Column(
                        children: [
                          PatientInformationTextField(type: fields[i]),
                          SizedBox(
                            height: 16,
                          )
                        ],
                      ),
                    BlocBuilder<PatientBloc, PatientState>(
                        builder: (ctx, state) {
                      if (state is PatientEditing) {
                        print('BLOC BUILDER NEW STATE: ${state.status}');
                        if (state.status == FormzStatus.valid) {
                          return ElevatedButton(
                              onPressed: () {
                                // Dismiss keyboard
                                FocusScope.of(context).unfocus();
                                // Queue BLoC event for submission here
                                BlocProvider.of<PatientBloc>(context)
                                    .add(PatientInformationSubmitted());
                              },
                              child: Text('Submit'));
                        } else if (state.status == FormzStatus.invalid) {
                          return ElevatedButton(
                              onPressed: null, child: Text('Submit'));
                        } else {
                          return Container();
                        }
                      } else {
                        return Container();
                      }
                    })
                  ],
                ),
              ),
            )));
  }
}
