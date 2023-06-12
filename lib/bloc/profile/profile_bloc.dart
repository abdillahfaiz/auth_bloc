// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_auth/data/localresources/auth_local_storage.dart';
import 'package:meta/meta.dart';

import 'package:bloc_auth/data/dataresources/auth_datasources.dart';
import 'package:bloc_auth/data/models/response/profile_response_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthDataSources authDataSources;
  
  ProfileBloc(
    this.authDataSources,
  ) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      try {
        emit(ProfileLoading());
        final result = await authDataSources.getProfile();
        await AuthLocalStorage().getToken();
        emit(ProfileLoaded(profileResponseModel: result));
      } catch (e) {
        emit(ProfileError(message: "Error ${e.toString()}"));
      }
    });
  }
}
