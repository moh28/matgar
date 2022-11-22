import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit_shop_layout/shop_layout_cubit.dart';
import '../../shared/cubit/cubit_shop_layout/shop_layout_states.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context) =>ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data[index].product!,context),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
          ),
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}