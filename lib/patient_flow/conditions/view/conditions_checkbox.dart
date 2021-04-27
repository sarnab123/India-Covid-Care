import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/patient_flow/bloc/patient_bloc.dart';
import 'package:india_covid_care/patient_flow/conditions/model/condition_information.dart';

class ConditionsCheckboxTile extends StatefulWidget {
  final ConditionType type;

  ConditionsCheckboxTile({required this.type});
  @override
  _ConditionsCheckboxTileState createState() => _ConditionsCheckboxTileState();
}

class _ConditionsCheckboxTileState extends State<ConditionsCheckboxTile> {
  bool _selected = false;

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
              .add(ConditionToggled(type: widget.type, value: value as bool));
        });
  }
}
