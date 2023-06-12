// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bloc_auth/data/dataresources/auth_datasources.dart';
import 'package:bloc_auth/data/models/request/register_model.dart';
import 'package:bloc_auth/data/models/response/register_response_model.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthDataSources dataSources;
  RegistrationBloc(
    this.dataSources,
  ) : super(RegistrationInitial()) {
    on<SaveRegisterEvent>((event, emit) async {
      emit(RegistrationLoading());
      final result = await dataSources.register(event.request);
      print(result.toString());
      emit(RegistrationLoaded(model: result));
    });
  }
}
