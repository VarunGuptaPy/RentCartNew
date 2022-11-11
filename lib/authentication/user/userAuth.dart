import 'package:flutter/material.dart';
import 'package:rent_cart/authentication/user/userLogin.dart';
import 'package:rent_cart/authentication/user/userRegister.dart';

class userAuth extends StatefulWidget {
  const userAuth({Key? key}) : super(key: key);

  @override
  State<userAuth> createState() => _userAuthState();
}

class _userAuthState extends State<userAuth> {
  bool showRegister = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          userLoginScreen(),
          showRegister
              ? userRegisterScreen()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "not a user?",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            showRegister = true;
                          });
                        },
                        child: const Text(
                          "Register Now",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                          ),
                        ))
                  ],
                ),
        ],
      ),
    );
  }
}
