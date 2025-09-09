import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/features/login/login_repo.dart';
import 'package:ecommerce_app/features/login/models/login_request.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;

  LoginCubit(this.loginRepo) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      emit(LoginFailure('Please fill all fields'));
      return; 

    }

    emit(LoginLoading());

    final result = await loginRepo.loginAndCacheUser(
      LoginRequest(username: username, password: password),
    );

    if (result["success"]) {
      emit(LoginSuccess(result['token']));
    } else {
      emit(LoginFailure(result['message']));
    }
  }
}
