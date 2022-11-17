import 'package:first_app/modules/shop_app/Login/shop_login_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/networks/local/cache_helper.dart';
import 'package:flutter/material.dart';

List<Map> tasks = [];

// POST
// UPDATE
// DELETE

// GET

// base url : https://newsapi.org/
// method (url) : v2/top-headlines?
// queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        ShopLoginScreen(),
      );
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = '';

String? uId;

String commentHero = 'commentHero';
