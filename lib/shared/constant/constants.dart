import '../../modules/login/login.dart';
import '../../network/local/chash_helper.dart';
import '../component/components.dart';

void logout(context){
  CashHelper.removeData(key: 'token').then((value) {
    if(value==true){
      navigateAndFinish(context, LoginScreen());
    }
  });
}

String token ='';