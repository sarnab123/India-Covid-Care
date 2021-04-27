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
        child: BlocBuilder<DoctorBloc, DoctorState>(builder: (ctx, state) {
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
