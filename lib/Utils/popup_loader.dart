import 'package:flutter_easyloading/flutter_easyloading.dart';

class PopupLoader {
  static void show([indicator = EasyLoadingIndicatorType.dualRing]) {
    EasyLoading.instance
      ..indicatorType = indicator
      ..maskType = EasyLoadingMaskType.clear
      ..displayDuration = const Duration(seconds: 5);
    EasyLoading.show();
  }

  static void hide() {
    EasyLoading.dismiss();
  }
}