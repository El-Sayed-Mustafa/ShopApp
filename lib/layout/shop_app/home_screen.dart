import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login.dart';
import 'package:shop_app/network/local/chash_helper.dart';
import 'package:shop_app/shared/component/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sella')
      ),
      body: TextButton(
        onPressed: () {
          CashHelper.removeData(key: 'token').then((value) {
            if(value==true){
              navigateAndFinish(context, LoginScreen());
            }
          });
        },
        child: const Text('Logout'),
      ),
    );
  }
}
