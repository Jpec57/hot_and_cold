import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'geolocalisation_event.dart';
part 'geolocalisation_state.dart';

//For coordinates https://www.latlong.net/

class GeolocalisationBloc
    extends Bloc<GeolocalisationEvent, GeolocalisationState> {
  GeolocalisationBloc()
      : super(GeolocalisationState.init(
            new Position(latitude: 60, longitude: 40),
            //48.620536, 2.434272)
            new Position(latitude: 48.620536, longitude: 2.434272)));

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
    double distanceBetweenCalls = (currentDistanceInMeters - state.previousDistance).abs();
    if (distanceBetweenCalls < 2){
      return state;
    }
    bool isGettingCloser = currentDistanceInMeters <= state.previousDistance;
    if (currentDistanceInMeters < 10) {
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
