import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/view/emergency_service/carRepair/car_repir_list_view.dart';
import 'package:road_safety/view/emergency_service/hospitalView/hospital_list_view.dart';
import 'package:road_safety/view/emergency_service/rop/rop_view.dart';

class EmergencyService extends StatefulWidget {
  const EmergencyService({super.key});

  @override
  State<EmergencyService> createState() => _EmergencyServiceState();
}

class _EmergencyServiceState extends State<EmergencyService> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blackColor, size: 25),
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: AppColors.greenColor2,
        title: Text(
          'Emergency Service',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.whiteColor,

      body: Container(
        //  color: Colors.red,
        // height: size.height * .22,
        width: size.width ,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("EmergencyService").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: AppColors.lightGreyColor,
                  ));
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              // got data from snapshot but it is empty

              return Center(child: Text("No Data Found"));
            } else {
              return  Padding(
                padding: const EdgeInsets.only(left: 8,right: 8, top: 16),
                child: Container(

                  child: GridView.builder(
                      padding: EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisExtent: size.height * 0.22,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16),
                      itemCount:snapshot.data!.docs.length,

                      itemBuilder: (BuildContext ctx, index) {

                        return InkWell(
                          onTap: () {
                            if(index == 0) {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CarRepairListView()));

                            }
                            else if(index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RoyalOmanPoliceView()));
                            }
                            else if(index == 2) {

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HospitalListView()));

                            }
                            else {

                            }

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4,right: 4),
                            child: Container(
                              // height: size.height*0.25,
                              width: size.width*0.43,
                              decoration: BoxDecoration(
                                color:
                                index == 0 ? AppColors.purpleColor.withOpacity(0.5) :
                                index == 1 ? AppColors.greenColor2.withOpacity(0.5) :
                                index == 2 ? AppColors.darkRedColor.withOpacity(0.5) :
                                index == 3 ? AppColors.orangeColor.withOpacity(0.5) :
                                Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColors.lightGreyColor,
                                      spreadRadius: 2,
                                      blurRadius: 3
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(snapshot.data!.docs[index]["image"].toString(), fit: BoxFit.scaleDown,
                                          height: size.height*0.08,
                                          width: size.width*0.4,
                                          // height: 80,
                                          // width: 80,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      width: size.width*0.43,
                                      child: Center(
                                        child: Text( snapshot.data!.docs[index]["name"].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                          TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),



                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }
          },
        ),
      ),


    );
  }
}
