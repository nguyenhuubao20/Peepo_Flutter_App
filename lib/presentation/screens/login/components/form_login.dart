import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app_router.dart';
import '../../../blocs/blocs.dart';
import '../../../widgets/notification.dart';
import 'button_login.dart';
import 'button_login_gmail.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({
    super.key,
    required this.fem,
    required this.hem,
    required this.ffem,
  });

  final double fem;
  final double hem;
  final double ffem;

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthenticationBloc>().state;
    var loginWidget = (switch (authState) {
      AuthenticationInitial() => _buildAuthIntial(userNameController,
          passwordController, widget.fem, widget.hem, widget.ffem),
      AuthenticationFailed(error: final error) => _buildAuthFailed(
          userNameController,
          passwordController,
          error,
          widget.fem,
          widget.hem,
          widget.ffem),
      AuthenticationSuccess() => _buildAuthIntial(userNameController,
          passwordController, widget.fem, widget.hem, widget.ffem),
      AuthenticationInProcessByAccount() => _buildAuthIntial(userNameController,
          passwordController, widget.fem, widget.hem, widget.ffem),
      AuthenticationInProcess() => _buildAuthIntial(userNameController,
          passwordController, widget.fem, widget.hem, widget.ffem),
      AuthenticationInProcessByGmail() => _buildAuthIntial(userNameController,
          passwordController, widget.fem, widget.hem, widget.ffem),
    });

    loginWidget = BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          AppRouter.navigateToHome();
          NotificationApp.show(context, 'Đăng nhập thành công!',
              backgroundColor: Colors.amber, icon: Icons.check);
        } else if (state is AuthenticationFailed) {
          NotificationApp.show(context, 'Đăng nhập thất bại, vui lòng thử lại!',
              backgroundColor: Colors.amber, icon: Icons.check);
        }
      },
      child: loginWidget,
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          loginWidget,
          SizedBox(
            height: 25 * widget.hem,
          ),
          ButtonLogin(
            widget: widget,
            onPressed: () {
              if (context.read<InternetBloc>().state is Connected) {
                if (_formKey.currentState!.validate()) {
                  context.read<AuthenticationBloc>().add(LoginAccount(
                      emailOrUsername: userNameController.text.trim(),
                      password: passwordController.text.toString()));
                }
              } else {
                NotificationApp.show(context, 'Không có kết nối Internet!',
                    backgroundColor: Colors.red.shade400, icon: Icons.error);
              }
            },
          ),
          ButtonLoginByGmail(
            widget: widget,
            onPressed: () {
              context.read<AuthenticationBloc>().add(LoginGmail());
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

Widget _buildAuthIntial(
    TextEditingController userNameController,
    TextEditingController passwordController,
    double fem,
    double hem,
    double ffem) {
  return Container(
    width: 318 * fem,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * fem),
        boxShadow: [
          BoxShadow(
            color: Color(0x0c000000),
            offset: Offset(0 * fem, 4 * fem),
            blurRadius: 2.5 * fem,
          )
        ]),
    child: Column(
      children: [
        SizedBox(
          height: 30 * hem,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20 * fem, right: 20 * fem),
          child: TextFormField(
            controller: userNameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'Username',
              hintStyle: GoogleFonts.openSans(
                fontSize: 15 * ffem,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10 * fem),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20 * hem,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20 * fem, right: 20 * fem),
          child: TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: 'Password',
              hintStyle: GoogleFonts.openSans(
                fontSize: 15 * ffem,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10 * fem),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30 * hem,
        ),
      ],
    ),
  );
}

Widget _buildAuthFailed(
    TextEditingController userNameController,
    TextEditingController passwordController,
    String error,
    double fem,
    double hem,
    double ffem) {
  return Container(
    width: 318 * fem,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15 * fem),
        boxShadow: [
          BoxShadow(
            color: Color(0x0c000000),
            offset: Offset(0 * fem, 4 * fem),
            blurRadius: 2.5 * fem,
          )
        ]),
    child: Column(
      children: [
        SizedBox(
          height: 30 * hem,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20 * fem, right: 20 * fem),
          child: TextFormField(
            controller: userNameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'Tên đăng nhập',
              hintStyle: GoogleFonts.openSans(
                fontSize: 15 * ffem,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10 * fem),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20 * hem,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20 * fem, right: 20 * fem),
          child: TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: 'Mật khẩu',
              hintStyle: GoogleFonts.openSans(
                fontSize: 15 * ffem,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10 * fem),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30 * hem,
        ),
      ],
    ),
  );
}
