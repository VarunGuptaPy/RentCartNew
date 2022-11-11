import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_cart/splash_screen/splash_screen.dart';

import '../../../globals/globals.dart';
import '../../../models/items.dart';

class ItemDetailScreen extends StatefulWidget {
  final Items? model;
  ItemDetailScreen({this.model});
  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.amber,
                Colors.cyan,
              ],
            ),
          ),
        ),
        title: Text(
          widget.model!.title!,
          style: const TextStyle(
            fontFamily: "Signatra",
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.model!.thumbnailUrl!,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.model!.thumbnailUrl2!,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.model!.thumbnailUrl3!,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'title:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.title!,
                    style: TextStyle(fontSize: 20),
                  ),

                  IconButton(
                    onPressed: () async {
                      await openEditingDialog('title','title','str');
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Short Description:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.shortInfo!,
                    style: TextStyle(fontSize: 20),
                  ),

                  IconButton(
                    onPressed: () async {
                      await openEditingDialog('Short description','shortInfo','str');
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.LongDescription!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 20),
                  ),

                  IconButton(
                    onPressed: () async {
                      await openEditingDialog('Description','LongDescription','str');
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Rent Per Day:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.SingleDayRent!.toString(),
                    style: TextStyle(fontSize: 20),
                  ),

                  IconButton(
                    onPressed: () async {
                      await openEditingDialog('Rent Per Day','SingleDayRent','int');
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Rent Per Week:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.SingleWeekRent!.toString(),
                    style: TextStyle(fontSize: 20),
                  ),

                  IconButton(
                    onPressed: () async {
                      await openEditingDialog('Rent Per Week','SingleWeekRent','int');
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Single Month Rent:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.SingleMonthRent!.toString(),
                    style: TextStyle(fontSize: 20),
                  ),

                  IconButton(
                    onPressed: () async {
                      await openEditingDialog('Rent Per Month','SingleMonthRent','int');
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Full Price:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.FullPrice!.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ) ,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Status:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.status!.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Time Rent:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.timesRented!.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Book Type:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.itemType!.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Type of Item:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.model!.type!.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection('sellers')
                    .doc(sharedPreferences!.getString('uid'))
                    .collection('items')
                    .doc(widget.model!.itemID)
                    .delete();
                await FirebaseFirestore.instance
                    .collection('items')
                    .doc(widget.model!.itemID)
                    .delete();
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.amber, Colors.cyan],
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Delete this item",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future openEditingDialog(String text, String content, String type) {
    if (widget.model!.status == 'available') {
      TextEditingController? controller = TextEditingController();
      TextInputType? textInputType;
      if (type == 'int') {
        textInputType = TextInputType.number;
      } else if (type == 'str') {
        textInputType = TextInputType.text;
      }
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Change $text'),
          content: TextField(
            decoration: const InputDecoration(hintText: 'enter the value'),
            controller: controller,
            keyboardType: textInputType,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                List itemList = [];
                FirebaseFirestore.instance
                    .collection('BookTypes')
                    .doc('BookType')
                    .get()
                    .then((value) {
                  itemList = value.data()![widget.model!.itemType];
                });
                if (type == 'str') {
                  await FirebaseFirestore.instance
                      .collection('items')
                      .doc(widget.model!.itemID)
                      .update({
                    content: controller.text,
                  });
                  await FirebaseFirestore.instance
                      .collection('sellers')
                      .doc(sharedPreferences!.getString('uid'))
                      .collection('items')
                      .doc(widget.model!.itemID)
                      .update({
                    content: controller.text,
                  });
                  for (var i in itemList) {
                    if (i['itemID'] == widget.model!.itemID) {
                      i[content] = controller.text;
                      await FirebaseFirestore.instance
                          .collection('BookTypes')
                          .doc('BookType')
                          .update({
                        widget.model!.itemType!: itemList,
                      });
                      break;
                    }
                  }
                } else {
                  await FirebaseFirestore.instance
                      .collection('items')
                      .doc(widget.model!.itemID)
                      .update({
                    content: int.parse(controller.text),
                  });
                  await FirebaseFirestore.instance
                      .collection('sellers')
                      .doc(sharedPreferences!.getString('uid'))
                      .collection('items')
                      .doc(widget.model!.itemID)
                      .update({
                    content: int.parse(controller.text),
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ))
          ],
        ),
      );
    } else {
      return showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: Text(
            "Can't change the value of item whose status is not available",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }
  }
}
