import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/model/cart_provider.dart';
import 'package:shopping_cart/product_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          home: ProductList(),// This trailing comma makes auto-formatting nicer for build methods.
        );
      },)
    );
  }
}
