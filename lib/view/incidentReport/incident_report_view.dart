import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/constants.dart';
import 'package:road_safety/view/incidentReport/add_incident_report.dart';
import 'package:road_safety/view/incidentReport/incident_report_detail.dart';

class IncidentReportView extends StatefulWidget {
  const IncidentReportView({super.key});

  @override
  State<IncidentReportView> createState() => _IncidentReportViewState();
}

class _IncidentReportViewState extends State<IncidentReportView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.greenColor2,
        title: Text(
          'Incidents',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => DashBoardScreen(index:1)));
              // Scaffold.of(context).openDrawer();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purpleColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddIncidentReportView()),
          );
        },
        child: Icon(Icons.add),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('IncidentReport').where('uid',isEqualTo: _auth.currentUser!.uid.toString()).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: AppColors.greenColor2,
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
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 8, bottom: 3),
                        child: Container(
                          width: size.width*0.95,
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
                                width: size.width*0.25,
                                 height: size.height*0.1,
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    snapshot
                                        .data!
                                        .docs[index]
                                    ["image"]
                                        .toString()
                                    , fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                //   color: redColor,
                                //width: size.width*0.5,

                                child:  Column(
                                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Container(

                                      width: size.width*0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width*0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8,top: 8),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["title"]
                                                    .toString()
                                                , style: TextStyle(
                                                color: Colors.black, fontSize: 13, fontWeight: FontWeight.w800,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    SizedBox(
                                      height: size.height*0.01,
                                    ),

                                    Container(

                                      width: size.width*0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width*0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8,),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["description"]
                                                    .toString()
                                                , style: TextStyle(
                                                  color: Colors.black, fontSize: 10, fontWeight: FontWeight.w500, height: 1.3,
                                                  overflow: TextOverflow.ellipsis),overflow: TextOverflow.ellipsis,maxLines: 3,),


                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    SizedBox(
                                      height: size.height*0.01,
                                    ),

                                    Container(

                                      width: size.width*0.6,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: size.width*0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8,),
                                              child: Text(
                                                snapshot
                                                    .data!
                                                    .docs[index]
                                                ["address"]
                                                    .toString()
                                                , style: TextStyle(
                                                  color: Colors.green, fontSize: 10, fontWeight: FontWeight.w500, height: 1.3,
                                                  overflow: TextOverflow.ellipsis),overflow: TextOverflow.ellipsis,maxLines: 3,),


                                            ),
                                          ),

                                          // Icon(Icons.favorite, color:greyColor,size: 20,)

                                        ],),
                                    ),

                                    SizedBox(
                                      height: size.height*0.01,
                                    ),
                                    Container(
                                      width: size.width*0.6,
                                      child: Row(

                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8,),
                                            child: Center(
                                              child:  OutlinedButton(

                                                 // onPressed: () => launch("tel:${DummyData.hospitalList[index].phone.toString()}"),
                                                  onPressed: () {

                                                    Navigator.push(
                                                      context,
                                                      PageRouteBuilder(
                                                        pageBuilder: (c, a1, a2) => IncidentReportDetailView(
                                                          address: snapshot
                                                              .data!
                                                              .docs[index]
                                                          ["address"]
                                                              .toString(),
                                                          image: snapshot
                                                              .data!
                                                              .docs[index]
                                                          ["image"]
                                                              .toString(),
                                                          title: snapshot
                                                              .data!
                                                              .docs[index]
                                                          ["title"]
                                                              .toString(),
                                                          description:
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                          ["description"]
                                                              .toString()
                                                          ,

                                                        ),
                                                        transitionsBuilder: (c, anim, a2, child) =>
                                                            FadeTransition(opacity: anim, child: child),
                                                        transitionDuration: Duration(milliseconds: 100),
                                                      ),
                                                    );

                                                  },
                                                  child: new Text("View", style: TextStyle(color: AppColors.greenColor2, fontSize: 12),)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height*0.01,
                                    ),




                                  ],),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );


                    //   GestureDetector(
                    //   onTap: () {
                    //     // Navigator.push(
                    //     //   context,
                    //     //   PageRouteBuilder(
                    //     //     pageBuilder: (c, a1, a2) => UserDetailScreen(
                    //     //       docId: snapshot.data!.docs[index].id.toString(),
                    //     //       userStatus: "Students",
                    //     //
                    //     //     ),
                    //     //     transitionsBuilder: (c, anim, a2, child) =>
                    //     //         FadeTransition(opacity: anim, child: child),
                    //     //     transitionDuration: Duration(milliseconds: 100),
                    //     //   ),
                    //     // );
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         top: 8, bottom: 8, left: 0, right: 0),
                    //     child: Container(
                    //       width: size.width * 0.95,
                    //
                    //       decoration: BoxDecoration(
                    //         border: Border.all(width: 0.5,color: AppColors.greenColor2),
                    //         borderRadius: BorderRadius.circular(10),
                    //         //color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3),
                    //         // gradient:  LinearGradient(
                    //         //   begin: Alignment.centerRight,
                    //         //   end: Alignment.centerLeft,
                    //         //   colors:
                    //         //
                    //         //   <Color>[Color((math.Random().nextDouble() * 0xFFFFFF).toInt()),Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5), ],
                    //         // ),
                    //
                    //
                    //         //whiteColor,
                    //       ),
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(top: 8,bottom: 8),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //
                    //             Container(
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 // color: Colors.green,
                    //               ),
                    //               width: size.width * 0.17,
                    //               child: CircleAvatar(
                    //                 backgroundColor: AppColors.greenColor2,
                    //                 radius: 25,
                    //                 backgroundImage: NetworkImage(
                    //                     snapshot
                    //                         .data!
                    //                         .docs[index]
                    //                     ["image"]
                    //                         .toString()
                    //                 ),
                    //               ),
                    //             ),
                    //             Container(
                    //               //  color: redColor,
                    //               // width: size.width * 0.73,
                    //
                    //               child: Column(
                    //                 //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //
                    //                   Row(
                    //                     children: [
                    //                       Container(
                    //                         //  color: Colors.orange,
                    //                         width: size.width * 0.48,
                    //                         child: Column(
                    //                           crossAxisAlignment: CrossAxisAlignment.start,
                    //                           children: [
                    //                             Container(
                    //                               // color: Colors.yellow,
                    //                               alignment: Alignment.topLeft,
                    //                               child:  Text(
                    //                                 snapshot
                    //                                     .data!
                    //                                     .docs[index]
                    //                                 ["title"]
                    //                                     .toString() ,
                    //                                 overflow: TextOverflow.ellipsis,
                    //                                 style: TextStyle(
                    //                                     color: AppColors.blackColor,
                    //                                     fontSize: 13,
                    //                                     fontWeight: FontWeight.w800,
                    //                                     height: 1.3),
                    //                               ),
                    //                             ),
                    //                             Container(
                    //                               // color: Colors.yellow,
                    //                               alignment: Alignment.topLeft,
                    //                               child:  Text(
                    //                                 snapshot
                    //                                     .data!
                    //                                     .docs[index]
                    //                                 ["description"]
                    //                                     .toString() ,
                    //                                 overflow: TextOverflow.ellipsis,
                    //                                 maxLines: 2,
                    //                                 style: TextStyle(
                    //                                     color: AppColors.blackColor,
                    //                                     fontSize: 12,
                    //                                     fontWeight: FontWeight.w400,
                    //                                     height: 1.3),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //
                    //
                    //                       SizedBox(width: 5,),
                    //
                    //
                    //                       GestureDetector(
                    //                         onTap: () {
                    //
                    //                           // Navigator.push(
                    //                           //   context,
                    //                           //   MaterialPageRoute(builder: (context) => FeedBackReportDetailScreen(
                    //                           //     paitentName: snapshot.data!.docs[index]["name"].toString(),
                    //                           //     screenTitle: "Feedback",
                    //                           //     patientEmail: snapshot.data!.docs[index]["email"].toString(),
                    //                           //     title: snapshot.data!.docs[index]["title"].toString(),
                    //                           //     description: snapshot.data!.docs[index]["description"].toString(),
                    //                           //   )),
                    //                           // );
                    //
                    //                         },
                    //                         child: Container(
                    //                             height: size.height*0.045,
                    //                             width: size.width*0.25,
                    //                             decoration: BoxDecoration(
                    //                                 color: AppColors.purpleColor,
                    //                                 borderRadius: BorderRadius.circular(10)
                    //                             ),
                    //                             child: Center(
                    //                               child: Text("View",
                    //                                 style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500, color: Colors.white),),
                    //                             )
                    //                         ),
                    //                       ),
                    //
                    //                     ],
                    //                   ),
                    //
                    //
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // );
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
