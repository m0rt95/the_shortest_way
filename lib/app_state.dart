part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.shortestWayModel,
    this.urlError = '',
    this.isActiveButton = false,
  });

  final ShortestWayModel? shortestWayModel;
  final String urlError;
  final bool isActiveButton;

  @override
  List<Object?> get props => [shortestWayModel, urlError, isActiveButton,];

  AppState copyWith({
    ShortestWayModel? shortestWayModel,
    String? urlError,
    bool? isActiveButton,
  }) {
    return AppState(
      shortestWayModel: shortestWayModel ?? this.shortestWayModel,
      urlError: urlError ?? this.urlError,
      isActiveButton: isActiveButton ?? this.isActiveButton,
    );
  }
}
