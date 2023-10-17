import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
}

final router = GoRouter(
  routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => HomeScreen(), 
    routes: [
    GoRoute(
      path: "sign-in",
      builder: (context, state) {
        return SignInScreen( 
          actions: [
            ForgotPasswordAction(((context, email) {
              final uri = Uri(
                path: "/sign-in/forgot-password",
                queryParameters: <String, String?>{
                  "email": email,
                },
              );
              context.push(uri.toString());
            })),
            AuthStateChangeAction(((context, state) {
              if (state is SignedIn || state is UserCreated) {
                var user = (state is SignedIn)
                    ? state.user
                    : (state as UserCreated).credential.user;
                if (user == null) {
                  return;
                }
                if (state is UserCreated) {
                  user.updateDisplayName(user.email?.split("@")[0]);
                }
                if (!user.emailVerified) {
                  user.sendEmailVerification();
                  const snackBar = SnackBar(
                      content: Text(
                          "Please check your email to verify your email adress"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                context.pushReplacement("/");
              }
            })),
          ],
        );
      },
      routes: [
        GoRoute(
          path: "forgot-password",
          builder: (context, state) {
            //changed this code
            final arguments = state.uri.queryParameters;
            return ForgotPasswordScreen(
              email: arguments["email"],
              headerMaxExtent: 200,
            );
          },
        ),
      ],
    ),
  ])
]);

mixin queryParemeters {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Wedding RSVP App",
      theme: ThemeData(primarySwatch: Colors.amber),
      routerConfig: router,
    );
  }
}
