import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:india_covid_care/doctor_flow/bloc/doctor_bloc.dart';
import 'package:india_covid_care/doctor_flow/view/patient_information_tile.dart';
import 'package:shimmer/shimmer.dart';

class DoctorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: BlocConsumer<DoctorBloc, DoctorState>(listener: (ctx, state) {
          if (state is PatientsLoaded && state.cannotOpenWhatsapp) {
            // show dialog here that cannot open whats app
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (ctx) => BlocProvider.value(
                    value: BlocProvider.of<DoctorBloc>(context),
                    child: Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.2,
                            // color: Colors.white,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Unable to open the WhatsApp Application. Please ensure it is installed and try again',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<DoctorBloc>(context)
                                            .add(DoctorHasNoWhatsapp());
                                        Navigator.pop(context, false);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: Text(
                                        'I understand',
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              ),
                            )))));
          }
        }, builder: (ctx, state) {
          if (state is DoctorInitial) {
            BlocProvider.of<DoctorBloc>(context).add(FetchPatients());
            return Container();
          } else if (state is DoctorLoading) {
            // Add shimmer
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (var i = 0; i < 5; i++)
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: 48,
                        child: Shimmer.fromColors(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 20,
                                width: MediaQuery.of(context).size.width * 0.4,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                height: 10,
                                width: MediaQuery.of(context).size.width * 0.3,
                              )
                            ],
                          ),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                        ),
                      )
                  ],
                ));
          } else if (state is PatientsLoaded) {
            return ListView.builder(
              itemBuilder: (ctx, idx) {
                return PatientInformationTile(patient: state.patients[idx]);
              },
              itemCount: state.patients.length,
            );
            // return Container();
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
