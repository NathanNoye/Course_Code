import 'package:oak_tree/oak_tree.dart';

class SkewManager extends BaseManager {
  double skewValue = 0;
  bool isOpen = false;

  void open() {
    skewValue = 1;
    isOpen = true;
    rebuildWidgets();
  }

  void close() {
    skewValue = 0;
    isOpen = false;
    rebuildWidgets();
  }

  void toggle() {
    if (isOpen) {
      close();
      isOpen = false;
    } else {
      open();
      isOpen = true;
    }

    rebuildWidgets();
  }
}
