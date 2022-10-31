import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:taza_khabar/google_sign/google_sign.dart';
import 'dart:math' as math;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final AuthClass _authClass = AuthClass();
  bool isVisible = false;
  bool hasInternet = false;

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Fast Food',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 34,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(.4),
                    blurRadius: 4,
                    offset: Offset(3, 2),
                  ),
                ],
              ),
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/icon.png"),
                ),
              ),
              // child: Image.asset("assets/icon.png"),
            ),
            InkWell(
              onTap: () async {
                final bool hasInternet =
                    await InternetConnectionChecker().hasConnection;
                if (hasInternet == true) {
                  _authClass.handleSignIn(context);
                } else {
                  final text =
                      hasInternet ? null.toString() : 'No Internet Connection';
                  showSimpleNotification(
                    Center(
                      child: Text(text),
                    ),
                    position: NotificationPosition.bottom,
                    background: Theme.of(context).primaryColor,
                  );
                }
              },
              child: SizedBox(
                height: 65,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.rotate(
                            angle: _controller.value * 2.0 * math.pi,
                            child: child,
                          );
                        },
                        child: Image.asset('assets/google.png'),
                      ),
                      Text(
                        'Sign In with Google',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
