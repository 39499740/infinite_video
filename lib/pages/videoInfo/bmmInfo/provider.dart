
import 'package:flutter/material.dart';

class BmmInfoProvider extends ChangeNotifier {
    BuildContext context;
    BmmInfoProvider(this.context);
      
    bool _initialized = false;
      
    void init() {
        if (!_initialized) {
            _initialized = true;
            Future.delayed(const Duration(milliseconds: 100), () {});
        }
    }
}
