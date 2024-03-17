part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState({
    this.shortestWayModel,
    this.urlError = '',
    this.isActiveButton = false,
    this.isProgress,
    this.baseUrl = '',
  });

  final ShortestWayModel? shortestWayModel;
  final String urlError;
  final bool isActiveButton;
  final bool? isProgress;
  final String baseUrl;

  @override
  List<Object?> get props => [
        shortestWayModel,
        urlError,
        isActiveButton,
        isProgress,
        baseUrl,
      ];

  AppState copyWith({
    ShortestWayModel? shortestWayModel,
    String? urlError,
    bool? isActiveButton,
    bool? isProgress,
    String? baseUrl,
  }) {
    return AppState(
      shortestWayModel: shortestWayModel ?? this.shortestWayModel,
      urlError: urlError ?? this.urlError,
      isActiveButton: isActiveButton ?? this.isActiveButton,
      isProgress: isProgress ?? this.isProgress,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }
}
