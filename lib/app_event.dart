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
class FieldErrorEvent extends AppEvent{
  const FieldErrorEvent({
    required this.urlError,
  });

  final String? urlError;

  @override
  List<Object?> get props => [urlError];

}
class CheckIsValidUrlEvent extends AppEvent{
  const CheckIsValidUrlEvent({required this.url});
  final String url;
  @override
  List<Object?> get props => [url];

}
class CheckIsActiveButtonEvent extends AppEvent{
  const CheckIsActiveButtonEvent({required this.isActiveButton});
  final bool isActiveButton;
  @override
  List<Object?> get props => [isActiveButton];

}