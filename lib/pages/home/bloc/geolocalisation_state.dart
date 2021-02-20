part of 'geolocalisation_bloc.dart';

enum GeolocalisationStatus {
  isGettingCloser,
  isGettingFurtherAway,
  idle,
  arrived
}

@immutable
class GeolocalisationState extends Equatable {
  final Position currentPosition;
  final Position destinationPosition;
  final double previousDistance;
  final GeolocalisationStatus status;

  const GeolocalisationState.init(
      this.currentPosition, this.destinationPosition,
      {this.previousDistance = double.maxFinite,
      this.status = GeolocalisationStatus.idle});

  const GeolocalisationState._(
      {this.currentPosition,
      this.destinationPosition,
      this.previousDistance,
      this.status = GeolocalisationStatus.idle});

  GeolocalisationState copyWith(
      {Position currentPosition,
      Position destinationPosition,
      GeolocalisationStatus status,
      double previousDistance}) {
    return GeolocalisationState._(
      currentPosition: currentPosition ?? this.currentPosition,
      previousDistance: previousDistance ?? this.previousDistance,
      destinationPosition: destinationPosition ?? this.destinationPosition,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [status, currentPosition, destinationPosition, previousDistance];
}
// Position(latitude: 50, longitude: 50)

// class GeolocalisationInitialState extends GeolocalisationState {
//   GeolocalisationInitialState()
//       : super._(
//             status: GeolocalisationStatus.idle,
//             previousDistance: double.maxFinite,
//             destinationPosition: new Position(latitude: 50, longitude: 50));
// }

// class GeolocalisationIdleState extends GeolocalisationState {
//   GeolocalisationIdleState()
//       : super._(
//             status: GeolocalisationStatus.idle,
//             previousDistance: super.previousDistance,
//             destinationPosition: new Position(latitude: 50, longitude: 50));
// }

// class GeolocalisationMovingState extends GeolocalisationState {
//   GeolocalisationMovingState(
//       Position currentPosition, GeolocalisationStatus status)
//       : super._(currentPosition: currentPosition, status: status);
// }

// class GeolocalisationArrivedState extends GeolocalisationState {
//   GeolocalisationArrivedState()
//       : super._(status: GeolocalisationStatus.arrived);
// }
