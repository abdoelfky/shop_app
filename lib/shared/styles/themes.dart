import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme=ThemeData(
    appBarTheme: AppBarTheme(
        elevation: .4,
        backwardsCompatibility: false,
        backgroundColor: Colors.white
    ),
    primarySwatch: Colors.lightBlue,
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 30.0,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: Colors.blue[600]
    )
);