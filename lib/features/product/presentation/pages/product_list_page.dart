import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_pizzaria_app/features/auth/domain/entities/app_user.dart';
import 'package:mobile_pizzaria_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/components/my_floating_button.dart';
import 'package:mobile_pizzaria_app/features/cart/presentation/pages/cart_page.dart';
import 'package:mobile_pizzaria_app/features/category/data/category_repo.dart';
import 'package:mobile_pizzaria_app/features/category/domain/entities/category.dart';
import 'package:mobile_pizzaria_app/features/home/presentation/pages/home_page.dart';
import 'package:mobile_pizzaria_app/features/product/presentation/components/product_display.dart';
import 'package:mobile_pizzaria_app/features/category/presentation/components/category_dropdown_selector.dart';
import 'package:mobile_pizzaria_app/features/product/presentation/cubits/product_cubit.dart';
import 'package:mobile_pizzaria_app/features/product/presentation/cubits/product_state.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late final ProductCubit productCubit = context.read<ProductCubit>();
  MyCategory? selectedCategory;

  AppUser? currentUser;

  @override
  void initState() {
    super.initState();
    getAllCards();
  }

  void getAllCards() {
    final AuthCubit authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
    productCubit.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Center(
          child: Text(
            'Pizzas',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 24.0),
                _buildSearchSection(),
                const SizedBox(height: 24.0),
                _buildProductListSection(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: MyFloatingButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        },
      ),
    );
  }

  Column _buildSearchSection() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Pesquisar...',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ), 
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onChanged: (value) {
            productCubit.getProductsByName(value);
          },
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          width: double.infinity,
          child: DropdownCategorySelector(
            categories: MyCategoryRepo().getMyCategories(),
            selectedCategory: selectedCategory,
            onCategorySelected: (MyCategory? category) {
              setState(() {
                selectedCategory = category;
                if (category != null) {
                  productCubit.getProductsByCategoryId(category.id);
                } else {
                  productCubit.getProducts();
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Expanded _buildProductListSection() {
    return Expanded(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoaded) {
            return ListView.separated(
              itemCount: state.products.length,
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final product = state.products[index];

                if (index == 0 ||
                    state.products[index - 1].category.name !=
                        product.category.name) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          product.category.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      ProductDisplay(product: product),
                    ],
                  );
                }
                return ProductDisplay(product: product);
              },
              separatorBuilder: (context, index) {
                if (index == state.products.length) {
                  return const SizedBox(height: 20.0);
                }
                return const SizedBox(height: 12.0);
              },
              padding: const EdgeInsets.only(bottom: 40.0),
            );
          }
          return const Center(
            child: Text('Erro ao carregar produtos'),
          );
        },
      ),
    );
  }
}
