import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_and_cold/pages/home/bloc/geolocalisation_bloc.dart';
import 'package:hot_and_cold/pages/home/congratulation_view.dart';
import 'package:hot_and_cold/widgets/compass.dart';

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

    positionStream =
        Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best)
            .listen((Position position) {
      context.read<GeolocalisationBloc>().add(PositionChanged(
          currentPosition: Position(
              latitude: position.latitude, longitude: position.longitude)));
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

  String _getIndicationAccordingToStatus(GeolocalisationStatus status) {
    if (status == GeolocalisationStatus.idle) {
      return "Il faut bouger pour avoir des indications.";
    }
    return status == GeolocalisationStatus.isGettingCloser
        ? "Tu chauffes !"
        : "Tu refroidis...";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeolocalisationBloc, GeolocalisationState>(
      listener: (context, state) {
        if (state.status == GeolocalisationStatus.arrived) {
          positionStream.cancel();
        }
      },
      child: BlocBuilder<GeolocalisationBloc, GeolocalisationState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status == GeolocalisationStatus.arrived) {
            return CongratulationView();
          }
          return AnimatedContainer(
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
                gradient: _getGradientAccordingToStatus(state.status)),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
//                                  border: Border.all(width: 1),
 //                                 borderRadius: BorderRadius.circular(10)
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  context.read<GeolocalisationBloc>().add(PositionChanged(
                                      currentPosition: Position(
                                          latitude: 50.620536, longitude: 2.434272)));
                                },
                                onDoubleTap: (){
                                  context.read<GeolocalisationBloc>().add(PositionChanged(
                                      currentPosition: Position(
                                          latitude: 49.620536, longitude: 2.434272)));
                                },
                                onLongPress: (){
                                  context.read<GeolocalisationBloc>().add(PositionChanged(
                                      currentPosition: Position(
                                          latitude: 48.620536, longitude: 2.434272)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8, top: 16, bottom: 16),
                                  child: Text(
                                    _getIndicationAccordingToStatus(state.status),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 24, fontFamily: "Akaya"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    //child: Container(),
                    child: Compass(),
                  ),
                  Expanded(child: Container())
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
/*
Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Compass(),
                          InkWell(
                              onTap: () {
                                context.read<GeolocalisationBloc>().add(
                                    PositionChanged(
                                        currentPosition: Position(
                                            latitude: 48.620536, longitude: 2.434272)));
                              },
                              child: Icon(Icons.portable_wifi_off_outlined)),
                          Text("Longitude ${state.currentPosition.longitude}"),
                          Text("Latitude ${state.currentPosition.latitude}"),
                        ],
                      ),
                    )
 */
