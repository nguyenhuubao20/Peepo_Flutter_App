import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../configs/constants.dart';
import 'form_login.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double baseHeight = 812;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double hem = MediaQuery.of(context).size.height / baseHeight;
    double ffem = fem * 0.97;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40 * fem),
              Container(
                width: 180 * fem,
                height: 180 * fem,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 24 * hem),
              Text(
                'Welcome to Kalban!',
                style: GoogleFonts.openSans(
                  fontSize: 22 * ffem,
                  fontWeight: FontWeight.w900,
                  height: 1.3 * ffem / fem,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16 * hem),
              Text(
                'Sign in and enjoy your favorite offers!',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 16 * ffem,
                  fontWeight: FontWeight.w700,
                  height: 1.4 * ffem / fem,
                  color: kLowTextColor,
                ),
              ),
              SizedBox(height: 32 * hem),
              FormLogin(fem: fem, hem: hem, ffem: ffem),
              SizedBox(height: 24 * hem),
              Padding(
                padding: EdgeInsets.only(bottom: 24 * hem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have an account?',
                      style: GoogleFonts.openSans(
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.3 * ffem / fem,
                        color: kLowTextColor,
                      ),
                    ),
                    SizedBox(width: 8 * fem),
                    GestureDetector(
                      onTap: () {
                        // Navigation to registration
                      },
                      child: Text(
                        'Sign up now',
                        style: GoogleFonts.openSans(
                          fontSize: 14 * ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.3 * ffem / fem,
                          color: Colors.black,
                        ),
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
