import 'package:mobile_pizzaria_app/features/category/data/category_repo.dart';
import 'package:mobile_pizzaria_app/features/category/domain/entities/category.dart';
import 'package:mobile_pizzaria_app/features/product/domain/entities/product.dart';
import 'package:mobile_pizzaria_app/features/product/domain/repos/iproduct_repo.dart';
import 'package:mobile_pizzaria_app/features/size/data/size_repo.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

class ProductRepo implements IProductRepo {
  final List<Product> products = [];

  ProductRepo() {
    if (products.isEmpty) {
      MyCategoryRepo categoryRepo = MyCategoryRepo();
      products.addAll([
        Product(
          id: '1',
          name: 'Pizza Marguerita',
          price: 2.00,
          description:
              'Tomates frescos, mozzarella derretida e folhas de manjericão, tudo sobre uma base crocante e levemente regada com azeite virgem.',
          imagePath: 'assets/products/Pizza_1.png',
          category: categoryRepo.getMyCategory('1'),
          sizes: [
            MySizeRepo().getMySize('1'),
            MySizeRepo().getMySize('2'),
            MySizeRepo().getMySize('3'),
          ],
          isActive: true,
        ),
        Product(
          id: '2',
          name: 'Pizza pepperoni',
          price: 2.00,
          description:
              'Uma explosão de sabor! Fatias generosas de pepperoni crocante, queijo derretido e um toque especial de molho artesanal.',
          imagePath: 'assets/products/Pizza_2.png',
          category: categoryRepo.getMyCategory('1'),
          sizes: [
            MySizeRepo().getMySize('1'),
            MySizeRepo().getMySize('2'),
            MySizeRepo().getMySize('3'),
          ],
          isActive: true,
        ),
        Product(
          id: '3',
          name: 'Frango com catupiry',
          price: 2.00,
          description:
              'Suculento frango desfiado coberto com o cremoso catupiry, finalizado com ervas frescas e uma pitada de orégano.',
          imagePath: 'assets/products/Pizza_3.png',
          category: categoryRepo.getMyCategory('1'),
          sizes: [
            MySizeRepo().getMySize('1'),
            MySizeRepo().getMySize('2'),
            MySizeRepo().getMySize('3'),
          ],
          isActive: true,
        ),
        Product(
          id: '4',
          name: 'Di Mare Especiale',
          price: 2.00,
          description:
              'Camarão, lula e mariscos em molho de tomate, com um toque de alho e ervas.',
          imagePath: 'assets/products/Pizza_4.png',
          category: categoryRepo.getMyCategory('1'),
          sizes: [
            MySizeRepo().getMySize('1'),
            MySizeRepo().getMySize('2'),
            MySizeRepo().getMySize('3'),
          ],
          isActive: true,
        ),
        Product(
          id: '5',
          name: 'Caprese Rústica',
          price: 2.00,
          description:
              'Tomate fresco, mussarela de búfala e Filé mignon, regados com azeite extravirgem.',
          imagePath: 'assets/products/Pizza_5.png',
          category: categoryRepo.getMyCategory('1'),
          sizes: [
            MySizeRepo().getMySize('1'),
            MySizeRepo().getMySize('2'),
            MySizeRepo().getMySize('3'),
          ],
          isActive: true,
        ),
        Product(
          id: '6',
          name: 'Porcini Deluxe',
          price: 2.00,
          description:
              'Cogumelos porcini com mussarela de búfala e um leve toque de azeite de trufas.',
          imagePath: 'assets/products/Pizza_6.png',
          category: categoryRepo.getMyCategory('1'),
          sizes: [
            MySizeRepo().getMySize('1'),
            MySizeRepo().getMySize('2'),
            MySizeRepo().getMySize('3'),
          ],
          isActive: true,
        ),
        Product(
          id: '7',
          name: 'Coca-Cola',
          price: 2.00,
          description: 'Refrigerante de coca-cola.',
          imagePath: 'assets/products/coke.png',
          category: categoryRepo.getMyCategory('2'),
          sizes: [
            MySizeRepo().getMySize('5'),
            MySizeRepo().getMySize('6'),
          ],
          isActive: true,
        ),
        Product(
          id: '8',
          name: 'Monster Energy',
          price: 2.00,
          description:
              'Energético Monster Energy, em lata de 473ml. Acompanha gelo.',
          imagePath: 'assets/products/monster.jpg',
          category: categoryRepo.getMyCategory('2'),
          sizes: [MySizeRepo().getMySize('6')],
          isActive: true,
        ),
        Product(
          id: '9',
          name: 'Brigadeiro',
          price: 2.00,
          description:
              'Cogumelos porcini com mussarela de búfala e um leve toque de azeite de trufas.',
          imagePath: 'assets/products/brigadeiro.jpg',
          category: categoryRepo.getMyCategory('3'),
          sizes: [MySizeRepo().getMySize('4')],
          isActive: true,
        ),
        Product(
          id: '10',
          name: 'Trufa',
          price: 2.00,
          description:
              'Trufa de chocolate com recheio de brigadeiro e cobertura de chocolate ao leite.',
          imagePath: 'assets/products/trufa.jpg',
          category: categoryRepo.getMyCategory('3'),
          sizes: [MySizeRepo().getMySize('4')],
          isActive: true,
        ),
        Product(
          id: '11',
          name: 'Alfajor',
          price: 2.00,
          description:
              'Alfajor de chocolate com recheio de doce de leite e cobertura de amor.',
          imagePath: 'assets/products/alfajor.jpg',
          category: categoryRepo.getMyCategory('3'),
          sizes: [MySizeRepo().getMySize('4')],
          isActive: true,
        ),
      ]);
    }
  }

