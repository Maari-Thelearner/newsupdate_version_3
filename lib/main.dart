import 'package:flutter/material.dart';
import 'package:newsupdate_newversion/blocs/auth_bloc.dart';
import 'package:newsupdate_newversion/login.dart';
import 'package:newsupdate_newversion/theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthBloc(),),
      ],
      child: ChangeNotifierProvider(
            create: (_) => ThemeNotifier(),
            child: Consumer<ThemeNotifier>(
              builder: (context, ThemeNotifier notifier, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'NewsUpdate',
                  theme: notifier.darkTheme ? dark : light,
                  home: LoginScreen(),
                );
              },
            ),
          ),
    );
  }
}
