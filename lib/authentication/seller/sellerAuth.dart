import 'package:flutter/material.dart';
import 'package:rent_cart/authentication/seller/register.dart';

import 'login.dart';

class sellerAuth extends StatefulWidget {
  const sellerAuth({Key? key}) : super(key: key);

  @override
  State<sellerAuth> createState() => _sellerAuthState();
}

class _sellerAuthState extends State<sellerAuth> {
  bool showRegister = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LoginScreen(),
          showRegister
              ? RegisterScreen()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "not a Seller?",
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
