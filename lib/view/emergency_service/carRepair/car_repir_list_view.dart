import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/model/dummy_data.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/utils.dart';
import '../add_emergency_detail_screen.dart';

class CarRepairListView extends StatefulWidget {
  const CarRepairListView({super.key});

  @override
  State<CarRepairListView> createState() => _CarRepairListViewState();
}

// updated
class _CarRepairListViewState extends State<CarRepairListView> {
  String userType = "";


  @override
  void initState() {
    // TODO: implement initState
    getUserType();
    super.initState();
  }

  getUserType() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    userType = await prefs.getString("userType") ?? "Users";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blackColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.greenColor2,
        title: Text(
          'Car Repair',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.lightGreyColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Car Repair").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: primaryColor,
                ));
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Data Found"));
          } else {
            return Center(
              child: Container(
                width: size.width * 0.95,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             OrderDetailScreen(
                        //               name: snapshot.data!.docs[index]["recipientName"].toString(),
                        //               email: snapshot.data!.docs[index]["recipientEmail"].toString(),
                        //               orderId: snapshot.data!.docs[index]["orderId"].toString(),
                        //               orderTotal: snapshot.data!.docs[index]["orderTotal"].toString(),
                        //               payment: snapshot.data!.docs[index]["paymentMethod"].toString(),
                        //               productsList: snapshot.data!.docs[index]["items"],
                        //               address: snapshot.data!.docs[index]["deliveryAddress"].toString(),
                        //               orderStatus:snapshot.data!.docs[index]["orderStatus"].toString(),
                        //             )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 3),
                        child: Container(
                          width: size.width * 0.95,
                          height: size.height * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: whiteColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                // color: redColor,
                                width: size.width * 0.25,
                                height: size.height * 0.25,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  child: Image.network(
                                    snapshot
                                        .data!
                                        .docs[index]
                                    ["image"]
                                        .toString(),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              Container(
                                //   color: redColor,
                                //width: size.width*0.5,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [

                                    Container(

                                      width: size.width * 0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width * 0.4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 8),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["name"]
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w800,),
                                                maxLines: 2,
                                                overflow: TextOverflow
                                                    .ellipsis,),
                                            ),
                                          ),


                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text('Delete'),
                                                      content: Text(
                                                          'Do you want to delete this emergency service}?'),
                                                      actions: [
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                              backgroundColor: primaryColor,
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight
                                                                      .bold)),
                                                          onPressed: () =>
                                                              Navigator.of(
                                                                  context).pop(
                                                                  false),
                                                          //return false when click on "NO"
                                                          child: Text('No'),
                                                        ),

                                                        ElevatedButton(
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                "Car Repair")
                                                                .doc(snapshot
                                                                .data!
                                                                .docs[index].id).delete().then((value){
                                                                  setState(() {});
                                                              Utils.flushBarErrorMessage("Deleted Successfully", context,
                                                                  AppColors.greenColor2, "Success", 2);
                                                            });
                                                          },
                                                          //return true when click on "Yes"
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                              backgroundColor: redColor,
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight
                                                                      .bold)),
                                                          child: Text('Yes'),
                                                        ),

                                                      ],
                                                    ),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  10.0),
                                              child: Icon(
                                                Icons.delete, color: Colors.red,
                                                size: 20,),
                                            ),
                                          )
                                        ],),
                                    ),

                                    Container(

                                      width: size.width * 0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width * 0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["status"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,),


                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    Container(

                                      width: size.width * 0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width * 0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["service"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,),


                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    Container(

                                      width: size.width * 0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width * 0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8,),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["address"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,),


                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),
                                    Container(

                                      width: size.width * 0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: [
                                              Icon(
                                                Icons.call, color: Colors.red,),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8,),
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .docs[index]
                                                  ["phone"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 11,
                                                      fontWeight: FontWeight
                                                          .w500,
                                                      height: 1.3),),
                                              ),
                                            ],),
                                          Center(
                                            child: OutlinedButton(

                                                onPressed: () =>
                                                    launch("tel:${ snapshot
                                                        .data!
                                                        .docs[index]
                                                    ["phone"]
                                                        .toString()}"),
                                                child: new Text("Call Now",
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .greenColor2,
                                                      fontSize: 12),)),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                  ],),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: Visibility(
        visible: userType == "Admin",
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddEmergencyDetailScreen(
                            type: "Car Repair"
                        )));
          },
          backgroundColor: AppColors.greenColor2,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
