import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hot_and_cold/pages/home/bloc/geolocalisation_bloc.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<GeolocalisationBloc, GeolocalisationState>(
      listener: (context, state) {},
      child: _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
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
  // final StreamSubscription<Position> positionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.best).listen(
  //   (Position position) {
  //       print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
  //   });

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
    return BlocBuilder<GeolocalisationBloc, GeolocalisationState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
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
                            Random random = new Random();
                            double newLongitude = 50.0 + random.nextInt(50);
                            double newLatitude = 50.0 + random.nextInt(50);
                            print("On Tap $newLongitude $newLatitude");
                            context.read<GeolocalisationBloc>().add(
                                PositionChanged(
                                    currentPosition: Position(
                                        latitude: newLatitude,
                                        longitude: newLongitude)));
                          },
                          child: Icon(Icons.portable_wifi_off_outlined))
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
