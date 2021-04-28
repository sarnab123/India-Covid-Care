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
        body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: BlocListener<PatientBloc, PatientState>(
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
                        VaccineCheckboxWidget(),
                        BlocBuilder<PatientBloc, PatientState>(
                            builder: (ctx, state) {
                          if (state is PatientEditing && state.vaccinated) {
                            return Column(
                              children: [
                                VaccineDatePicker(isFirstShot: true),
                                VaccineDatePicker(isFirstShot: false)
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
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
                ))));
  }
}

class VaccineDatePicker extends StatefulWidget {
  final bool isFirstShot;
  VaccineDatePicker({required this.isFirstShot});
  @override
  _VaccineDatePickerState createState() => _VaccineDatePickerState();
}

class _VaccineDatePickerState extends State<VaccineDatePicker> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019, 12),
        lastDate: DateTime(2021, 12));
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
      BlocProvider.of<PatientBloc>(context).add(VaccineDateSelected(
          newDate: pickedDate, isFirstShot: widget.isFirstShot));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () => _selectDate(context),
            child: Row(
              children: [
                Text(
                    widget.isFirstShot ? 'Vaccine 1 Date: ' : 'Vaccine 2 Date'),
                SizedBox(
                  width: 32,
                ),
                Text(_selectedDate != null
                    ? '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}'
                    : '')
              ],
            ))
      ],
    );
  }
}

class VaccineCheckboxWidget extends StatefulWidget {
  @override
  _VaccineCheckboxWidgetState createState() => _VaccineCheckboxWidgetState();
}

class _VaccineCheckboxWidgetState extends State<VaccineCheckboxWidget> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        value: _selected,
        title: Text('Are you vaccinated?'),
        onChanged: (value) {
          setState(() {
            _selected = value as bool;
          });
          BlocProvider.of<PatientBloc>(context)
              .add(VaccineToggled(value: value as bool));
        });
  }
}
