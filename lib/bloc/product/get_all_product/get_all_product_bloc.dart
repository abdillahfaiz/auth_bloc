// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bloc_auth/data/dataresources/product_datasources.dart';
import 'package:bloc_auth/data/models/response/product_response_model.dart';

part 'get_all_product_event.dart';
part 'get_all_product_state.dart';

class GetAllProductBloc extends Bloc<GetAllProductEvent, GetAllProductState> {

  final ProductDataSources productDataSources;
  
  GetAllProductBloc(
    this.productDataSources,
  ) : super(GetAllProductInitial()) {

    on<DoGetAllProduct>((event, emit) async {
      emit(GetAllProductLoading());
      final result = await productDataSources.getAllProduct();
      emit(GetAllProductLoaded(listProductResponseModel: result));
    });
  }
}
