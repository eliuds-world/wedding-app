import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:mywedding/guest_book.dart';
import 'package:provider/provider.dart';
import 'widgets.dart';
import 'app_state.dart';
import 'authentication.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Wedding"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //cover Image(assets)
              Image.asset("assets/wedding.jpg"),
              const SizedBox(height: 8),
              //custom widgets
              IconAndText(Icons.calendar_today, "Jan 1"),
              IconAndText(Icons.location_city, "California"),

              //it ensures that the ui is updated based on the current state,and rebuids its child widgets when the state changes
              Consumer<ApplicationState>(
                builder: (context, appState, _) => AuthFunc(
                  loggedIn: appState.loggedIn,
                  signOut: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ),
              Text("We are getting married join us"),
              // GuestBook(addMessage: (message) async =>   print(message)),
              Consumer<ApplicationState>(
                builder: (context, appState, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (appState.loggedIn) ...[
                      Text("Messages"),
                      GuestBook(
                        addMessage: (message) async =>
                            appState.addMessageToGuestBook(message), 
                            messages:appState.guestBookMessages,
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
