
import '../../../models/change_favorites_model.dart';
import '../../../models/login_model.dart';
abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavBarState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopSuccessCategoriesState extends ShopStates{}
class ShopErrorCategoriesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}
class ShopChangeFavoritesState extends ShopStates{}
class ShopErrorChangeFavoritesState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}
class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final LogInModel logInModel;
  ShopSuccessUserDataState(this.logInModel);
}
class ShopErrorUserDataState extends ShopStates{}
class ShopLoadingUserUpDateState extends ShopStates{}
class ShopSuccessUserUpDateState extends ShopStates{
  final LogInModel logInModel;
  ShopSuccessUserUpDateState(this.logInModel);
}
class ShopErrorUserUpDateState extends ShopStates{}