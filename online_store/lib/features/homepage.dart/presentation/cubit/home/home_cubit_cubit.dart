import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:online_store/features/homepage.dart/data/data_source/remote/urls.dart';
import 'package:online_store/features/homepage.dart/data/models/product_model.dart';
import 'package:online_store/features/homepage.dart/data/repository/api_service.dart';
part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  HomeCubitCubit() : super(HomeCubitInitial());

  List<HomePageModel>? homePageModel;
  List<String>? categories = [];

  Future getProducts() async {
    emit(LoadingState());

    // int limit = 10;

    try {
      final Response response =
          await ApiServiceProduct.getProduct(url: productUrl);
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        homePageModel = homePageModelFromJson(response.body);
        log(homePageModel.toString());
        emit(DataLoadedState(homePageModel!));
      } else {
        emit(ErrorState(
            message:
                'Failed to load data. Status code:${response.statusCode}'));
      }
    } catch (e) {
      emit(ErrorState(message: 'Error: $e'));
    }
  }

  Future getCategories() async {
    try {
      final Response response =
          await ApiServiceCategory.getCategory(url: categoryUrl);
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        List<String> responseList =
            List<String>.from(jsonDecode(response.body));
        categories = responseList;
        log(categories?.length.toString() ?? '');
      } else {
        emit(ErrorState(
            message:
                'Failed to load data. Status code:${response.statusCode}'));
      }
    } catch (e) {
      emit(ErrorState(message: 'Error: $e'));
    }
  }
}
