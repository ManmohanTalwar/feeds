import 'package:feeds/injection.dart';
import 'package:http/http.dart';

import 'base_service.dart';
import 'network_util.dart';

class Services implements BaseServices {
  late NetworkUtil serviceApi;

  static final Services _instance = Services._internal();

  factory Services() => _instance;

  Services._internal();

  void setAppServices() {
    serviceApi = locator<NetworkUtil>();
  }

  @override
  Future<Response> getFeeds() async {
    return await serviceApi.getFeeds();
  }
}
