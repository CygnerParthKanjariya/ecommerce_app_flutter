import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dashboard/domain/entities/categories.dart';
import '../bloc/products_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final category = ModalRoute.of(context)!.settings.arguments as Category;
      context.read<ProductsBloc>().add(GetProductsEvent(endpoint: category.slug.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        }
      },
      builder: (context, state) {
        if (state is ProductsLoaded) {
          ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.products[index].title.toString()),
                subtitle: Text(state.products[index].price.toString()),
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
