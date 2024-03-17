part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class GetShortestWayEvent extends AppEvent {
  const GetShortestWayEvent({
    required this.shortestWayModel,
  });

  final ShortestWayModel shortestWayModel;

  @override
  List<Object?> get props => [shortestWayModel];
}

class FieldErrorEvent extends AppEvent {
  const FieldErrorEvent({
    required this.urlError,
  });

  final String? urlError;

  @override
  List<Object?> get props => [urlError];
}

class CheckIsValidUrlEvent extends AppEvent {
  const CheckIsValidUrlEvent({required this.url});

  final String url;

  @override
  List<Object?> get props => [url];
}

class CheckIsActiveButtonEvent extends AppEvent {
  const CheckIsActiveButtonEvent({required this.isActiveButton});

  final bool isActiveButton;

  @override
  List<Object?> get props => [isActiveButton];
}
class ProgressEvent extends AppEvent {
  const ProgressEvent({required this.isProgress});

  final bool isProgress;

  @override
  List<Object?> get props => [isProgress];
}
class BaseUrlEvent extends AppEvent {
  const BaseUrlEvent({required this.url});

  final String url;

  @override
  List<Object?> get props => [url];
}
class StartCountingProcessEvent extends AppEvent {
  const StartCountingProcessEvent();

  @override
  List<Object?> get props => [];
}