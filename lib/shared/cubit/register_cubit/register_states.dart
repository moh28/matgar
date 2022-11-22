
import '../../../models/login_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final LogInModel logInModel;
  RegisterSuccessState(this.logInModel);

}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);

}
class RegisterChangePassVisState extends RegisterStates{}