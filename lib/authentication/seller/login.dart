import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/main_screen/seller/home_screen.dart';
import '../../Widgets/custom_text_field.dart';
import '../../Widgets/error_dialog.dart';
import '../../Widgets/loading_dialog.dart';
import '../auth_screen.dart';
import '../../globals/globals.dart';

class LoginScreen extends StatefulWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  formValidation() {
    if (emailController.text.isNotEmpty && emailController.text.isNotEmpty) {
      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please write email/password.",
            );
          });
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingDialog(
            message: "Checking Credential ",
          );
        });
    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((snapshots) async {
      if (snapshots.exists) {
        if (snapshots.data()!["blocked"] == false) {
          await sharedPreferences!
              .setString("uid", snapshots.data()!['sellerUID']);
          await sharedPreferences!
              .setString("email", snapshots.data()!["sellerEmail"]);
          await sharedPreferences!
              .setString("name", snapshots.data()!["sellerName"]);
          await sharedPreferences!
              .setString("photoUrl", snapshots.data()!["sellerAvatarUrl"]);

          await sharedPreferences!.setString("role", 'seller');
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => SellerHomeScreen()));
        } else {
          ErrorDialog(
            message: 'your account is blocked',
          );
        }
      } else {
        firebaseAuth.signOut();

        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const MyAuthScreen()));
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "No records exist",
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontFamily: "Signatra"),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    iconData: Icons.email,
                    hintText: "Email",
                    controller: emailController,
                    isObsecured: false,
                  ),
                  CustomTextField(
                    iconData: Icons.lock,
                    hintText: "Password",
                    controller: passwordController,
                    isObsecured: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 10,
                ),
              ),
              onPressed: () {
                formValidation();
              },
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
