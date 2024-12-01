import 'package:mobile_pizzaria_app/features/category/domain/entities/category.dart';
import 'package:mobile_pizzaria_app/features/category/domain/repos/icategory_repo.dart';

class MyCategoryRepo implements ICategoryRepo {
  final List<MyCategory> categories = [];

  MyCategoryRepo() {
    if (categories.isEmpty) {
      categories.addAll([
        MyCategory(
          id: '1',
          name: 'Pizzas',
          isActive: true,
        ),
        MyCategory(
          id: '2',
          name: 'Bebidas',
          isActive: true,
        ),
        MyCategory(
          id: '3',
          name: 'Doces',
          isActive: true,
        ),
      ]);
    }
  }

  @override
  MyCategory empty() {
    return MyCategory(
      id: '-1',
      name: '',
      isActive: true,
    );
  }

  @override
  List<MyCategory> getMyCategories() {
    try {
      return categories.where((category) => category.isActive == true).toList();
    } catch (e) {
      throw Exception('Erro ao buscar categorias');
    }
  }

  @override
  MyCategory getMyCategory(String categoryId) {
    try {
      return categories.firstWhere((category) => category.id == categoryId);
    } catch (e) {
      throw Exception('Erro ao buscar categoria');
    }
  }

  @override
  void createMyCategory(
    String name,
  ) {
    try {
      final category = MyCategory(
        id: (categories.length + 1).toString(),
        name: name,
        isActive: true,
      );

      categories.add(category);
    } catch (e) {
      throw Exception('Erro ao criar categoria');
    }
  }

  @override
  void updateMyCategory(MyCategory category) {
    try {
      final index = categories.indexWhere((u) => u.id == category.id);

      if (index >= 0) {
        categories[index] = category;
      }
    } catch (e) {
      throw Exception('Erro ao atualizar categoria');
    }
  }

  @override
  void deleteMyCategory(String categoryId) {
    try {
      final index = categories.indexWhere((u) => u.id == categoryId);

      if (index >= 0) {
        categories.removeAt(index);
      }
    } catch (e) {
      throw Exception('Erro ao deletar categoria');
    }
  }
}
