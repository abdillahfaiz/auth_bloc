import 'package:bloc_auth/bloc/registration/registration_bloc.dart';
import 'package:bloc_auth/data/models/request/register_model.dart';
import 'package:bloc_auth/persentation/pages/home_page_screen.dart';
import 'package:bloc_auth/persentation/pages/login_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterPageScreen extends StatefulWidget {
  const RegisterPageScreen({super.key});

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
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
                "Register",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Name',
                    border: InputBorder.none),
                controller: nameController,
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
              BlocConsumer<RegistrationBloc, RegistrationState>(
                listener: (context, state) {
                  if (state is RegistrationLoaded) {
                    nameController!.clear();
                    emailController!.clear();
                    passwordController!.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.greenAccent,
                        content:
                            Text('Succes register with id : ${state.model.id}'),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) {
                          return LoginPageScreen();
                        }),
                      ),
                    );
                  }
                  ;
                },
                builder: (context, state) {
                  if (state is RegistrationLoading) {
                    return Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                          color: Colors.black, size: 20),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final requestModel = RegisterModel(
                          name: nameController!.text,
                          email: emailController!.text,
                          password: passwordController!.text);
                      context
                          .read<RegistrationBloc>()
                          .add(SaveRegisterEvent(request: requestModel));
                    },
                    child: Text('Submit'),
                  );
                },
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) {
                          return LoginPageScreen();
                        }),
                      ),
                    );
                  },
                  child: Text('Have an account? Login'))
            ],
          ),
        ),
      ),
    );
  }
}
