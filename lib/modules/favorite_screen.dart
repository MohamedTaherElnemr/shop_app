import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/Get_favorites_model.dart';

import '../cubits/shop_cubit/shop_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! GetFavoriteLoading,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildFavItem(
                  BlocProvider.of<ShopCubit>(context)
                      .getFavoritesModel!
                      .data!
                      .favdata![index],
                  context),
              separatorBuilder: (context, index) => Divider(
                    thickness: 3,
                    color: Colors.black.withOpacity(0.3),
                  ),
              itemCount: BlocProvider.of<ShopCubit>(context)
                  .getFavoritesModel!
                  .data!
                  .favdata!
                  .length),
        );
      },
    );
  }
}

Widget buildFavItem(FavData model, context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            CachedNetworkImage(
                height: 120,
                width: double.infinity,
                imageUrl: '${model.product!.image}'),
            if (model.product!.discount != 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.product!.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${model.product!.price}E.G',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (1 != 0)
                    Text(
                      '${model.product!.oldPrice}E.G',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                ],
              ),
              CircleAvatar(
                backgroundColor: BlocProvider.of<ShopCubit>(context)
                        .favorite[model.product!.id]!
                    ? Colors.blue
                    : Colors.grey,
                radius: 18,
                child: IconButton(
                    color: Colors.white,
                    iconSize: 20,
                    onPressed: () {
                      BlocProvider.of<ShopCubit>(context)
                          .changeFavorites(model.product!.id!);
                    },
                    icon: const Icon(Icons.favorite_border)),
              ),
            ],
          ),
        ),
      ],
    );
