import '../../layout/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context){
 // CacheHelper.removeData(key: 'token');
  CacheHelper.clearData();

  navigateAndFinish(context, LogInScreen());

}
//String? token='';