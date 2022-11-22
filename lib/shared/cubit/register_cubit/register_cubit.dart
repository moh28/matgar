import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matgar/shared/cubit/register_cubit/register_states.dart';
import '../../../models/login_model.dart';
import '../../network/remote/dio_helper.dart';
import '../../network/remote/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  LogInModel? logInModel;
  void userRegister({
    required String? email,
    required String? password,
    required String? name,
    required String? phone,


  }){
    emit(RegisterLoadingState());
    DioHelper.postData
      (
        url: Register,
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,

        }).then((value) {
      print(value.data.toString());
      logInModel=LogInModel.fromJson(value.data);
     // print(logInModel!.status);
      //print(logInModel!.message);
      //print(logInModel!.data!.token);
      emit(RegisterSuccessState(logInModel!));
    })
        .catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
  IconData suf=Icons.visibility_outlined;
  bool isPass=true;
  void changeRegisterPassVis(){
    isPass= !isPass;
    suf=isPass?Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(RegisterChangePassVisState());

  }
}