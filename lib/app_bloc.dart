import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'core/validator/text_validator.dart';
import 'model/shortest_way_model.dart';
import 'network/api/app_api.dart';

part 'app_event.dart';
part 'app_state.dart';

@Injectable()
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AppApiI appApi}) : _appApi = appApi, super(const AppState()) {
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
  }

  void onCheckIsValidUrl(String url){
    timer?.cancel();
    if(url.isNotEmpty){
      timer = Timer(const Duration(milliseconds: 500), () {
        String? errorText;
        late bool isValidUrl;
        isValidUrl = TextValidator.checkIsUrl(url);
        if(isValidUrl){
          errorText = '';
          add(const CheckIsActiveButtonEvent(isActiveButton: true));
        }else{
          errorText = 'This URL address is not valid';
        }
        add(FieldErrorEvent(urlError: errorText));
      });
    }
  }

  Timer? timer;
  final AppApiI _appApi;
}
