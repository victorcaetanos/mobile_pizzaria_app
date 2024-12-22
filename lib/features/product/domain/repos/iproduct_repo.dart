import 'package:mobile_pizzaria_app/features/category/domain/entities/category.dart';
import 'package:mobile_pizzaria_app/features/product/domain/entities/product.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

abstract class IProductRepo {
  Product getProduct(String productId);
  List<Product> getProducts();
  List<Product> getProductsByName(String stringToSearch);
  List<Product> getProductsByCategoryId(String categoryId);
  List<Product> getProductsByNameAndCategoryId(
      String stringToSearch, String categoryId);
  Product empty();
  void createProduct(
    String name,
    double price,
    String description,
    String imageUrl,
    MyCategory category,
    List<MySize> sizes,
  );
  void updateProduct(Product product);
  void deleteProduct(String productId);
}
