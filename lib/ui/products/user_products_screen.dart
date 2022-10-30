import 'package:flutter/material.dart';
import 'package:flutter_application_4/ui/shared/app_drawer.dart';
import 'user_product_list_title.dart';
import 'products_manager.dart';
import 'package:provider/provider.dart';
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productManager = ProductManger();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => print('refresh products'),
        child: builUserProductListView(productManager),
      ),
    );
  }

  Widget builUserProductListView(ProductManger productsManager) {
    return Consumer<ProductManger>(
      builder: (ctx, productManger, child) {
        return ListView.builder(
          itemCount: productManger.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProducListTitle(
                productManger.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }
}
