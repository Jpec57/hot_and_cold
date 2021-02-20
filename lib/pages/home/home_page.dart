import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_and_cold/pages/home/bloc/geolocalisation_bloc.dart';
import 'package:hot_and_cold/pages/home/home_view.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => GeolocalisationBloc(),
        child: HomeView(),
      ),
    );
  }
}
