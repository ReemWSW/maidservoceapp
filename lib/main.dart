import 'package:flutter/material.dart';
import 'package:maid/pages/login/login.dart';
import 'package:provider/provider.dart';

import 'providers/order_provider.dart';
import 'widget/bottombar.dart';
import 'providers/auth.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: 'Maid Service',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
