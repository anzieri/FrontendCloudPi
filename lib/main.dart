import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remotefilesystem/home/otherhome.dart';
import 'package:remotefilesystem/index.dart';
import 'package:remotefilesystem/layout_body/layout_body.dart';
import 'package:remotefilesystem/login/authprovider.dart';
import 'package:remotefilesystem/login/login.dart';
import 'package:remotefilesystem/register/register.dart';


Future<void> main() async {
  print('Starting app initialization...');
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.dotenv.load(fileName: "assets/.env")
    .then((_) => print('ENV loaded, SERVER_IP: ${dotenv.dotenv.env['SERVER_IP']}'))
    .catchError((error) {
      print('Error loading .env file: $error');
    });
  
  usePathUrlStrategy();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider()..loadToken(),
      child: const MyApp(),
    ),
  );
}


final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey ,
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
          return Integrate(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          
          routes: [
            GoRoute(
            name: 'home', // Optional, add name to your routes. Allows you navigate by name instead of path
            path: '/',
            builder: (BuildContext context, GoRouterState state) => const LayoutTemplate(),
            pageBuilder: (BuildContext context, GoRouterState state) => buildPageWithoutAnimation(
              context: context, 
              state: state, 
              child: LayoutTemplate(),
            ),),
            GoRoute(
            name: 'Login',
            path: '/login',
            builder: (BuildContext context, GoRouterState state) => const LoginUI(),
            pageBuilder: (BuildContext context, GoRouterState state) => buildPageWithoutAnimation(
              context: context, 
              state: state, 
              child: LoginUI(),
            ),
     
            ),

        ]),
        
      ],
    ),
    //here
    GoRoute(
            name: 'register',
            path: '/register/:role',
            builder: (BuildContext context, GoRouterState state){
              final role = state.pathParameters['role']!;
              return RegisterUI(role: role,);
            },
            pageBuilder: (BuildContext context, GoRouterState state) {
              final role = state.pathParameters['role']!;
              return buildPageWithoutAnimation(
                context: context, 
                state: state, 
                child: RegisterUI(role: role,),
              );
            },),
    GoRoute(
      name: 'MainHome',
      path: '/piedrive',
      builder: (BuildContext context, GoRouterState state) => const Pagey(),
      pageBuilder: (BuildContext context, GoRouterState state) => buildPageWithoutAnimation(
      context: context, 
      state: state, 
      child: Pagey(),
      ),
      
    ),
    GoRoute(
      name: 'client',
      path: '/client',
      builder: (BuildContext context, GoRouterState state) => const Pagey(),
      pageBuilder: (BuildContext context, GoRouterState state) => buildPageWithoutAnimation(
      context: context, 
      state: state, 
      child: const Pagey(),
      ),
      redirect: (BuildContext context, GoRouterState state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (!authProvider.isAuthenticated || authProvider.role != 'CLIENT') {
        return '/login';
      }
      return null;
      },
    ),
    ],
  );
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}


CustomTransitionPage<void> buildPageWithoutAnimation({
  required BuildContext context, 
  required GoRouterState state, 
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => child
  );
}