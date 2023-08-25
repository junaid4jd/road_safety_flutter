import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/components/app_text.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor3,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),

        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
              color: AppColors.darkGreenColor,
              fontWeight: FontWeight.bold,
              fontSize: TextStylesData.titleFontSize),
        ),

      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Center(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 4),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index){

                return Padding(
                  padding: const EdgeInsets.only(top: 4,bottom: 4),
                  child: Container(


                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    width: size.width*0.9,
                    child: Center(
                      child: ListTile(
                        onTap: () {
                          // Navigator.pushNamed(context, RoutesName.circleView);
                        },
                        hoverColor: AppColors.whiteColor,
                        splashColor: AppColors.whiteColor,
                        minLeadingWidth: 40,
                        minVerticalPadding: 0,
                        horizontalTitleGap: 10,
                        contentPadding: EdgeInsets.zero,
                        leading:Padding(
                          padding: const EdgeInsets.only(left: 4,bottom: 6,right: 8),
                          child: Container(
                            width: 40,height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greenColor2.withOpacity(0.2)
                            ),
                            child: Center(child: Icon(Icons.notification_important_outlined, size: 20,color: AppColors.greenColor2,),),
                          ),
                        ),
                        title: Text('Join circle ', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),),
                        subtitle: Text('With amount 10,000 EGP.', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w400),),
                       // trailing: Icon(Icons.arrow_forward_ios, color: AppColors.purpleColor,size: 13,),
                      ),
                    ),
                  ),
                );

              }),
        ),
      ),

    );
  }
}