  @override
  Product empty() {
    return Product(
      id: '-1',
      name: '',
      price: 0.0,
      description: '',
      imagePath: '',
      category: MyCategory(
        id: '-1',
        name: '',
        isActive: true,
      ),
      sizes: List.empty(),
      isActive: true,
    );
  }

  @override
  Product getProduct(String productId) {
    try {
      return products.firstWhere((product) => product.id == productId);
    } catch (e) {
      throw Exception('Erro ao buscar produto');
    }
  }

  @override
  List<Product> getProducts() {
    try {
      return products.where((product) => product.isActive == true).toList();
    } catch (e) {
      throw Exception('Erro ao buscar produto');
    }
  }

  @override
  List<Product> getProductsByName(String stringToSearch) {
    try {
      return products
          .where(
            (product) => product.name.toLowerCase().contains(
                  stringToSearch.toLowerCase(),
                ),
          )
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar produto');
    }
  }

  @override
  List<Product> getProductsByCategoryId(String categoryId) {
    try {
      return products
          .where((product) => product.category.id == categoryId)
          .toList();
    } catch (e) {
      throw Exception('Erro ao buscar produto');
    }
  }

  @override
  void createProduct(
    String name,
    double price,
    String description,
    String imageUrl,
    MyCategory category,
    List<MySize> sizes,
  ) {
    try {
      final produto = Product(
        id: (products.length + 1).toString(),
        name: name,
        price: price,
        description: description,
        imagePath: imageUrl,
        category: category,
        sizes: sizes,
        isActive: true,
      );

      products.add(produto);
    } catch (e) {
      throw Exception('Erro ao criar produto');
    }
  }

  @override
  void updateProduct(Product produto) {
    try {
      final index = products.indexWhere((u) => u.id == produto.id);

      if (index >= 0) {
        products[index] = produto;
      }
    } catch (e) {
      throw Exception('Erro ao atualizar produto');
    }
  }

  @override
  void deleteProduct(String productId) {
    try {
      final index = products.indexWhere((u) => u.id == productId);

      if (index >= 0) {
        products.removeAt(index);
      }
    } catch (e) {
      throw Exception('Erro ao deletar produto');
    }
  }
}
