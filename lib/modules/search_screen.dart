import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/search_cubit/search_cubit.dart';
import 'package:shop_app/cubits/shop_cubit/shop_cubit.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/components/custome_text_form_field.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  customeTextFormField(
                    controller: searchController,
                    onChanged: (text) {
                      BlocProvider.of<SearchCubit>(context).search(text: text);
                    },
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    hintText: 'What You Search About ?',
                    prefixIcon: Icons.search,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (state is SearchLoading) const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is SearchSuccess)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildSearchItem(
                              BlocProvider.of<SearchCubit>(context)
                                  .searchModel!
                                  .data!
                                  .products![index],
                              context),
                          separatorBuilder: (context, index) => Divider(
                                thickness: 3,
                                color: Colors.black.withOpacity(0.3),
                              ),
                          itemCount: BlocProvider.of<SearchCubit>(context)
                              .searchModel!
                              .data!
                              .products!
                              .length),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildSearchItem(ProductSearch model, context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            CachedNetworkImage(
                height: 120,
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
                '${model.name}',
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
                  if (1 != 0)
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
    );
