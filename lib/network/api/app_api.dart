import 'package:injectable/injectable.dart';

import '../../model/shortest_way_model.dart';
import '../http_client.dart';

@LazySingleton(as: AppApiI)
class AppApi implements AppApiI {
  const AppApi({
    required this.httpClient,
  });

  final HttpClientBase httpClient;

  @override
  Future<ShortestWayModel> getShortestWay(String method) async {
    final response = await httpClient.fetch(
        httpRequest: HttpRequestConst.get(
      method: method,
    ));
    final ShortestWayModel model =
        ShortestWayModel.fromJson(response.data as Map<String, dynamic>);
    return model;
  }
}

abstract class AppApiI {
  Future<ShortestWayModel> getShortestWay(String method);
}
