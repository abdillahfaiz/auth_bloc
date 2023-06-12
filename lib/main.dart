import 'dart:developer';

import 'package:bloc_auth/bloc/product/create_product/create_product_bloc.dart';
import 'package:bloc_auth/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:bloc_auth/bloc/profile/profile_bloc.dart';
import 'package:bloc_auth/bloc/registration/registration_bloc.dart';
import 'package:bloc_auth/data/dataresources/auth_datasources.dart';
import 'package:bloc_auth/data/dataresources/product_datasources.dart';
import 'package:bloc_auth/data/localresources/auth_local_storage.dart';
import 'package:bloc_auth/data/models/response/profile_response_model.dart';
import 'package:bloc_auth/persentation/pages/login_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login/login_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegistrationBloc(AuthDataSources()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthDataSources()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(AuthDataSources()),
        ),
        BlocProvider(
          create: (context) => GetAllProductBloc(ProductDataSources()),
        ),
        BlocProvider(
          create: (context) => CreateProductBloc(ProductDataSources()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPageScreen(),
      ),
    );
  }
}
