import 'package:bloc/bloc.dart';
import 'package:mobile_pizzaria_app/features/category/domain/entities/category.dart';
import 'package:mobile_pizzaria_app/features/product/domain/entities/product.dart';
import 'package:mobile_pizzaria_app/features/product/domain/repos/iproduct_repo.dart';
import 'package:mobile_pizzaria_app/features/product/presentation/cubits/product_state.dart';
import 'package:mobile_pizzaria_app/features/size/domain/entities/size.dart';

class ProductCubit extends Cubit<ProductState> {
  final IProductRepo productRepo;

  ProductCubit({required this.productRepo}) : super(ProductInitial());

  void getProduct(String productId) {
    emit(ProductLoading());
    try {
      if (productId.isEmpty || productId == '-1') {
        final product = productRepo.empty();
        emit(ProductLoaded(products: [product]));
        return;
      }
      final product = productRepo.getProduct(productId);
      emit(ProductLoaded(products: [product]));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  void getProducts() {
    emit(ProductLoading());
    try {
      final products = productRepo.getProducts();
      emit(ProductLoaded(products: _sortProduct(products)));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  void filterProducts(String stringToSearch, String categoryId) {
    emit(ProductLoading());
    try {
      final products = productRepo.getProductsByNameAndCategoryId(
          stringToSearch, categoryId);
      emit(ProductLoaded(products: _sortProduct(products)));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  void createProduct(
    String name,
    double price,
    String description,
    String imageUrl,
    MyCategory category,
    List<MySize> sizes,
  ) async {
    emit(ProductLoading());
    try {
      productRepo.createProduct(
        name,
        price,
        description,
        imageUrl,
        category,
        sizes,
      );
      getProducts();
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  void updateProduct(Product product) {
    emit(ProductLoading());
    try {
      productRepo.updateProduct(product);
      getProducts();
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  void deleteProduct(Product product) {
    try {
      productRepo.deleteProduct(product.id);
      getProducts();
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  List<Product> _sortProduct(List<Product> products) {
    final sortedProducts = List.of(products)
      ..sort((a, b) {
        if (a.category.id == '1') return -1;
        if (b.category.id == '1') return 1;
        return a.category.name.compareTo(b.category.name);
      });
    return sortedProducts;
  }
}
