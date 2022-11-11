import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_cart/main_screen/user/book_renting/shipment/book_buying_step3.dart';

import '../models/address.dart';
import '../models/items.dart';
import '../providers/address_changer.dart';

class AddressDesign extends StatefulWidget {
  final Address? model;
  final String? sellerUID;
  final Items? itemsModel;
  final int? week;
  final int? month;
  final int? day;
  AddressDesign({
    this.model,
    this.sellerUID,
    this.itemsModel,
    this.week,
    this.month,
    this.day,
  });
  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (c) => BookBuyingStep3(addressModel: widget.model,itemsModel: widget.itemsModel,week: widget.week,day: widget.day,month: widget.month,)));

      },
      child: SingleChildScrollView(
        child: Card(
          color: Colors.cyan.withOpacity(0.4),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            const Text(
                              'Name: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(widget.model!.name.toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              'Phone Number: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(widget.model!.phoneNumber.toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              'City: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(widget.model!.city.toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              'Country: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(widget.model!.country.toString()),
                          ],
                        ),
                        TableRow(
                          children: [
                            const Text(
                              'Full Address: ',
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.model!.fullAddress.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
