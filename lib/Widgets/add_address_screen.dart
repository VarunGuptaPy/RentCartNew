import 'dart:async';
import 'dart:ffi';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_places_autocomplete/maps_places_autocomplete.dart';
import 'package:rent_cart/Widgets/error_dialog.dart';
import 'package:rent_cart/globals/globals.dart';
import 'package:requests/requests.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:what3words/what3words.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  GooglePlace? googlePlace;
  List<AutocompletePrediction> prediction = [];
  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController fullAddressController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController what3wordsController = TextEditingController();
    double lat;
    double lng;
    List<Double> coordinates;
    Position? position;
    List<Placemark>? placemarks;
    LocationPermission? locationPermission;
    getCurrentLocation() async {
      locationPermission = await Geolocator.requestPermission();
      Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      position = newPosition;
      placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      Placemark pMark = placemarks![0];
      String fullAddress =
          '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
      fullAddressController.text = fullAddress;

      cityController.text =
          '${pMark.administrativeArea}';
      stateController.text = '${pMark.country}';
      var words = await api
          .convertTo3wa(Coordinates(position!.latitude, position!.longitude))
          .language('en')
          .execute();
      what3wordsController.text = words.data()!.words;
      lat = position!.latitude;
      lng = position!.longitude;
    }

    void saveAddress() async {
      if (fullAddressController.text.isNotEmpty &&
          cityController.text.isNotEmpty &&
          stateController.text.isNotEmpty &&
          what3wordsController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty) {
        String? uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(sharedPreferences!.getString('uid'))
            .collection('address')
            .doc(uniqueName)
            .set({
          'addressUID': uniqueName,
          'fullAddress': fullAddressController.text,
          'what3word': what3wordsController.text,
          'phoneNumber': phoneController.text,
          'city': cityController.text,
          'name': nameController.text,
          'country': stateController.text,
          'lat': position!.latitude,
          'lng': position!.longitude,
        });
        Navigator.pop(context);
      } else {
        ErrorDialog(
          message: 'Please enter data in all field',
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.amber, Colors.cyan])),
        ),
        title: Text(
          'Rent Cart',
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Full Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: fullAddressController,
                decoration: InputDecoration(
                  hintText: 'Click down button button to get address',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                getCurrentLocation();
              },
              child: Text(
                'Get your current location',
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.amber),
              ),
            ),
            Divider(
              thickness: 4,
            ),
            Text(
              'City:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cityController,
              ),
            ),
            Text(
              'country:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: stateController,
              ),
            ),
            Text(
              'name:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
              ),
            ),
            Text(
              'phone number:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phoneController,
              ),
            ),
            Text(
              'what3word address:',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: what3wordsController,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  saveAddress();
                },
                child: Text('Save Address'))
          ],
        ),
      ),
    );
  }
}
