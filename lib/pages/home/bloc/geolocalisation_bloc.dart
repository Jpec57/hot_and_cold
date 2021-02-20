import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'geolocalisation_event.dart';
part 'geolocalisation_state.dart';

class GeolocalisationBloc
    extends Bloc<GeolocalisationEvent, GeolocalisationState> {
  GeolocalisationBloc()
      : super(GeolocalisationState.init(
            new Position(latitude: 60, longitude: 40),
            new Position(latitude: 57, longitude: 57)));

  @override
  Stream<GeolocalisationState> mapEventToState(
    GeolocalisationEvent event,
  ) async* {
    if (event is PositionChanged) {
      yield await _mapPositionChangedToState(event);
    } else if (event is IsIdle) {
      yield state.copyWith(status: GeolocalisationStatus.idle);
    }
  }

  Future<GeolocalisationState> _mapPositionChangedToState(
    PositionChanged event,
  ) async {
    Position destination = state.destinationPosition;
    Position currentPos = event.currentPosition;
    double currentDistanceInMeters = Geolocator.distanceBetween(
        currentPos.latitude,
        currentPos.longitude,
        destination.latitude,
        destination.longitude);
    bool isGettingCloser = currentDistanceInMeters <= state.previousDistance;
    if (currentDistanceInMeters < 30) {
      return state.copyWith(
          currentPosition: state.destinationPosition,
          status: GeolocalisationStatus.arrived);
    }
    return state.copyWith(
        currentPosition: currentPos,
        previousDistance: currentDistanceInMeters,
        status: isGettingCloser
            ? GeolocalisationStatus.isGettingCloser
            : GeolocalisationStatus.isGettingFurtherAway);
  }
}
