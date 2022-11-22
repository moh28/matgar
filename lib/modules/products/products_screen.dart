
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit_shop_layout/shop_layout_cubit.dart';
import '../../shared/cubit/cubit_shop_layout/shop_layout_states.dart';
import '../../shared/styles/colors.dart';
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status){
            showToast(text:state.model.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
            builder: (context) =>
                productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(
    HomeModel? model, CategoriesModel? categoriesModel,context
  ) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model?.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 230.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                        color: defaultColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 90,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesItem(categoriesModel!.data.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10.0,
                            ),
                        itemCount: categoriesModel!.data.data.length),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                        color: defaultColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.61,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(model!.data.products.length,
                    (index) => gridViewBuilder(model.data.products[index],context)),
              ),
            ),
          ],
        ),
      );

  Widget gridViewBuilder(ProductModel model,context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 180,
                ),
                if (model.discount != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    color: defaultColor,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 10.0, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.3, fontSize: 14.0),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: const TextStyle(
                            fontSize: 12.0, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 7.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon:  CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context).favorites[model.id] == null || ShopCubit.get(context).favorites[model.id] == true ? defaultColor : Colors.grey ,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),

                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
           Image(
            image: NetworkImage(
              model.image
            ),
            width: 90.0,
            height: 90.0,
            fit: BoxFit.cover,
          ),
          Container(
              color: defaultColor.withOpacity(.7),
              width: 90.0,
              child:  Text(
                model.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              )),
        ],
      );
}
