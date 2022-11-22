
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/login_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../network/remote/end_points.dart';
import 'login_states.dart';
class LogInCubit extends Cubit<LogInStates>{
  LogInCubit():super(LogInInitialState());
  static LogInCubit get(context)=>BlocProvider.of(context);
   LogInModel? logInModel;
  void userLogIn({
  required String? email,
    required String? password

}){
    emit(LogInLoadingState());
    DioHelper.postData
      (
        url: LOGIN,
        data: {
          'email':email,
          'password':password,

    }).then((value) {
        print(value.data.toString());
        logInModel=LogInModel.fromJson(value.data);
        print(logInModel!.status);

        print(logInModel!.message);
        print(logInModel!.data!.token);
      emit(LogInSuccessState(logInModel!));
    })
        .catchError((error){
      print(error.toString());
       emit(LogInErrorState(error.toString()));
     });
  }
  IconData suf=Icons.visibility_outlined;
  bool isPass=true;
  void changePassVis(){
    isPass= !isPass;
    suf=isPass?Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(LogChangePassVisState());

  }
}