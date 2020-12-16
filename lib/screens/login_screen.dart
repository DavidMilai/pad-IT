import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pad_app/screens/home_screen.dart';
import 'package:pad_app/services/auth.dart';
import 'package:pad_app/widgets/circular_material_spinner.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final AuthService authentication = AuthService();
  bool obscurePassword = true;
  bool loading = false;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: ListView(
          children: <Widget>[
            SizedBox(height: size.height * 0.15),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 8),
              child: Text(
                'Pad IT 🎈',
                style: TextStyle(
                    color: Colors.pink,
                    fontSize: 25,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(2, 1),
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Form(
                key: loginFormKey,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Welcome to padIT',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) return 'Email is required';
                        return null;
                      },
                      decoration: new InputDecoration(
                          labelText: "Email address",
                          labelStyle: TextStyle(color: Colors.pink[300]),
                          suffixIcon: Icon(
                            Icons.email,
                            size: 20,
                            color: Colors.pink[300],
                          )),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordCtrl,
                      keyboardType: TextInputType.text,
                      obscureText: obscurePassword,
                      validator: (value) {
                        if (value.isEmpty) return 'Password is required';
                        if (value.length < 4)
                          return 'Password has to be more than 4 characters';
                        return null;
                      },
                      decoration: new InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.pink[300]),
                        suffixIcon: new GestureDetector(
                          onTap: togglePasswordVisibility,
                          child: Icon(
                            obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20.0,
                            color: Colors.pink[300],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CircularMaterialSpinner(
                      loading: loading,
                      color: Colors.pink,
                      child: MaterialButton(
                        height: 45,
                        color: Colors.pinkAccent,
                        onPressed: () async {
                          if (loginFormKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await authentication.signIn(
                                emailCtrl.text, passwordCtrl.text);
                            if (result == null) {
                              setState(() {
                                loading = false;
                              });
                            } else {
                              setState(() {
                                loading = false;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );
                            }
                          }
                        },
                        child: Text(
                          'Login',
                          style:
                              TextStyle(letterSpacing: 2, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
