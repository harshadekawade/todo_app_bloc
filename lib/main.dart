import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_bloc/bloc/todo_bloc.dart';
import 'package:todo_app_bloc/ui/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO App',
        theme: ThemeData(
            snackBarTheme: SnackBarThemeData(
                contentTextStyle: GoogleFonts.roboto(
                    fontStyle: FontStyle.normal, color: Colors.white),
                backgroundColor: Colors.black,
                insetPadding: const EdgeInsets.all(20)),
            primarySwatch: Colors.teal,
            useMaterial3: false,
            textTheme: GoogleFonts.robotoTextTheme(
              Theme.of(context).textTheme,
            )),
        home: const TodoScreen(),
      ),
    );
  }
}
