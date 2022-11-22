import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/cubit_shop_layout/shop_layout_cubit.dart';
import '../../shared/cubit/cubit_shop_layout/shop_layout_states.dart';
import '../../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // if(state is ShopSuccessUserDataState){
        // nameController.text=state.logInModel.data!.name;
        //emailController.text=state.logInModel.data!.email;
        //phoneController.text=state.logInModel.data!.phone;
        //}
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if(state is ShopLoadingUserUpDateState)
                    const LinearProgressIndicator(color: defaultColor,),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormFeild(
                        controller: nameController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          } else {
                            return null;
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormFeild(
                        controller: emailController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'email must not be empty';
                          } else {
                            return null;
                          }
                        },
                        label: 'Email',
                        prefix: Icons.email_outlined),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormFeild(
                        controller: phoneController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'phone must not be empty';
                          } else {
                            return null;
                          }
                        },
                        label: 'Phone',
                        prefix: Icons.phone),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        text: 'UpDate',
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).putUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        text: 'Log Out',
                        onPress: () {
                          signOut(context);
                        })
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
