
import 'package:flutter/material.dart';
import 'package:flutter_application_clean/domain/usercases/get_user_detail.dart';
import 'package:flutter_application_clean/domain/usercases/get_users.dart';
import 'package:flutter_application_clean/presentation/screens/user_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/data_providers/user_api.dart';
import 'presentation/screens/user_list_screen.dart';

void main() {
  final UserRepositoryImpl userRepository = UserRepositoryImpl(UserApi());

  runApp(SportGoApp(userRepository: userRepository));
}

class SportGoApp extends StatelessWidget {
  final UserRepositoryImpl userRepository;

  SportGoApp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepositoryImpl>(
          create: (context) => userRepository,
        ),
        RepositoryProvider<GetUsers>(
          create: (context) => GetUsers(userRepository),
        ),
        RepositoryProvider<GetUserDetail>(
          create: (context) => GetUserDetail(userRepository),
        ),
      ],
      child: MaterialApp(
        title: 'SportGo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
         fontFamily: "SFProDisplay",
        ),
        home: UserListScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == '/userDetail') {
            final args = settings.arguments as int;
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => UserDetailScreen(userId: args),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: curve,
                );

                return SlideTransition(
                  position: tween.animate(curvedAnimation),
                  child: child,
                );
              },
            );
          }
          return null;
        },
      ),
    );
  }
}
