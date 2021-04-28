import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/patient_flow/bloc/patient_bloc.dart';
import 'package:india_covid_care/patient_flow/information/model/patient_information_model.dart';

class PatientInformationTextField extends StatefulWidget {
  final PatientInformationFields type;

  PatientInformationTextField({required this.type});

  @override
  _PatientInformationTextFieldState createState() =>
      _PatientInformationTextFieldState();
}

class _PatientInformationTextFieldState
    extends State<PatientInformationTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      // Queue event to BLoC here
      BlocProvider.of<PatientBloc>(context).add(PatientInformationFieldUpdated(
          type: widget.type, value: _controller.text));
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: _keyboardOrNumberpad(widget.type),
      cursorColor: Colors.black,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: _labelText(widget.type),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }

  String _labelText(PatientInformationFields field) {
    switch (field) {
      case PatientInformationFields.age:
        return "Age";
      case PatientInformationFields.language:
        return "Primary Language";
      case PatientInformationFields.location:
        return "Location";
      case PatientInformationFields.name:
        return "Name";
      case PatientInformationFields.number:
        return "Phone number";
    }
  }

  TextInputType _keyboardOrNumberpad(PatientInformationFields field) {
    switch (field) {
      case PatientInformationFields.age:
        return TextInputType.number;
      case PatientInformationFields.number:
        return TextInputType.number;
      case PatientInformationFields.language:
      case PatientInformationFields.location:
      case PatientInformationFields.name:
        return TextInputType.name;
    }
  }
}
