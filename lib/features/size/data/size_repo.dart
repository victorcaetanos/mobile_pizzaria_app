import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';
import 'package:mobile_pizzaria_app/features/size/domain/repos/isize_repo.dart';

class MySizeRepo implements ISizeRepo {
  final List<MySize> sizes = [];

  MySizeRepo() {
    if (sizes.isEmpty) {
      sizes.addAll([
        MySize(
          id: '1',
          name: 'Pequena',
          isActive: true,
          slices: 4,
        ),
        MySize(
          id: '2',
          name: 'Media',
          isActive: true,
          slices: 6,
        ),
        MySize(
          id: '3',
          name: 'Grande',
          isActive: true,
          slices: 8,
        ),
        MySize(
          id: '4',
          name: 'Unico',
          isActive: true,
        ),
        MySize(
          id: '5',
          name: '350ml',
          isActive: true,
        ),
        MySize(
          id: '6',
          name: '473ml',
          isActive: true,
        ),
      ]);
    }
  }

  @override
  MySize empty() {
    return MySize(
      id: '-1',
      name: '',
      isActive: true,
    );
  }

  @override
  List<MySize> getMySizes() {
    try {
      return sizes.where((size) => size.isActive == true).toList();
    } catch (e) {
      throw Exception('Erro ao buscar tamanhos');
    }
  }

  @override
  MySize getMySize(String sizeId) {
    try {
      return sizes.firstWhere((size) => size.id == sizeId);
    } catch (e) {
      throw Exception('Erro ao buscar tamanho');
    }
  }

  @override
  void createMySize(
    String name,
  ) {
    try {
      final size = MySize(
        id: (sizes.length + 1).toString(),
        name: name,
        isActive: true,
      );

      sizes.add(size);
    } catch (e) {
      throw Exception('Erro ao criar tamanho');
    }
  }

  @override
  void updateMySize(MySize size) {
    try {
      final index = sizes.indexWhere((u) => u.id == size.id);

      if (index >= 0) {
        sizes[index] = size;
      }
    } catch (e) {
      throw Exception('Erro ao atualizar tamanho');
    }
  }

  @override
  void deleteMySize(String sizeId) {
    try {
      final index = sizes.indexWhere((u) => u.id == sizeId);

      if (index >= 0) {
        sizes.removeAt(index);
      }
    } catch (e) {
      throw Exception('Erro ao deletar tamanho');
    }
  }
}
