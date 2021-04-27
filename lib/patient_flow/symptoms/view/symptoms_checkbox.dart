import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/patient_flow/bloc/patient_bloc.dart';
import 'package:india_covid_care/patient_flow/symptoms/model/symptom_information.dart';

class SymptomsCheckboxTile extends StatefulWidget {
  final SymptomQuestionaireType type;

  SymptomsCheckboxTile({required this.type});
  @override
  _SymptomsCheckboxTileState createState() => _SymptomsCheckboxTileState();
}

class _SymptomsCheckboxTileState extends State<SymptomsCheckboxTile> {
  bool _selected = false;

  @override
  void initState() {
    _selected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(widget.type.string),
        value: _selected,
        onChanged: (value) {
          setState(() {
            _selected = value as bool;
          });
          BlocProvider.of<PatientBloc>(context)
              .add(SymptomToggled(type: widget.type, value: value as bool));
        });
  }
}
