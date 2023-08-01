import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/shop_cubit/shop_cubit.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shop_app/models/categories_model.dart';
import '../../models/home_model.dart';

// ignore: must_be_immutable
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: BlocProvider.of<ShopCubit>(context).homeModel != null &&
              BlocProvider.of<ShopCubit>(context).categoriesModel != null,
          builder: (context) => productsBuilder(
              BlocProvider.of<ShopCubit>(context).homeModel!,
              BlocProvider.of<ShopCubit>(context).categoriesModel!,
              context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////
Widget productsBuilder(
        HomeModel homeModel, CategoriesModel categoriesModel, context) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CarouselSlider(
            items: homeModel.data!.banners
                .map(
                  (e) => CachedNetworkImage(
                    imageUrl: '${e.image}',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              enableInfiniteScroll: true,
              initialPage: 0,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
        ),
        // const SizedBox(
        //   height: 5,
        // ),
        /////////////////////////////////////////categories//////////////////////////////////////////////////
        const Text(
          '  Categories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 100,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => buidCategoryItem(
                    categoriesModel.categoriesData!.dataList[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                itemCount: categoriesModel.categoriesData!.dataList.length),
          ),
        ),
        const SizedBox(
          height: 5,
        ),

        ////////////////////////////////////////New Products/////////////////////////////////////////////////
        const Text(
          '   New Products',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[300],
            child: GridView.count(

              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.65,
              children: List.generate(
                  homeModel.data!.products.length,
                  (index) => productGridBuilder(
                      homeModel.data!.products[index], context)),
            ),
          ),
        )
      ],
    );

Widget productGridBuilder(ProductModel model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              CachedNetworkImage(
                  height: 200,
                  width: double.infinity,
                  imageUrl: '${model.image}'),
              if (model.discount != 0)
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
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      '${model.price}E.G',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice}E.G',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor:
                      BlocProvider.of<ShopCubit>(context).favorite[model.id]!
                          ? Colors.blue
                          : Colors.grey,
                  radius: 18,
                  child: IconButton(
                      color: Colors.white,
                      iconSize: 20,
                      onPressed: () {
                        BlocProvider.of<ShopCubit>(context)
                            .changeFavorites(model.id!);
                      },
                      icon: const Icon(Icons.favorite_border)),
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buidCategoryItem(DataModel dataModel) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CachedNetworkImage(
          imageUrl: '${dataModel.image}',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            '${dataModel.name}',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
