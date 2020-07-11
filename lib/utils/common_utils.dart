import 'package:connectivity/connectivity.dart';

class CommonUtils {
  static String assetsPath = 'assets/images/';

  static String assetsImage(String fileName) {
    switch (fileName) {
      case 'app_logo':
        return '${assetsPath}logo.png';
      case 'android':
        return '${assetsPath}android.png';
      case 'flutter':
        return '${assetsPath}flutter.png';
      case 'ios':
        return '${assetsPath}ios.png';
      case 'hr':
        return '${assetsPath}hr.png';
      case 'php':
        return '${assetsPath}php.png';
      case 'angular':
        return '${assetsPath}angular.png';
      case 'tester':
        return '${assetsPath}tester.jpeg';
    }
  }

  static Future<bool> isNetworkConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
