import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_cart/Widgets/loading_dialog.dart';

import '../../../Widgets/error_dialog.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../globals/globals.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:intl/intl.dart';
class SubscriptionAddScreen extends StatefulWidget {
  final String? value;

  SubscriptionAddScreen({this.value});

  @override
  State<SubscriptionAddScreen> createState() => _SubscriptionAddScreenState();
}

class _SubscriptionAddScreenState extends State<SubscriptionAddScreen> {

  String generatePassword({
    bool letter = true,
    bool isNumber = true,
    bool isSpecial = true,
  }) {
    final length = 10;
    final letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
    final letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    final number = '0123456789';
    final special = '@#%^*>\$@?/[]=+';

    String chars = "";
    if (letter) chars += '$letterLowerCase$letterUpperCase';
    if (isNumber) chars += '$number';
    if (isSpecial) chars += '$special';


    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars [indexRandom];
    }).join('');
  }
  XFile? ImageXfile;
  ImagePicker? _picker = ImagePicker();
  TextEditingController shorInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController SingleDayRentPrice = TextEditingController();
  TextEditingController SingleWeekRentPrice = TextEditingController();
  TextEditingController SingleMonthRentPrice = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DateTime _dateTime = DateTime(DateTime.now().year);
  bool uploading = false;
  late String UniqueName = DateTime.now().millisecondsSinceEpoch.toString();
  List<dynamic> bookTypes = [];
  String selectedValue = "stream";
  List<DropdownMenuItem<String>> menuItems = [];
  bool secondWindow = false;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('BookTypes')
        .doc('SubscriptionType')
        .get()
        .then((value) {
      setState(() {
        bookTypes = value.data()!['Types'];
      });
      print(bookTypes);
    }).then((value) {
      for (int i = 0; i < bookTypes.length; i++) {
        String tempValue = bookTypes[i];
        menuItems.add(
          DropdownMenuItem(value: tempValue, child: Text(tempValue)),
        );
      }
    }).then((value) {
      setState(() {
        menuItems;
      });
    });
    print(menuItems);
    passwordController.text = generatePassword();
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text(
              "Menu Image",
              style:
                  TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: const Text(
                  "Capture image form Camera",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: () {
                  captureImageWithCamera();
                },
              ),
              SimpleDialogOption(
                child: const Text(
                  "Pick Image from gallery",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: () {
                  pickImageFromGallery();
                },
              ),
              SimpleDialogOption(
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    ImageXfile = await _picker!
        .pickImage(source: ImageSource.camera, maxHeight: 720, maxWidth: 1280);
    setState(() {
      ImageXfile;
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    ImageXfile = await _picker!
        .pickImage(source: ImageSource.gallery, maxHeight: 720, maxWidth: 1280);
    setState(() {
      ImageXfile;
    });
  }

  subscriptionUploadForm() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Uploading Subscription",
          style: TextStyle(fontSize: 20, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.cyan, Colors.amber],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            menuClear();
          },
        ),
      ),
      body: secondWindow == false ? ListView(
        children: [
          uploading ? linearProgress() : Text(""),
          ImageXfile == null
              ? ElevatedButton(
                  onPressed: () {
                    takeImage(context);
                  },
                  child: const Text("Add Image"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                )
              : Container(
                  height: 230,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(
                                File(
                                  ImageXfile!.path,
                                ),
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: shorInfoController,
                decoration: const InputDecoration(
                    hintText: "info",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 3,
            color: Colors.amber,
          ),
          ListTile(
            leading: const Icon(
              Icons.title,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: "title",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 3,
            color: Colors.amber,
          ),
          ListTile(
            leading: const Icon(
              Icons.description,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: descriptionController,
                decoration: const InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 3,
            color: Colors.amber,
          ),
          ListTile(
            leading: const Icon(
              Icons.currency_rupee,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: SingleDayRentPrice,
                decoration: const InputDecoration(
                    hintText: "Single Day Rent Price",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 3,
            color: Colors.amber,
          ),
          ListTile(
            leading: const Icon(
              Icons.currency_rupee,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: SingleWeekRentPrice,
                decoration: const InputDecoration(
                    hintText: "Single Week Rent Price",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 3,
            color: Colors.amber,
          ),
          ListTile(
            leading: const Icon(
              Icons.currency_rupee,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: SingleMonthRentPrice,
                decoration: const InputDecoration(
                    hintText: "Single Month Rent Price",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 3,
            color: Colors.amber,
          ),
          const Text(
            'Type of Subscription',
            style: TextStyle(fontSize: 20),
          ),
          DropdownButton(
            value: selectedValue,
            items: menuItems,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          const Divider(
            height: 10,
            thickness: 3,
            color: Colors.amber,
          ),
          ListTile(
            leading: const Icon(
              Icons.currency_rupee,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                enabled: false,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: dateController,
                decoration: const InputDecoration(
                    hintText: "You can give rent till",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                DateTime? _newDate = await showDatePicker(
                    context: context,
                    initialDate: _dateTime,
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(3000));
                dateController.text =
                    "${_newDate!.day}-${_newDate.month}-${_newDate.year}";
                setState(() {
                  _dateTime = _newDate;
                });
              },
              child: Text('Get Date')),
          const Divider(
            height: 10,
            thickness: 3,
            color: Colors.amber,
          ),
          ListTile(
            leading: const Icon(
              Icons.currency_rupee,
              color: Colors.cyan,
            ),
            title: Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.black,
                ),
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: "Subscription Account Email",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            validateForm();
          }, child: Text('Next'))
        ],
      )
          : Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Please set your subscription password to ",style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold
                ),),
              ],
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: passwordController,
              readOnly: true,
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  suffixIcon: IconButton(
                      onPressed: (){
                        final data = ClipboardData(text: passwordController.text);
                        Clipboard.setData(data);

                        final snackbar = SnackBar(
                            content: Text("Password Copy"));

                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(snackbar);
                      },
                      icon: Icon(Icons.copy))
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(onPressed: (){
              validateForm();
            }, child: Text('I have changed my password'))
          ],
        ),

      ),

    );
  }

  menuClear() {
    shorInfoController.clear();
    titleController.clear();
    descriptionController.clear();
    SingleDayRentPrice.clear();
    SingleWeekRentPrice.clear();
    SingleMonthRentPrice.clear();
    emailController.clear();
    dateController.clear();
    Navigator.pop(context);
    Navigator.pop(context);
  }

  validateForm() async {
    if (secondWindow == true){
      if (ImageXfile != null) {
        if (shorInfoController.text.isNotEmpty &&
            titleController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty &&
            SingleDayRentPrice.text.isNotEmpty &&
            SingleMonthRentPrice.text.isNotEmpty &&
            SingleWeekRentPrice.text.isNotEmpty &&
            dateController.text.isNotEmpty &&
            emailController.text.isNotEmpty) {
          if (_dateTime.compareTo(DateTime.now()) > 0) {
            showDialog(context: context, builder: (c) => LoadingDialog(message: 'Adding Iem',));
            String downloadUrl = await uploadImage(File(ImageXfile!.path));
            await saveInfo(downloadUrl);
          } else {
            showDialog(
                context: context,
                builder: (c) => ErrorDialog(
                  message: "Please give correct date",
                ));
          }
        } else {
          showDialog(
              context: context,
              builder: (c) => ErrorDialog(
                message: 'Please give menu info and title info',
              ));
        }
      } else {
        showDialog(
            context: context,
            builder: (c) => ErrorDialog(
              message: 'Please select an image',
            ));
      }
    }
    else{
      if (ImageXfile != null) {
        if (shorInfoController.text.isNotEmpty &&
            titleController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty &&
            SingleDayRentPrice.text.isNotEmpty &&
            SingleMonthRentPrice.text.isNotEmpty &&
            SingleWeekRentPrice.text.isNotEmpty &&
            dateController.text.isNotEmpty &&
            emailController.text.isNotEmpty) {
          if (_dateTime.compareTo(DateTime.now()) > 0) {
            setState(() {
              secondWindow = true;
            });
          } else {
            showDialog(
                context: context,
                builder: (c) => ErrorDialog(
                  message: "Please give correct date",
                ));
          }
        } else {
          showDialog(
              context: context,
              builder: (c) => ErrorDialog(
                message: 'Please give menu info and title info',
              ));
        }
      } else {
        showDialog(
            context: context,
            builder: (c) => ErrorDialog(
              message: 'Please select an image',
            ));
      }
    }
  }

  uploadImage(Imagefile) async {
    fStorage.Reference reference =
        fStorage.FirebaseStorage.instance.ref().child("items");
    fStorage.UploadTask uploadTask =
        reference.child(UniqueName + ".jpg").putFile(Imagefile);
    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveInfo(String downloadUrl) async {

    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection('items')
        .doc(UniqueName)
        .set({
      "itemID": UniqueName,
      "sellerUID": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "shortInfo": shorInfoController.text.toString(),
      "LongDescription": descriptionController.text.toString(),
      "SingleDayRent": int.parse(SingleDayRentPrice.text.toString()),
      "SingleWeekRent": int.parse(SingleWeekRentPrice.text.toString()),
      "SingleMonthRent": int.parse(SingleMonthRentPrice.text.toString()),
      "title": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "rentTillYear": '${_dateTime.year}',
      "rentTillMonth": '${_dateTime.month}',
      "rentTillDay": '${_dateTime.day}',
      "subscriptionEmail": emailController.text,
      "status": "available",
      "thumbnailUrl": downloadUrl,
      "type": widget.value,
      "timesRented": 0,
      "itemType": selectedValue.toString(),
      'password': passwordController.text,
      'rentTillDate': _dateTime,
      'onList': false
    }).then((value) async {
      final itemsRef = FirebaseFirestore.instance.collection('items');
      await itemsRef.doc(UniqueName).set({
        "itemID": UniqueName,
        "sellerUID": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "shortInfo": shorInfoController.text.toString(),
        "LongDescription": descriptionController.text.toString(),
        "SingleDayRent": int.parse(SingleDayRentPrice.text.toString()),
        "SingleWeekRent": int.parse(SingleWeekRentPrice.text.toString()),
        "SingleMonthRent": int.parse(SingleMonthRentPrice.text.toString()),
        "title": titleController.text.toString(),
        "publishedDate":  DateFormat('dd-MM-yyyy').format(DateTime.now()),
        "rentTillYear": '${_dateTime.year}',
        "rentTillMonth": '${_dateTime.month}',
        "rentTillDay": '${_dateTime.day}',
        "subscriptionEmail": emailController.text,
        "status": "available",
        "thumbnailUrl": downloadUrl,
        "type": widget.value,
        "timesRented": 0,
        "itemType": selectedValue.toString(),
        'password': passwordController.text,
        'rentTillDate': _dateTime,
      });
    }).then((value) {
      menuClear();
      setState(() {
        UniqueName = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return subscriptionUploadForm();
  }
}
