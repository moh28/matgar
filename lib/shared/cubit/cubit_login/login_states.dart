
import '../../../models/login_model.dart';

abstract class LogInStates{}
class LogInInitialState extends LogInStates{}
class LogInLoadingState extends LogInStates{}
class LogInSuccessState extends LogInStates{
  final LogInModel logInModel;
  LogInSuccessState(this.logInModel);

}
class LogInErrorState extends LogInStates{
  final String error;
  LogInErrorState(this.error);

}
class LogChangePassVisState extends LogInStates{}