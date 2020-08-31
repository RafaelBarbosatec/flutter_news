import 'package:cubes/cubes.dart';

class HomeCube extends Cube {
  final tabPosition = ObservableValue<int>(value: 0);
  void setPosition(int position) {
    tabPosition.value = position;
  }
}
