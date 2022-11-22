import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/shared/cubit/search_cubit/search_states.dart';
import '../../../models/search_model.dart';
import '../../network/local/cache_helper.dart';
import '../../network/remote/dio_helper.dart';
import '../../network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: Search, token: CacheHelper.getData(key: 'token'), data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
