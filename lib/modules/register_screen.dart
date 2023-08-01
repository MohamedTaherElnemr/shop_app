import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/register_cubit/register_cubit.dart';
import '../layouts/home_layout.dart';
import '../shared/components/custome_text_form_field.dart';
import '../shared/components/message_on_screeen.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          if (state.RegisterDate.status!) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeLayout()),
                (route) => false);
            showMessage(
                message: state.RegisterDate.message!,
                state: ToastState.SUCCESS);
          } else {
            showMessage(message: 'Enter Correct Data', state: ToastState.ERROR);
          }
        } else if (state is RegisterFailed) {
          showMessage(message: 'Enter Correct Data', state: ToastState.ERROR);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
          ),
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
                      'REGIESTER',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Text(
                      'Register Now To Browse Our Products',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    customeTextFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        hintText: 'name',
                        prefixIcon: Icons.person,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'name can not be empty !';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    customeTextFormField(
                        isPass: false,
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        hintText: 'email',
                        prefixIcon: Icons.email_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'email can not be empty !';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    customeTextFormField(
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
                    customeTextFormField(
                        isPass: false,
                        controller: phoneController,
                        type: TextInputType.phone,
                        hintText: 'phone',
                        prefixIcon: Icons.phone_android_outlined,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Password can not be empty !';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff00C6FF),
                          borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context)
                                .userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passController.text,
                                    phone: phoneController.text);
                          }
                        },
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
