import 'package:flutter/material.dart';
import 'package:selfbetter/providers/google_sign_in.dart';
import 'package:selfbetter/text_styles.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'Welcome\nto ',
                        style: kLandingPageMainTextStyle,
                        children: [
                          TextSpan(
                            text: 'SelfBetter!',
                            style: kLandingPageGrinderrTextStyle,
                          )
                        ]
                    ),
                  ),
                  Text(
                    'Hope you are well today',
                    style: kLandingPageParagraphTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Container(
                child: Image.asset(
                  'assets/images/landing-page.png',
                  fit: BoxFit.cover,
                ),
                width: 400,
                height: 300,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                        primary: Color(0xFF2A6049),
                        minimumSize: Size(20, 40),
                        shadowColor: Color(0xFF71C9CE),
                        elevation: 0,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                        primary: Color(0xFF2A6049),
                        minimumSize: Size(20, 40),
                        shadowColor: Color(0xFF71C9CE),
                        elevation: 0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'or',
                      style: kLandingPageParagraphTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(10,60),
                        primary: Color(0xFFFFFFFFF),
                        shadowColor: Color(0xFF71C9CE),
                        side: BorderSide(
                          color: Colors.black26,
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                        provider.googleLogin();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(backgroundImage: AssetImage('assets/images/GoogleLogo.png'), backgroundColor: Color(0x100FFFFFF), radius: 13,),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Sign up with Google', style: TextStyle(color: Colors.black),)
                        ],
                      ),
                    ),
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
