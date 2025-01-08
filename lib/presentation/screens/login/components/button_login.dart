import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../blocs/blocs.dart';
import '../../../configs/constants.dart';
import 'form_login.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({super.key, required this.widget, required this.onPressed});

  final FormLogin widget;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: 300 * widget.fem,
        height: 45 * widget.hem,
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(23 * widget.fem)),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationInProcess) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.black12,
                ),
              );
            } else if (state is AuthenticationFailed) {
              return Center(
                child: Text(
                  'Đăng nhập',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          fontSize: 17 * widget.ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.3625 * widget.ffem / widget.fem,
                          color: Colors.white)),
                ),
              );
            }
            return Center(
              child: Text(
                'Đăng nhập',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        fontSize: 17 * widget.ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.3625 * widget.ffem / widget.fem,
                        color: Colors.white)),
              ),
            );
          },
        ),
      ),
    );
  }
}
