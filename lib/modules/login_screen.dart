import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/shop_cubit/shop_cubit.dart';
import 'package:shop_app/layouts/home_layout.dart';
import 'package:shop_app/modules/register_screen.dart';
import 'package:shop_app/shared/components/custome_register_text_button.dart';
import 'package:shop_app/shared/components/message_on_screeen.dart';

import '../cubits/login_cubit/login_cubit.dart';
import '../shared/components/custome_text_form_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.loginDate.status!) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeLayout()),
                  (route) => false);
              showMessage(
                  message: state.loginDate.message!, state: ToastState.SUCCESS);
            } else {
              showMessage(
                  message: 'Enter Correct Data', state: ToastState.ERROR);
            }
          } else if (state is LoginFailed) {
            showMessage(message: 'Enter Correct Data', state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 250,
                          height: 250,
                          child: Image.asset('assets/images/login_logo.jpg'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      const Text(
                        'Login Now To Browse Our Products',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      customeTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          hintText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Email can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      customeTextFormField(
                          isPass: true,
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          hintText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Password can not be empty !';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoading,
                        builder: (context) => Container(
                          decoration: BoxDecoration(
                              color: const Color(0xff00C6FF),
                              borderRadius: BorderRadius.circular(8)),
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text);

                                BlocProvider.of<ShopCubit>(context)
                                    .getHomeData();
                              }
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "don't you have an account ?",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          customeTextButtonRegister(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              text: 'Register'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
