import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/categories/cateogories_screen.dart';
import 'package:shop_app/modules/favourit_screen/favourit.dart';
import 'package:shop_app/modules/product_screen/product.dart';
import 'package:shop_app/modules/sitting/sitting_screen.dart';

import '../../../models/categories_model.dart';
import '../../../models/change_favourit.dart';
import '../../../network/end_points.dart';
import '../../../network/remote/dio_helper.dart';
import '../../../shared/constant/constants.dart';
import '../home_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int counter = 0;
  List<Widget> bottomScreen = [
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SittingScreen()
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopBottomNavState());
  }

  HomeModel? homeModel;

  Map<int, bool> favorite = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());


    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value?.data);

      for (var element in homeModel!.data.products) {
        favorite.addAll({
          element.id: element.inFavorites,
        });
      }
      print(homeModel?.data.products[0].id);
      print(favorite.toString());
      counter++;
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  ChangeFavoritesModel? changeFavoritesModel;

  void getCategories() {
    DioHelper.getData(
      url: categories, token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value?.data);
      counter++;
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  void changeFavorites(int productId) {
    favorite[productId] = !favorite[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: favorites,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value?.data);
      print(value?.data);
/*
      if (!changeFavoritesModel.status) {
        favorite[productId] = !favorite[productId]!;
      } else {
        getFavorites();
      }*/

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorite[productId] = !favorite[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }
}
