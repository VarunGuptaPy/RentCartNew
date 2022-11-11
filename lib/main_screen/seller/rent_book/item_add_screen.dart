import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:rent_cart/main_screen/seller/home_screen.dart';

import '../../../Widgets/error_dialog.dart';
import '../../../Widgets/progress_bar.dart';
import '../../../globals/globals.dart';

class ItemsUploadScreen extends StatefulWidget {
  final String? value;
  ItemsUploadScreen({this.value});
  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  XFile? ImageXfile;
  XFile? ImageXfile2;
  XFile? ImageXfile3;
  ImagePicker? _picker = ImagePicker();
  TextEditingController shorInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController SingleDayRentPrice = TextEditingController();
  TextEditingController SingleWeekRentPrice = TextEditingController();
  TextEditingController SingleMonthRentPrice = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<dynamic> bookTypes = [];
  String selectedValue = "Action";
  List<DropdownMenuItem<String>> menuItems = [];

  bool uploading = false;
  late String UniqueName = DateTime.now().millisecondsSinceEpoch.toString();
  takeImage(mContext, index) {
    return showDialog(
        context: mContext,
        builder: (context) {
          if (index == 0) {
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
                    captureImageWithCamera(0);
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
                    pickImageFromGallery(0);
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
          } else if (index == 1) {
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
                    captureImageWithCamera(2);
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
                    pickImageFromGallery(2);
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
          } else {
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
                    captureImageWithCamera(3);
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
                    pickImageFromGallery(3);
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
          }
        });
  }

  captureImageWithCamera(index) async {
    Navigator.pop(context);
    if (index == 0) {
      ImageXfile = await _picker!.pickImage(
          source: ImageSource.camera, maxHeight: 720, maxWidth: 1280);
      setState(() {
        ImageXfile;
      });
    }
    if (index == 2) {
      ImageXfile2 = await _picker!.pickImage(
          source: ImageSource.camera, maxHeight: 720, maxWidth: 1280);
      setState(() {
        ImageXfile2;
      });
    } else {
      ImageXfile3 = await _picker!.pickImage(
          source: ImageSource.camera, maxHeight: 720, maxWidth: 1280);
      setState(() {
        ImageXfile3;
      });
    }
  }

  pickImageFromGallery(index) async {
    Navigator.pop(context);
    if (index == 0) {
      ImageXfile = await _picker!.pickImage(
          source: ImageSource.gallery, maxHeight: 720, maxWidth: 1280);
      setState(() {
        ImageXfile;
      });
    }
    if (index == 2) {
      ImageXfile2 = await _picker!.pickImage(
          source: ImageSource.gallery, maxHeight: 720, maxWidth: 1280);
      setState(() {
        ImageXfile;
      });
    } else {
      ImageXfile3 = await _picker!.pickImage(
          source: ImageSource.gallery, maxHeight: 720, maxWidth: 1280);
      setState(() {
        ImageXfile;
      });
    }
  }

  menuUploadForm() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Uploading New Book",
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
        actions: [
          TextButton(
            onPressed: () async {
              await validateForm();
            },
            child: const Text(
              "Add",
              style: TextStyle(
                fontFamily: "Lobster",
                color: Colors.cyan,
                letterSpacing: 2,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          uploading ? linearProgress() : Text(""),
          ImageXfile == null
              ? ElevatedButton(
                  onPressed: () {
                    takeImage(context, 0);
                  },
                  child: const Text("Add First Image"),
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
          ImageXfile2 == null
              ? ElevatedButton(
                  onPressed: () {
                    takeImage(context, 1);
                  },
                  child: const Text("Add Second Image"),
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
                                  ImageXfile2!.path,
                                ),
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
          ImageXfile3 == null
              ? ElevatedButton(
                  onPressed: () {
                    takeImage(context, 2);
                  },
                  child: const Text("Add Third Image"),
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
                                  ImageXfile3!.path,
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
                controller: priceController,
                decoration: const InputDecoration(
                    hintText: "Real Price of book",
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
            'Type of Book',
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
        ],
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
    priceController.clear();
    Navigator.pop(context);
  }

  validateForm() async {
    if (ImageXfile != null && ImageXfile2 != null && ImageXfile3 != null) {
      if (shorInfoController.text.isNotEmpty &&
          titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          SingleDayRentPrice.text.isNotEmpty &&
          SingleMonthRentPrice.text.isNotEmpty &&
          SingleWeekRentPrice.text.isNotEmpty &&
          priceController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });
        String downloadUrl = await uploadImage(File(ImageXfile!.path), 0);
        String downloadUrl2 = await uploadImage(File(ImageXfile2!.path), 1);
        String downloadUrl3 = await uploadImage(File(ImageXfile3!.path), 2);
        await saveInfo(downloadUrl, downloadUrl2, downloadUrl3);
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

  uploadImage(Imagefile, index) async {
    if (index == 0) {
      fStorage.Reference reference =
          fStorage.FirebaseStorage.instance.ref().child("items");
      fStorage.UploadTask uploadTask =
          reference.child(UniqueName + ".jpg").putFile(Imagefile);
      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } else if (index == 1) {
      fStorage.Reference reference =
          fStorage.FirebaseStorage.instance.ref().child("items");
      fStorage.UploadTask uploadTask = reference
          .child(((int.parse(UniqueName)) + 1).toString() + ".jpg")
          .putFile(Imagefile);
      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } else if (index == 2) {
      fStorage.Reference reference =
          fStorage.FirebaseStorage.instance.ref().child("items");
      fStorage.UploadTask uploadTask = reference
          .child(((int.parse(UniqueName)) + 1).toString() + ".jpg")
          .putFile(Imagefile);
      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    }
  }

  saveInfo(String downloadUrl, String downloadUrl2, String downloadUrl3) async {
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
      "FullPrice": int.parse(priceController.text.toString()),
      "SingleDayRent": int.parse(SingleDayRentPrice.text.toString()),
      "SingleWeekRent": int.parse(SingleWeekRentPrice.text.toString()),
      "SingleMonthRent": int.parse(SingleMonthRentPrice.text.toString()),
      "title": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
      "thumbnailUrl2": downloadUrl2,
      "thumbnailUrl3": downloadUrl3,
      "type": widget.value,
      "timesRented": 0,
      "itemType": selectedValue,
    }).then((value) async {
      final itemsRef = FirebaseFirestore.instance.collection('items');
      await itemsRef.doc(UniqueName).set({
        "itemID": UniqueName,
        "sellerUID": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "shortInfo": shorInfoController.text.toString(),
        "LongDescription": descriptionController.text.toString(),
        "FullPrice": int.parse(priceController.text.toString()),
        "SingleDayRent": int.parse(SingleDayRentPrice.text.toString()),
        "SingleWeekRent": int.parse(SingleWeekRentPrice.text.toString()),
        "SingleMonthRent": int.parse(SingleMonthRentPrice.text.toString()),
        "title": titleController.text.toString(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": downloadUrl,
        "thumbnailUrl2": downloadUrl2,
        "thumbnailUrl3": downloadUrl3,
        "type": widget.value,
        "timesRented": 0,
        "itemType": selectedValue,
      });
    }).then((value) {
      menuClear();
      setState(() {
        uploading = false;
        UniqueName = "";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('BookTypes')
        .doc('BookType')
        .get()
        .then((value) {
      setState(() {
        bookTypes = value.data()!['types'];
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
  }

  @override
  Widget build(BuildContext context) {
    return menuUploadForm();
  }
}
