import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/shared/cubit/cubit_shop_layout/shop_layout_states.dart';
import '../../../models/categories_model.dart';
import '../../../models/change_favorites_model.dart';
import '../../../models/favorites_model.dart';
import '../../../models/home_model.dart';
import '../../../models/login_model.dart';
import '../../../modules/categories/categories_screen.dart';
import '../../../modules/favorites/favorites_screen.dart';
import '../../../modules/products/products_screen.dart';
import '../../../modules/settings/settings_screen.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';
import '../../network/remote/end_points.dart';
import 'package:flutter/material.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
     ProductsScreen(),
     CategoriesScreen(),
     FavoritesScreen(),
     SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: Home,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel?.data.banners[0].image);
      homeModel!.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: getCategories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      //print('$token=token');

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
            url: Favorites, data: {'product_id': productId}, token: CacheHelper.getData(key: 'token'))
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      }else{
        getFavoritesData();
      }
      print(value.data);
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }
  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: Favorites,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //print('$token=token');
      print(value.data.toString());

      emit(ShopSuccessGetFavoritesState());

    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorGetFavoritesState());
    });
  }
  LogInModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: getProfile,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      print('zzzz${CacheHelper.getData(key: 'token')}');
      userModel = LogInModel.fromJson(value.data);
      //print('$token=token');
      print(userModel!.data!.name);

      emit(ShopSuccessUserDataState(userModel!));

    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorUserDataState());
    });
  }
  void putUserData({required String name,required String email,required String phone}) {
    emit(ShopLoadingUserUpDateState());
    DioHelper.putData(
      url: upDateProfile,
      token: CacheHelper.getData(key: 'token'), data: {
        'name':name,
      'email':email,
      'phone':phone,
    },
    ).then((value) {
      userModel = LogInModel.fromJson(value.data);
      //print('$token=token');
      print(userModel!.data!.name);

      emit(ShopSuccessUserUpDateState(userModel!));

    }).catchError((error) {
      print(error.toString());

      emit(ShopErrorUserUpDateState());
    });
  }
}
