import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../Widgets/custom_text_field.dart';
import '../../Widgets/error_dialog.dart';
import '../../Widgets/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals/globals.dart';
import '../../main_screen/user/home_screen.dart';

class userRegisterScreen extends StatefulWidget {
  const userRegisterScreen({Key? key}) : super(key: key);

  @override
  State<userRegisterScreen> createState() => _userRegisterScreenState();
}

class _userRegisterScreenState extends State<userRegisterScreen> {
  TextEditingController nameController = TextEditingController();
  LocationPermission? locationPermission;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  var mToken;
  String completeAddress = "";
  String? sellerImageUrl;
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? imageXFile;
  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Position? position;
  List<Placemark>? placemarks;
  getCurrentLocation() async {
    Position newPos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = newPos;
    placemarks =
        await placemarkFromCoordinates(position!.latitude, position!.longitude);
    Placemark pMark = placemarks![0];
    completeAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare} , ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea} ${pMark.administrativeArea}, ${pMark.postalCode}, ${pMark.country}';
    locationController.text = completeAddress;
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (c) => ErrorDialog(
                message: 'Please select an image',
              ));
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            phoneController.text.isNotEmpty) {
          showDialog(
              context: context,
              builder: (c) {
                return LoadingDialog(
                  message: "Registering Account",
                );
              });
          String fileName = DateTime.now().microsecondsSinceEpoch.toString();
          fStorage.Reference reference = await fStorage.FirebaseStorage.instance
              .ref()
              .child("users")
              .child(fileName);
          fStorage.UploadTask uploadTask =
              reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref
              .getDownloadURL()
              .then((url) => {sellerImageUrl = url});
          AuthenticateSellerAndSignUp();
        } else {
          showDialog(
              context: context,
              builder: (c) => ErrorDialog(
                    message: 'Please write req info for signup',
                  ));
        }
      } else {
        showDialog(
            context: context,
            builder: (c) => ErrorDialog(
                  message: "Password do not match",
                ));
      }
    }
  }

  void AuthenticateSellerAndSignUp() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
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
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        Route newRoute = MaterialPageRoute(builder: (c) => MyHomeScreen());
        Navigator.push(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "userUID": currentUser.uid,
      "userEmail": currentUser.email,
      "userName": nameController.text.trim(),
      "userAvatarUrl": sellerImageUrl,
      "phone": phoneController.text.trim(),
    });

    // save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!
        .setString("email", currentUser.email.toString().trim());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", sellerImageUrl!);
    await sharedPreferences!.setString("role", "user");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
      Text(
        "Register",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 40, fontFamily: "Signatra"),
      ),
      const SizedBox(
        height: 10,
      ),
      InkWell(
        onTap: () {
          _getImage();
        },
        child: CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.2,
          backgroundColor: Colors.white,
          backgroundImage:
              imageXFile == null ? null : FileImage(File(imageXFile!.path)),
          child: imageXFile == null
              ? Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width * 0.20,
                  color: Colors.grey,
                )
              : null,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              iconData: Icons.person,
              hintText: "Name",
              controller: nameController,
              isObsecured: false,
            ),
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
            CustomTextField(
              iconData: Icons.lock,
              hintText: "Confirm Password",
              controller: confirmPasswordController,
              isObsecured: true,
            ),
            CustomTextField(
              iconData: Icons.phone,
              hintText: "Phone",
              controller: phoneController,
              isObsecured: false,
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
              onPressed: () async {
                await FirebaseMessaging.instance.getToken().then((value){
                  setState(() {
                    mToken = value;
                  });
                });
                formValidation();
              },
              child: const Text(
                "Register",
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
    ]));
  }
}
