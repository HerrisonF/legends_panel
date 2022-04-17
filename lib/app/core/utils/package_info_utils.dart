import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoUtils {

  late PackageInfo packageInfo;

  Future<void> initialize() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

}