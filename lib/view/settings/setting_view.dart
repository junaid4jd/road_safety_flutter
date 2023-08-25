import 'package:flutter/material.dart';
import 'package:road_safety/model/dummy_data.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/components/app_text.dart';
import 'package:road_safety/view/authentication/userType/usertype_screen.dart';
import 'package:road_safety/view/profile_view/profile_view.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {





  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor3,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.purpleColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: TextStylesData.titleFontSize),
        ),
      ),

      body:   SingleChildScrollView(
        child: Column(

          children: [
            Container(
                child:Stack(children: <Widget>[ //stack overlaps widgets
                  Opacity( //semi red clippath with more height and with 0.5 opacity
                    opacity: 0.5,
                    child: ClipPath(
                      clipper:WaveClipper(), //set our custom wave clipper
                      child:Container(
                        color:AppColors.greenColor2,
                        height:200,
                      ),
                    ),
                  ),

                  ClipPath(  //upper clippath with less height
                    clipper:WaveClipper(), //set our custom wave clipper.
                    child:Container(
                      color:AppColors.purpleColor,
                      height:180,
                      alignment: Alignment.topCenter,
                      child:            Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Image.asset('assets/images/logo.png', height: 50,width: 50,fit: BoxFit.scaleDown,),
                            ),
                          ),
                          Text('ROAD SAFETY', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center),
                        ],
                      ),

                    ),
                  ),
                ],)
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            Container(
              //width: size.width*0.9,
              height: size.height*0.8,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: DummyData.settingList.length,
                  itemBuilder: ( context ,  index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4,bottom: 4,left: 8,right: 8),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.whiteColor,
                        ),
                        // color: AppColors.lightGreyColor,
                        //width: size.width*0.9,
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              if(index == 0 ) {

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => ProfileView(),
                                    transitionDuration: Duration(milliseconds: 300),
                                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                                  ),
                                );
                              } else if (index == 2) {
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => UserType(),
                                    transitionDuration: Duration(milliseconds: 300),
                                    transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
                                  ),
                                );
                              }



                            },
                            hoverColor: AppColors.whiteColor,
                            splashColor: AppColors.whiteColor,
                            minLeadingWidth: 60,
                            minVerticalPadding: 10,
                            horizontalTitleGap: 10,
                            contentPadding: EdgeInsets.zero,

                            leading: Padding(
                              padding: const EdgeInsets.only(left: 4,bottom: 6),
                              child: Container(
                                width: 50,height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.greenColor2.withOpacity(0.2)
                                ),
                                child: Center(child: DummyData.settingList[index].icon),
                              ),
                            ),
                            title: Text(DummyData.settingList[index].name.toString(), style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),),
                            //      trailing: Icon(Icons.arrow_forward_ios, color: AppColors.purpleColor,size: 13,),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
