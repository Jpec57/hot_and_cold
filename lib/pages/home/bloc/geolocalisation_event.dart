part of 'geolocalisation_bloc.dart';

abstract class GeolocalisationEvent extends Equatable {
  final Position currentPosition;

  const GeolocalisationEvent({@required this.currentPosition});

  @override
  List<Object> get props => [currentPosition];
}

class PositionChanged extends GeolocalisationEvent {
  final Position currentPosition;

  const PositionChanged({@required this.currentPosition});

  @override
  List<Object> get props => [currentPosition];
}

class IsIdle extends GeolocalisationEvent {
  @override
  List<Object> get props => [];
}
