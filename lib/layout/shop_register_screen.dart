import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/layout/shop/shop_layout.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/register_cubit/register_cubit.dart';
import '../shared/cubit/register_cubit/register_states.dart';
import '../shared/network/local/cache_helper.dart';
import '../shared/styles/colors.dart';
class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passWordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if (state is RegisterSuccessState) {
            if (state.logInModel.status!) {
              print(state.logInModel.message);
              print(state.logInModel.data!.token);
              CacheHelper.saveData(key: 'token', value: state.logInModel.data!.token);
              CacheHelper.getData(key: 'token');
              navigateAndFinish(context, ShopLayOut());
              print('hhhh${CacheHelper.getData(key: 'token')}');

              //CacheHelper.saveData(
                //  key: 'token', value: state.logInModel.data?.token)
                  //.then((value) {
                //token=state.logInModel.data?.token;
               // navigateAndFinish(context, ShopLayOut());});
            } else {
              print(state.logInModel.message);
              showToast(
                  text: state.logInModel.message!, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(title: const Text('MA^!^GR',style: TextStyle(color: defaultColor)),),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: defaultColor)),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defaultFormFeild(
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'user name must not be empty';
                              } else {
                                return null;
                              }
                            },
                            label: 'User Name',
                            prefix: Icons.person),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFeild(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'email must not be empty';
                              } else {
                                return null;
                              }
                            },
                            label: 'Email',
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFeild(
                          controller: passWordController,
                          isPassword: RegisterCubit.get(context).isPass,
                          onSufPress: () {
                            RegisterCubit.get(context).changeRegisterPassVis();
                          },
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                           // if (formKey.currentState!.validate()) {
                             // RegisterCubit.get(context).userRegister(
                               //   email: emailController.text,
                                 // password: passWordController.text, phone: phoneController.text, name: nameController.text);
                            //}
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password must not be empty';
                            } else {
                              return null;
                            }
                          },
                          label: 'PASSWORD',
                          prefix: Icons.lock_outlined,
                          suf: RegisterCubit.get(context).suf,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormFeild(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'phone number must not be empty';
                              } else {
                                return null;
                              }
                            },
                            label: 'Phone Number',
                            prefix: Icons.phone),
                        const SizedBox(
                          height: 25.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                              text: 'REGISTER',
                              onPress: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passWordController.text,phone: phoneController.text, name: nameController.text);
                                }
                              }),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),

                      ],
                    ),
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
