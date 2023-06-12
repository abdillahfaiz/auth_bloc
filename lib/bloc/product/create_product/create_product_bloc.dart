// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:bloc_auth/data/dataresources/product_datasources.dart';
import 'package:meta/meta.dart';

// import 'package:bloc_auth/data/dataresources/auth_datasources.dart';
import 'package:bloc_auth/data/models/request/product_model.dart';
import 'package:bloc_auth/data/models/response/product_response_model.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  final ProductDataSources productDataSources;
  CreateProductBloc(
    this.productDataSources,
  ) : super(CreateProductInitial()) {
    on<DoCreateProduct>((event, emit) async {
      try{
      emit(CreateProductLoading());
      final result = await productDataSources.createProduct(event.productModel);
      emit(CreateProductLoaded(productResponseModel: result));
      } catch (e) {
      emit(CreateProductError(message: 'Failed to Create Product'));
      }
    });
  }
}
