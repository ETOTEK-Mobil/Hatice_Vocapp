import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabulary_app/cubit/random_cubit.dart';
import 'package:vocabulary_app/cubit/login/login_cubit.dart';
import 'package:vocabulary_app/cubit/register_cubit.dart';
import 'package:vocabulary_app/ui/home_view.dart';
import 'package:vocabulary_app/ui/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(loggedIn: false));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required bool loggedIn});

  Future<bool> _checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token'); // Token kontrolü
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => RandomCubit()),
        BlocProvider(create: (context) => LoginCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
          future: _checkLoggedIn(), //Doğrudan SharedPreferences'tan kontrol
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return snapshot.data == true ? const HomeView() : const LoginView();
          },
        ),
      ),
    );
  }
}
