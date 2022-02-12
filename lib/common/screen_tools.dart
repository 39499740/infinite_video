import 'package:flustars/flustars.dart';

class ScreenTools {
  static double getSize(double inSize) {
    return ScreenUtil.getInstance().getAdapterSize(inSize);
  }

  static double fromSafeBottom(double h) {
    return ScreenUtil.getInstance().bottomBarHeight + getSize(h);
  }

  static double fromSafeTop(double h) {
    return ScreenUtil.getInstance().statusBarHeight + getSize(h);
  }

  static double appBarHeight() {
    return ScreenUtil.getInstance().appBarHeight;
  }

  static double minusSafeTop(double h) {
    return getSize(h) - ScreenUtil.getInstance().statusBarHeight;
  }

  static double screenWidth() {
    return ScreenUtil.getInstance().screenWidth;
  }

  static double screenHeight() {
    return ScreenUtil.getInstance().screenHeight;
  }

  static double screenSafetyHeight() {
    return screenHeight() - fromSafeBottom(0) - fromSafeBottom(0);
  }
}
