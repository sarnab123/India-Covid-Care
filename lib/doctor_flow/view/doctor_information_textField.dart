import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/doctor_flow/bloc/doctor_bloc.dart';
import 'package:india_covid_care/doctor_flow/model/doctor_information.dart';

class DoctorInformationInputTextField extends StatefulWidget {
  final DoctorInformationFields type;

  DoctorInformationInputTextField({required this.type});
  @override
  _DoctorInformationInputTextFieldState createState() =>
      _DoctorInformationInputTextFieldState();
}

class _DoctorInformationInputTextFieldState
    extends State<DoctorInformationInputTextField> {
  late final TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController(
        text: (widget.type == DoctorInformationFields.name)
            ? BlocProvider.of<DoctorBloc>(context).info.name
            : BlocProvider.of<DoctorBloc>(context).info.location);
    _textController.addListener(() {
      BlocProvider.of<DoctorBloc>(context).add(DoctorInformationUpdated(
          value: _textController.text, type: widget.type));
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
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

  String _labelText(DoctorInformationFields type) {
    switch (type) {
      case DoctorInformationFields.name:
        return "Your name";
      case DoctorInformationFields.location:
        return "Your Location";
    }
  }
}
