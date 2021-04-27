import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/patient_flow/bloc/patient_bloc.dart';

class SymptomsSlider extends StatefulWidget {
  @override
  _SymptomsSliderState createState() => _SymptomsSliderState();
}

class _SymptomsSliderState extends State<SymptomsSlider> {
  double _value = 98.6;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 76,
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Fever',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
              Spacer(),
              Text(_value.toStringAsFixed(1)),
              SizedBox(
                width: 8,
              ),
              Slider(
                  min: 94.0,
                  max: 105.0,
                  label: '$_value',
                  value: _value,
                  onChanged: (newVal) {
                    setState(() {
                      _value = newVal;
                    });
                    BlocProvider.of<PatientBloc>(context)
                        .add(TemperatureUpdated(value: _value));
                  })
            ],
          ),
        ));
  }
}
