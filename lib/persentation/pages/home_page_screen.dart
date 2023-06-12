// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:bloc_auth/bloc/product/create_product/create_product_bloc.dart';
import 'package:bloc_auth/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:bloc_auth/bloc/profile/profile_bloc.dart';
import 'package:bloc_auth/data/dataresources/auth_datasources.dart';
import 'package:bloc_auth/data/localresources/auth_local_storage.dart';
import 'package:bloc_auth/data/models/request/product_model.dart';
import 'package:bloc_auth/persentation/pages/login_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<GetAllProductBloc>().add(DoGetAllProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthLocalStorage().removeToken();
              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return const LoginPageScreen();
                  }),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(builder: ((context, state) {
              if (state is ProfileLoading) {
                return LoadingAnimationWidget.inkDrop(
                    color: Colors.black, size: 50);
              }
              if (state is ProfileLoaded) {
                return Column(
                  children: [
                    Text(
                      'Good Morning ${state.profileResponseModel.name}' ??
                          '${state.toString()}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),

                    // Text(
                    //   state.profileResponseModel.email ?? '${state.toString()}',
                    //   style: const TextStyle(fontSize: 30),
                    // ),
                  ],
                );
              }
              return const Text('Error');
            })),
            Expanded(
              child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
                builder: ((context, state) {
                  if (state is GetAllProductLoading) {
                    return Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: Colors.black, size: 50),
                    );
                  }
                  if (state is GetAllProductLoaded) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.listProductResponseModel.length,
                        itemBuilder: ((context, index) {
                          final product = state.listProductResponseModel[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(product.price.toString()),
                              ),
                              title: Text(product.title ?? ''),
                              subtitle: Text(product.description ?? ''),
                              trailing: const Icon(Icons.edit_note_sharp),
                              // subtitle: Text(product.description ?? '${state.toString()}' ),
                            ),
                          );
                        }));
                  }
                  return const Text('No Data');
                }),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: const Text('Add New Product'),
      //             content: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 TextField(
      //                   decoration: const InputDecoration(
      //                       icon: Icon(Icons.abc),
      //                       hintText: 'Title',
      //                       border: InputBorder.none),
      //                   controller: titleController,
      //                 ),
      //                 TextField(
      //                   decoration: const InputDecoration(
      //                       icon: Icon(Icons.monetization_on_outlined),
      //                       hintText: 'Price',
      //                       border: InputBorder.none),
      //                   controller: descController,
      //                   keyboardType: TextInputType.number,
      //                 ),
      //                 TextField(
      //                   decoration: const InputDecoration(
      //                       icon: Icon(Icons.description),
      //                       hintText: 'Description',
      //                       border: InputBorder.none),
      //                   controller: priceController,
      //                 ),
      //               ],
      //             ),
      //             actions: [
      //               TextButton(
      //                 onPressed: () {
      //                   Navigator.pop(context);
      //                 },
      //                 child: const Text(
      //                   'Cancel',
      //                   style: TextStyle(
      //                     color: Colors.red,
      //                   ),
      //                 ),
      //               ),
      //               BlocListener<CreateProductBloc, CreateProductState>(
      //                 listener: (context, state) {
      //                   if (state is CreateProductLoaded) {
      //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //                         content:
      //                             Text('${state.productResponseModel.id}')));
      //                     Navigator.pop(context);
      //                     context
      //                         .read<GetAllProductBloc>()
      //                         .add(DoGetAllProduct());
      //                   }
      //                 },
      //                 child: BlocBuilder<CreateProductBloc, CreateProductState>(
      //                     builder: (context, state) {
      //                   if (state is CreateProductLoaded) {
      //                     return const Center(
      //                       child: CircularProgressIndicator(),
      //                     );
      //                   }
      //                   return TextButton(
      //                     onPressed: () {
      //                       final product = ProductModel(
      //                           title: titleController.text,
      //                           price: int.parse(priceController.text),
      //                           description: descController.text);
      //                       context
      //                           .read<CreateProductBloc>()
      //                           .add(DoCreateProduct(productModel: product));
      //                     },
      //                     child: const Text(
      //                       'Submit',
      //                       style: TextStyle(
      //                         color: Colors.green,
      //                       ),
      //                     ),
      //                   );
      //                 }),
      //               ),
      //             ],
      //           );
      //         });
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
