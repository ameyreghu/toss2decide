import 'package:flutter/material.dart';
import 'package:toss2decide/cubits/toss/toss_cubit.dart';
import 'package:toss2decide/screens/toss_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TossCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Toss2Decide',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const TossScreen(),
      ),
    );
  }
}
