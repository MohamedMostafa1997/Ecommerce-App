import 'package:ecommerce_app/core/dependency_injection/dependency_injection.dart';
import 'package:ecommerce_app/core/routing/app_router.dart';
import 'package:ecommerce_app/core/routing/route_names.dart';
import 'package:ecommerce_app/observer/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RouteNames.init,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
