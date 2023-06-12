import 'package:bloc_auth/bloc/login/login_bloc.dart';
import 'package:bloc_auth/bloc/registration/registration_bloc.dart';
import 'package:bloc_auth/data/localresources/auth_local_storage.dart';
import 'package:bloc_auth/data/models/request/login_models.dart';
import 'package:bloc_auth/persentation/pages/home_page_screen.dart';
import 'package:bloc_auth/persentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isLogin();
    super.initState();
  }

  void isLogin() async {
    final isTokenExist = await AuthLocalStorage().isTokenExist();
    if (isTokenExist) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) {
            return HomePageScreen();
          }),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Email',
                    border: InputBorder.none),
                controller: emailController,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Password',
                    border: InputBorder.none),
                controller: passwordController,
              ),
              const SizedBox(
                height: 30.0,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoaded) {
                    print(state.responseModel.accessToken);
                    emailController!.clear();
                    passwordController!.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Succes login'),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) {
                          return HomePageScreen();
                        }),
                      ),
                    );
                  } else if (state is LoginError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text('Login Failed')));
                  }
                  ;
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: Colors.black, size: 20),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final requestModel = LoginModels(
                          email: emailController!.text,
                          password: passwordController!.text);
                      context
                          .read<LoginBloc>()
                          .add(DoLoginEvent(loginModel: requestModel));
                    },
                    child: Text('Login'),
                  );
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return RegisterPageScreen();
                      }),
                    ),
                  );
                },
                child: Text('Dont have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
