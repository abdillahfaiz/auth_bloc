// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class DoLoginEvent extends LoginEvent {
  final LoginModels loginModel;
  DoLoginEvent({
    required this.loginModel,
  });
}
