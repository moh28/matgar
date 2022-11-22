import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit_login/login_cubit.dart';
import '../../shared/cubit/cubit_login/login_states.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../shop/shop_layout.dart';
import '../shop_register_screen.dart';
class LogInScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passWordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(create: (BuildContext context) => LogInCubit(),
        child: BlocConsumer<LogInCubit, LogInStates>(
          listener: (context, state) {
            if (state is LogInSuccessState) {
              if (state.logInModel.status!) {
                print(state.logInModel.message);
                print(state.logInModel.data!.token);

                CacheHelper.saveData(key: 'token', value: state.logInModel.data!.token);
                CacheHelper.getData(key: 'token');
                navigateAndFinish(context, ShopLayOut());
                print('hhhh${CacheHelper.getData(key: 'token')}');
                //CacheHelper.saveData(
                  //      key: 'token', value: state.logInModel.data?.token)
                    //.then((value) {
                      //token=state.logInModel.data?.token;
                      //navigateAndFinish(context, ShopLayOut());});
              } else {
                print(state.logInModel.message);
                showToast(
                    text: state.logInModel.message!, state: ToastStates.ERROR);
              }
            }
          },
          builder: (context, state) {
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
                          Text('LOG IN',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(color: defaultColor)),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'login now to browse our hot offers',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 40.0,
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
                              label: 'Email Address',
                              prefix: Icons.email_outlined),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormFeild(
                            controller: passWordController,
                            isPassword: LogInCubit.get(context).isPass,
                            onSufPress: () {
                              LogInCubit.get(context).changePassVis();
                            },
                            type: TextInputType.visiblePassword,
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                LogInCubit.get(context).userLogIn(
                                    email: emailController.text,
                                    password: passWordController.text);
                              }
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
                            suf: LogInCubit.get(context).suf,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! LogInLoadingState,
                            builder: (context) => defaultButton(
                                text: 'LOG IN',
                                onPress: () {
                                  if (formKey.currentState!.validate()) {
                                    LogInCubit.get(context).userLogIn(
                                        email: emailController.text,
                                        password: passWordController.text);
                                  }
                                }),
                            fallback: (context) =>
                                const Center(child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              defaultTextButton(
                                  onPress: () {
                                    navigateTo(context, ShopRegisterScreen());
                                  },
                                  text: 'register'),
                            ],
                          )
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
