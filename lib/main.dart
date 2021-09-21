import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/home_screen/home_layout.dart';
import 'package:shop_app/modules/home_screen/shop_cubit/shop_cubit.dart';
import 'package:shop_app/modules/login/loginscreen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/on_boarding/on_boarding_screen.dart';


Future<void> _backgroundMessageHandler(RemoteMessage message) async
{
  print('background message');
  Fluttertoast.showToast(
    msg: 'background message',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');
  token = CacheHelper.getData(key: 'token');


  if (onBoarding != null) {
    if (uId != null) {
      print(uId);
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = On_boarding_Screen();
  }


  runApp(MyApp(
    onBoarding: onBoarding, startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool onBoarding;
  final Widget startWidget;

  const MyApp({this.onBoarding, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //     create: (BuildContext context) =>
        //     ShopCubit()
        //       ..getHomeDate()
        //       ..getCategoriesDate()
        //       ..getFavorites()
        //       ..getUserData()),
        BlocProvider(
            create: (BuildContext context) =>
            ShopCubit()..getUserData()..getHomeDate()
              ..getFavorites()..getCategoriesDate()

        ),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter',
          theme: lightTheme,
          home: startWidget
      ),
    );
  }
}


