import 'package:mobile_pizzaria_app/features/category/domain/entities/category.dart';

abstract class ICategoryRepo {
  MyCategory getMyCategory(String categoryId);
  List<MyCategory> getMyCategories();
  MyCategory empty();
  void createMyCategory(
    String name,
  );
  void updateMyCategory(MyCategory category);
  void deleteMyCategory(String categoryId);
}
