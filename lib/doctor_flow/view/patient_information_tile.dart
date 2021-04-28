import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/doctor_flow/bloc/doctor_bloc.dart';
import 'package:india_covid_care/doctor_flow/model/doctor_information.dart';
import 'package:india_covid_care/doctor_flow/view/doctor_information_dialog.dart';
import 'package:india_covid_care/doctor_flow/view/doctor_information_textField.dart';
import 'package:india_covid_care/network/patient_details.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientInformationTile extends StatefulWidget {
  final PatientDetails patient;

  PatientInformationTile({required this.patient});
  @override
  _PatientInformationTileState createState() => _PatientInformationTileState();
}

class _PatientInformationTileState extends State<PatientInformationTile> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ExpansionTile(
        title: Text(
          '${widget.patient.name}',
          style:
              TextStyle(color: _isHighPriority() ? Colors.red : Colors.black),
        ),
        subtitle: Text(
            '${widget.patient.age} | ${widget.patient.location} | ${widget.patient.language}'),
        childrenPadding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
        children: [
          Container(
            width: double.infinity,
            height: 0,
            color: Colors.red,
          ),
          _buildColumnWrap(true),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Divider(
                height: 1,
              )),
          _buildColumnWrap(false),
          SizedBox(
            height: 16,
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  if (_isVaccinated())
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vaccinated'),
                        if (widget.patient.vaccine1Date != null)
                          Text('1st Dose: ${widget.patient.vaccine1Date!}'),
                        if (widget.patient.vaccine2Date != null)
                          Text('2nd Dose: ${widget.patient.vaccine2Date!}')
                      ],
                    ),
                  if (!_isVaccinated()) Text('Not Vaccinated'),
                  Spacer(),
                  if (_assignedDoctor())
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Last Connected Doctor'),
                        Text('Name: ${widget.patient.doctorName}'),
                        Text('Location: ${widget.patient.doctorLocation}')
                      ],
                    )
                ],
              )),
          if (_isVaccinated())
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      // queue BLoC event
                      if (widget.patient.id != null) {
                        BlocProvider.of<DoctorBloc>(context).add(
                            MarkPatientAsCompleted(id: widget.patient.id!));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green, padding: EdgeInsets.all(12)),
                    child: Row(
                      children: [
                        Text('Mark as completed'),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.check)
                      ],
                    )),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      // Present the Dialog here
                      showDialog(
                          context: context,
                          builder: (ctx) => BlocProvider.value(
                              value: BlocProvider.of<DoctorBloc>(context),
                              child: DoctorInformationDialog(
                                phoneNumber: widget.patient.number ?? "",
                                id: widget.patient.id ?? "",
                              )));
                      // create phone call here
                      // launch("whatsapp://send?phone=+91${widget.patient.number}");
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green, padding: EdgeInsets.all(12)),
                    child: Row(
                      children: [
                        Text('Call'),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.phone)
                      ],
                    ))
              ],
            ),
        ],
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
      )
    ]);
  }

  Widget _buildColumnWrap(bool isSymptom) {
    final List<String> split = _splitSymptomsConditionsToList(
        isSymptom ? widget.patient.symptoms : widget.patient.existingCondition);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(isSymptom ? 'Symptoms' : 'Conditions')),
      if (split.isEmpty) Text('No Conditions Reported!'),
      if (split.isNotEmpty)
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          direction: Axis.horizontal,
          children: [
            for (String obj in _splitSymptomsConditionsToList(isSymptom
                ? widget.patient.symptoms
                : widget.patient.existingCondition))
              Chip(
                  label: Padding(
                padding: EdgeInsets.all(6),
                child: Text(obj),
              ))
          ],
        )
    ]);
  }

  List<String> _splitSymptomsConditionsToList(String? list) {
    return list != null ? list.split(";") : [];
  }

  bool _isHighPriority() {
    return widget.patient.highPriority != null && widget.patient.highPriority!;
  }

  bool _assignedDoctor() {
    return widget.patient.doctorName.isNotEmpty &&
        widget.patient.doctorLocation.isNotEmpty;
  }

  bool _isVaccinated() {
    return widget.patient.vaccineTaken != null && widget.patient.vaccineTaken!;
  }
}
