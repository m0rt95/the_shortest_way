import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'core/validator/text_validator.dart';
import 'database/dao/server_ip_dao.dart';
import 'model/shortest_way_model.dart';
import 'network/api/app_api.dart';
import 'utils/snack_bar_utils.dart';

part 'app_event.dart';

part 'app_state.dart';

@Injectable()
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AppApiI appApi,
    required UrlSourceI urlSource,
  })  : _urlSource = urlSource,
        _appApi = appApi,
        super(const AppState()) {
    on<GetShortestWayEvent>((event, emit) {
      emit(state.copyWith(shortestWayModel: event.shortestWayModel));
    });
    on<FieldErrorEvent>((event, emit) {
      emit(state.copyWith(urlError: event.urlError));
    });
    on<CheckIsValidUrlEvent>((event, emit) {
      onCheckIsValidUrl(event.url);
    });
    on<CheckIsActiveButtonEvent>((event, emit) {
      emit(state.copyWith(isActiveButton: event.isActiveButton));
    });
    on<ProgressEvent>((event, emit) {
      emit(state.copyWith(isProgress: event.isProgress));
    });
    on<BaseUrlEvent>((event, emit) {
      emit(state.copyWith(baseUrl: event.url));
    });
    on<StartCountingProcessEvent>((event, emit) {
      startCountingProcess();
    });
  }

  void onCheckIsValidUrl(String url) {
    timer?.cancel();
    if (url.isNotEmpty) {
      timer = Timer(const Duration(milliseconds: 500), () {
        String? errorText;
        late bool isValidUrl;
        isValidUrl = TextValidator.checkIsUrl(url);
        if (isValidUrl) {
          errorText = '';
          add(BaseUrlEvent(url: url));
          add(const CheckIsActiveButtonEvent(isActiveButton: true));
        } else {
          errorText = 'This URL address is not valid';
        }
        add(FieldErrorEvent(urlError: errorText));
      });
    }
  }

  Future<void> startCountingProcess() async {
    final baseUrl = state.baseUrl;
    add(const ProgressEvent(isProgress: true));

    try {
      await _urlSource.saveBaseUrl(baseUrl);
      add(const ProgressEvent(isProgress: true));
      final model = await _appApi.getShortestWay(baseUrl);
      add(GetShortestWayEvent(shortestWayModel: model));
    } on Exception catch (error) {
      showSnackBar(error.toString());
    } finally {
      add(const ProgressEvent(isProgress: false));
    }
  }

  Timer? timer;
  final AppApiI _appApi;
  final UrlSourceI _urlSource;
}
