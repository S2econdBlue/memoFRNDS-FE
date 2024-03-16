import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

final GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnimatedBackground();
  }
}

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  // Future<void> _handleSignIn() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //
  //     print("accessToken: ${googleSignInAuthentication.accessToken}");
  //     print("idToken: ${googleSignInAuthentication.idToken}");
  //
  //     print("serverAuthCode: ${googleSignInAccount.serverAuthCode}");
  //     print("authHeaders: ${googleSignInAccount.authHeaders}");
  //     print("id: ${googleSignInAccount.id}");
  //     print("displayName: ${googleSignInAccount.displayName}");
  //     print("email: ${googleSignInAccount.email}");
  //     print("photoUrl: ${googleSignInAccount.photoUrl}");
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  double opacityValue = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      _changeBackgroundColor();

      Future.delayed(const Duration(seconds: 2), () {
        _changeBackgroundColor();

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            opacityValue = 1.0;
          });
        });
      });
    });
  }

  Color _backgroundColor = Colors.white;
  Color _logoTextColor = Colors.white;
  bool isOnceChanged = false;
  double serviceLogoTopSize = 0;
  double kakaoLogoTopSize = 0;
  bool isKakaoSignInData = false;

  void _changeBackgroundColor() {
    setState(() {
      if (!isOnceChanged) {
        _backgroundColor = Colors.black;
        _logoTextColor = Colors.black;
        isOnceChanged = true;
      } else {
        _backgroundColor = const Color.fromRGBO(203, 170, 203, 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final topPositionPercentage = 0.5;
    final heightPercentage = 0.2;

    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      color: _backgroundColor,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: screenHeight * topPositionPercentage - 50,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(seconds: 2),
                style: TextStyle(
                  fontFamily: 'Candy',
                  fontSize: 80,
                  fontWeight: null,
                  color: _logoTextColor,
                ),
                curve: Curves.fastOutSlowIn,
                child: const Text(
                  "memo FRNDS",
                ),
              ),
            ),
            Positioned(
              top: screenHeight * topPositionPercentage + 50,
              child: GestureDetector(
                onTap: () async {
                  print("dddd");

                  var post = http.post(Uri.parse(
                      'https://27.35.76.64.nip.io:9000/oauth2/authorization/google'));

                  post.then((response) async => {
                        if (response.statusCode == 200)
                          {
                            if (await canLaunchUrlString(response.body))
                              {await launchUrlString(response.body)}
                            else
                              {throw 'Could not launch ${response.body}'}
                          }
                        else
                          {print("not 200")}
                      });
                },
                child: AnimatedOpacity(
                  opacity: opacityValue,
                  duration: Duration(seconds: 1),
                  child: Image.asset(
                      'assets/image/public/loginButton/android_light_rd_ctn@1x.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
