import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_and_cold/pages/home/bloc/geolocalisation_bloc.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _HomeScreen();
  }
}

class _HomeScreen extends StatefulWidget {
  @override
  __HomeScreenState createState() => __HomeScreenState();
}

class __HomeScreenState extends State<_HomeScreen> {
  StreamSubscription<Position> positionStream;

  final List<Color> closerColors = [Color(0xFFFF5050), Color(0xFF800000)];

  final List<Color> furtherColors = [Color(0xFF33CCFF), Color(0xFF0000CC)];

  final closerGradient = RadialGradient.lerp(
      RadialGradient(
        // radius: 0.2,
        colors: [Colors.amber, Color(0xff800000)],
      ),
      RadialGradient(
        // radius: 0.2,
        colors: [Colors.red, Color(0xff800000)],
        stops: [0.3, 0.9],
      ),
      0.5);

  final furtherGradient = RadialGradient.lerp(
      RadialGradient(
        // radius: 0.2,
        colors: [Colors.white, Colors.blue],
      ),
      RadialGradient(
        // radius: 0.2,
        colors: [Colors.lightBlueAccent, Colors.purple],
        stops: [0.3, 0.9],
      ),
      0.5);

  final idleGradient = RadialGradient.lerp(
      RadialGradient(
        // radius: 0.2,
        colors: [Colors.white, Colors.black],
      ),
      RadialGradient(
        // radius: 0.2,
        colors: [Colors.white, Colors.grey],
        stops: [0.3, 0.9],
      ),
      0.5);

  @override
  void initState() {
    super.initState();

    positionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best).listen(
            (Position position) {
          print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
          print("EVENT ! ");

          context.read<GeolocalisationBloc>().add(
              PositionChanged(
                  currentPosition: Position(
                      latitude: position.latitude,
                      longitude: position.longitude)));
        });
  }


  @override
  void dispose() {
    super.dispose();
    positionStream.cancel();
  }

  Gradient _getGradientAccordingToStatus(GeolocalisationStatus status) {
    switch (status) {
      case GeolocalisationStatus.isGettingCloser:
        return closerGradient;
      case GeolocalisationStatus.isGettingFurtherAway:
        return furtherGradient;
      default:
        return idleGradient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeolocalisationBloc, GeolocalisationState>(
      listener: (context, state) {
        if (state.status == GeolocalisationStatus.arrived){
          positionStream.cancel();
        }
      },
      child: BlocBuilder<GeolocalisationBloc, GeolocalisationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == GeolocalisationStatus.arrived){
            return Center(
              child: Container(
                child: Text("おめでとう"),
              ),
            );
          }
          return AnimatedContainer(
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
                gradient: _getGradientAccordingToStatus(state.status)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    child: Column(
                      children: [
                        InkWell(
                            onTap: () {
                              context.read<GeolocalisationBloc>().add(
                                  PositionChanged(
                                      currentPosition: Position(
                                          latitude: 57,
                                          longitude: 57)));
                            },
                            child: Icon(Icons.portable_wifi_off_outlined)),
                        Text("Longitude ${state.currentPosition.longitude}"),
                        Text("Latitude ${state.currentPosition.latitude}"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
