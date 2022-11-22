import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/search/search_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit_shop_layout/shop_layout_cubit.dart';
import '../../shared/cubit/cubit_shop_layout/shop_layout_states.dart';
import '../../shared/styles/colors.dart';
class ShopLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
        create: (BuildContext context) => ShopCubit()
          ..getHomeData()
          ..getCategoriesData()
          ..getFavoritesData()
          ..getUserData(),

       child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('MA^!^GR',style: TextStyle(color: defaultColor),),
              actions: [IconButton(onPressed: (){
                navigateTo(context,  SearchScreen());
              }, icon: const Icon(Icons.search,color: defaultColor,))],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottomNavBar(index);
              },
              currentIndex: cubit.currentIndex,
              items: const [
              BottomNavigationBarItem(icon:Icon(Icons.home) ,label:'Home', ),
              BottomNavigationBarItem(icon:Icon(Icons.category_outlined) ,label:'Categories', ),
              BottomNavigationBarItem(icon:Icon(Icons.favorite_border_outlined) ,label:'Favorites', ),
              BottomNavigationBarItem(icon:Icon(Icons.settings) ,label:'Settings', ),
            ],),
          );
        },
    ),
     );
  }
}
