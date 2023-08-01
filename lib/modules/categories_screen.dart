import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/shop_cubit/shop_cubit.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => catBuilder(
                BlocProvider.of<ShopCubit>(context)
                    .categoriesModel!
                    .categoriesData!
                    .dataList[index]),
            separatorBuilder: (context, index) => Divider(
                  thickness: 2,
                  color: Colors.black.withOpacity(0.3),
                ),
            itemCount: BlocProvider.of<ShopCubit>(context)
                .categoriesModel!
                .categoriesData!
                .dataList
                .length);
      },
    );
  }
}

Widget catBuilder(DataModel model) => Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CachedNetworkImage(
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              imageUrl: '${model.image}'),
          const SizedBox(
            width: 10,
          ),
          Text(
            '${model.name}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
