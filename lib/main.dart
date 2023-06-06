import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_clean_arc/feature/presentation/bloc/get_all_persons_bloc/get_all_persons_bloc.dart';
import 'package:udemy_clean_arc/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:udemy_clean_arc/feature/presentation/pages/person_screen.dart';
import 'package:udemy_clean_arc/locator_service.dart' as di;
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetAllPersonsBloc>(
          create: (context) => sl<GetAllPersonsBloc>()..add(GetPersonsEvent()),
        ),
        BlocProvider<PersonSearchBloc>(
          create: (context) => sl<PersonSearchBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
