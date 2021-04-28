import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/doctor_flow/bloc/doctor_bloc.dart';
import 'package:india_covid_care/doctor_flow/model/doctor_information.dart';
import 'package:india_covid_care/doctor_flow/view/doctor_information_textField.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorInformationDialog extends StatelessWidget {
  final String phoneNumber;
  final String id;

  DoctorInformationDialog({required this.phoneNumber, required this.id});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.4,
            // color: Colors.white,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Please enter your information',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    SizedBox(
                      height: 32,
                    ),
                    DoctorInformationInputTextField(
                        type: DoctorInformationFields.name),
                    SizedBox(
                      height: 16,
                    ),
                    DoctorInformationInputTextField(
                        type: DoctorInformationFields.location),
                    SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<DoctorBloc, DoctorState>(builder: (ctx, state) {
                      if (state is PatientsLoaded && state.isValidDoctorInput) {
                        return Row(
                          children: [
                            Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  // Send the POST api call to let us know which doctor
                                  BlocProvider.of<DoctorBloc>(context)
                                      .add(DoctorInitiatedCall(id: id));
                                  // Don't await for it - send the doctor straight to whatsapp
                                  launch(
                                      "whatsapp://send?phone=+91$phoneNumber");
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    padding: EdgeInsets.all(12)),
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
                        );
                      } else {
                        return Container();
                      }
                    })
                    // Row(
                    //   children: [
                    //     Spacer(),
                    //     ElevatedButton(
                    //         onPressed: () {
                    //           // Send the POST api call to let us know which doctor
                    //           BlocProvider.of<DoctorBloc>(context)
                    //               .add(DoctorInitiatedCall(id: id));
                    //           // Don't await for it - send the doctor straight to whatsapp
                    //           launch("whatsapp://send?phone=+91$phoneNumber");
                    //         },
                    //         style: ElevatedButton.styleFrom(
                    //             primary: Colors.green,
                    //             padding: EdgeInsets.all(12)),
                    //         child: Row(
                    //           children: [
                    //             Text('Call'),
                    //             SizedBox(
                    //               width: 8,
                    //             ),
                    //             Icon(Icons.phone)
                    //           ],
                    //         ))
                    //   ],
                    // )
                  ],
                ))));
  }
}
