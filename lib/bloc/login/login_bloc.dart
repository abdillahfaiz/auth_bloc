// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:bloc_auth/data/localresources/auth_local_storage.dart';
import 'package:bloc_auth/data/models/response/login_response_model.dart';
import 'package:meta/meta.dart';

import 'package:bloc_auth/data/dataresources/auth_datasources.dart';
import 'package:bloc_auth/data/models/request/login_models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDataSources authDataSources;
  LoginBloc(
    this.authDataSources,
  ) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      try{
      emit(LoginLoading());
      final result = await authDataSources.login(event.loginModel);
      await AuthLocalStorage().saveToken(result.accessToken!);
      emit(LoginLoaded(responseModel: result));
      } catch (e){
        emit(LoginError(message: e.toString()));
      }
    });
  }
}
