import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'dart:math' as math;

import 'package:road_safety/res/constants.dart';
class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  _AdminUserScreenState createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: buttonColor,
        centerTitle: true,
        title: Text('Users'),
      ),

      body:  StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: primaryColor,
                ));
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            // got data from snapshot but it is empty

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
                        //   context,
                        //   PageRouteBuilder(
                        //     pageBuilder: (c, a1, a2) => UserDetailScreen(
                        //       docId: snapshot.data!.docs[index].id.toString(),
                        //       userStatus: "Students",
                        //
                        //     ),
                        //     transitionsBuilder: (c, anim, a2, child) =>
                        //         FadeTransition(opacity: anim, child: child),
                        //     transitionDuration: Duration(milliseconds: 100),
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 0, right: 0),
                        child: Container(
                          width: size.width * 0.95,

                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: primaryColor1),
                            borderRadius: BorderRadius.circular(0),
                            //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                            gradient:  LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors:

                              <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2), ],
                            ),


                            //whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8,bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    // color: Colors.green,
                                  ),
                                  width: size.width * 0.17,
                                  child: CircleAvatar(
                                    backgroundColor: lightGreyColor,
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNDgyaDCaoDZJx8N9BBE6eXm5uXuObd6FPeg&usqp=CAU"
                                    ),
                                  ),
                                ),
                                Container(
                                  //  color: redColor,
                                  // width: size.width * 0.73,

                                  child: Column(
                                    //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [
                                          Container(
                                            //  color: Colors.orange,
                                            width: size.width * 0.48,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child:  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                    ["name"]
                                                        .toString() ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: secondaryColor1,
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w800,
                                                        height: 1.3),
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.yellow,
                                                  alignment: Alignment.topLeft,
                                                  child:  Text(
                                                    snapshot
                                                        .data!
                                                        .docs[index]
                                                    ["email"]
                                                        .toString() ,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: secondaryColor1,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        height: 1.3),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: 1,
                                            height: 40,
                                            color: Colors.grey.withOpacity(0.3),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            // color: Colors.greenAccent,
                                            // width: size.width * 0.27,
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [

                                                      GestureDetector(
                                                          onTap:() {

                                                            if(snapshot
                                                                .data!
                                                                .docs[index]
                                                            ["status"]
                                                                .toString() != "Approved") {
                                                              showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  return AlertDialog(
                                                                    title:
                                                                    const Text('Approve'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.of(
                                                                              context)
                                                                              .pop();
                                                                        },
                                                                        child:
                                                                        Container(
                                                                            decoration: BoxDecoration(
                                                                                color: AppColors.darkRedColor,
                                                                                borderRadius: BorderRadius.circular(10)
                                                                            ),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(16.0),
                                                                              child: const Text('Cancel', style: TextStyle(color: whiteColor),),
                                                                            )),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () async {
                                                                          FirebaseFirestore.instance.collection("Users").doc(snapshot.data!.docs[index].id.toString())
                                                                              .update({
                                                                            "status" : "Approved"
                                                                          })
                                                                              .whenComplete(
                                                                                  () {
                                                                                Navigator.of(
                                                                                    context)
                                                                                    .pop();
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                    const SnackBar(
                                                                                        backgroundColor: Colors.green,
                                                                                        content:  Text('Successfully Approved',style: TextStyle(color: whiteColor),)
                                                                                    )
                                                                                );
                                                                              });
                                                                        },
                                                                        child:
                                                                        Container(
                                                                            decoration: BoxDecoration(
                                                                                color: AppColors.greenColor2,
                                                                                borderRadius: BorderRadius.circular(10)
                                                                            ),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(16.0),
                                                                              child: const Text('Approve', style: TextStyle(color: whiteColor),),
                                                                            )),
                                                                      ),
                                                                    ],
                                                                    content: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      mainAxisSize:
                                                                      MainAxisSize.min,
                                                                      children: [
                                                                        const Text(
                                                                            'Are you sure you want to approve this user?'),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }



                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              color:
                                                              snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["status"]
                                                                  .toString() == "Approved" ? AppColors.greenColor2 :

                                                              AppColors.purpleColor,
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                              ["status"]
                                                                  .toString(), style: TextStyle(color: whiteColor),),
                                                            ),
                                                          ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  //Container(child: Text('AdminHome'),),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
