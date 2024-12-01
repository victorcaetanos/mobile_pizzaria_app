import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

abstract class ISizeRepo {
  MySize getMySize(String sizeId);
  List<MySize> getMySizes();
  MySize empty();
  void createMySize(
    String name,
  );
  void updateMySize(MySize size);
  void deleteMySize(String sizeId);
}
