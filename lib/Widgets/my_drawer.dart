import 'package:flutter/material.dart';
import 'package:rent_cart/main_screen/user/OrderScreen/user_order_screen.dart';
import '../authentication/auth_screen.dart';
import '../globals/globals.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 25),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Container(
                    height: 160,
                    width: 160,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(
                      color: Colors.black, fontFamily: "Train", fontSize: 20),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(1.0),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.monetization_on,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "My Earnings",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.reorder,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "My Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => UserOrderScreen()));
                  },
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.grey,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    firebaseAuth.signOut().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => MyAuthScreen())));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
