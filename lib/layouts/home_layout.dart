import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/search_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit = BlocProvider.of<ShopCubit>(context);
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ))
            ],
            title: const Text(
              'SHOPY',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            iconSize: 30,
            currentIndex: shopCubit.currentIndex,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              shopCubit.changeBottom(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                  ),
                  label: 'Categories'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings'),
            ],
          ),
          body: shopCubit.screens[shopCubit.currentIndex],
        );
      },
    );
  }
}
