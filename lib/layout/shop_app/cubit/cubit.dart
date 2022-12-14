import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/categories/cateogories_screen.dart';
import 'package:shop_app/modules/favourit_screen/favourit.dart';
import 'package:shop_app/modules/product_screen/product.dart';
import 'package:shop_app/modules/sitting/sitting_screen.dart';

import '../../../network/end_points.dart';
import '../../../network/remote/dio_helper.dart';
import '../../../shared/constant/constants.dart';
import '../home_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

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

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value?.data);

      print('object ');
      print(homeModel?.data.banners[0].image);
      print(homeModel?.status);

      for (var element in homeModel!.data.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      }

      //print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
}
