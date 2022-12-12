import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'AppStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(ShopInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

/*  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
    }

    CashHelper.putDate(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeModeAppState());
    });
  }*/
}
