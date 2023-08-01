import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/modules/login_screen.dart';

import '../cubits/shop_cubit/shop_cubit.dart';
import '../shared/components/custome_text_form_field.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text =
            BlocProvider.of<ShopCubit>(context).userData!.name!;
        emailController.text =
            BlocProvider.of<ShopCubit>(context).userData!.email!;
        phoneController.text =
            BlocProvider.of<ShopCubit>(context).userData!.phone!;
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is UpdateUserLoading)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 5,
                    ),
                    customeTextFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      hintText: 'name',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    customeTextFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      hintText: 'email',
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    customeTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      hintText: 'phone',
                      prefixIcon: Icons.phone_android_outlined,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      color: Colors.blue,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<ShopCubit>(context).updateUser(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        }
                      },
                      child: const Text(
                        "Updata",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MaterialButton(
                      minWidth: double.infinity,
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }), (route) => false);
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
