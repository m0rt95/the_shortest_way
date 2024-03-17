import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: UrlSourceI)
class UrlSource implements UrlSourceI {
  final String customerUrlKey = 'url_app_key';

  String? baseUrl;

  @override
  Future<String> getBaseUrl() async {
    if (baseUrl != null) {
      return baseUrl!;
    }
    //
    else {
      final prefs = await SharedPreferences.getInstance();
      final customerUrl = prefs.getString(customerUrlKey);

      final String url = '$customerUrl/';
      baseUrl = url;
      return url;
    }
  }

  @override
  Future<void> saveBaseUrl(String domain) async {
    baseUrl = '$domain/';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(customerUrlKey, domain);
  }
}

abstract class UrlSourceI {
  Future<void> saveBaseUrl(String domain);

  Future<String> getBaseUrl();
}
