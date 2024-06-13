import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/components/app_text.dart';
import 'package:road_safety/view/admin/alerts/alerts_screen.dart';
import 'package:road_safety/view/driving_tips_screen.dart';
import 'package:road_safety/view/emergency_service/emergency_service_view.dart';
import 'package:road_safety/view/feedbackReport/feedback/feedback_screen.dart';
import 'package:road_safety/view/incidentReport/incident_report_view.dart';
import 'package:road_safety/view/viewMap/view_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int current = 0;
  int selectedIndex = 1000;
  bool isNewAlert = false;
  int alertCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      selectedIndex = 1000;
    });
    checkNewAlerts();
    super.initState();
  }

  checkNewAlerts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    alertCount = await prefs.getInt("alertsCount") ?? 0;

    FirebaseFirestore.instance.collection('Alerts').get().then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          if (alertCount < value.docs.length) {
            setState(() {
              isNewAlert = true;
            });
            alertCount = value.docs.length;
            prefs.setInt("alertsCount", alertCount);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> banners1 = [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          height: 170,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl:
              'https://cdn.expatwoman.com/s3fs-public/5b0a494f-31a6-4071-afc8-c17063e65499.jpg',
          //   placeholder: (context, url) => CircularProgressIndicator(color: darkRedColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          height: 170,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl:
              'https://images.slideplayer.com/19/5730701/slides/slide_4.jpg',
          //   placeholder: (context, url) => CircularProgressIndicator(color: darkRedColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          height: 170,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          imageUrl:
              'https://cdn4.premiumread.com/?url=https://www.omanobserver.om/omanobserver/uploads/images/2022/04/06/1966532.jpg&w=840&q=90&f=jpg',
          //   placeholder: (context, url) => CircularProgressIndicator(color: darkRedColor,),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor3,
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              color: AppColors.greenColor2,
              child: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/logo.png', fit: BoxFit.scaleDown,
                      height: 80,
                      width: 80,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.blackColor),
        leading: Icon(Icons.menu),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TextStylesData.appBarRound),
        ),
        title: Text(
          AppText.appName,
          style: TextStyle(
              color: AppColors.darkGreenColor,
              fontWeight: FontWeight.bold,
              fontSize: TextStylesData.titleFontSize),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isNewAlert = false;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AlertsScreen(
                            )));
              },
              icon: Stack(
                children: [
                  Icon(
                    Icons.notifications_active_outlined,
                    color: AppColors.blackColor,
                    size: 30,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Visibility(
                      visible: isNewAlert,
                      child: Container(
                        margin: EdgeInsets.only(left: 14),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: CarouselSlider(
                    items: banners1,
                    options: CarouselOptions(
                      height: size.height * 0.2,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.999,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                    )),
              ),
            ),
            AnimatedSmoothIndicator(
              activeIndex: current,
              count: 3, //pages.length,
              effect: JumpingDotEffect(
                  dotHeight: 7,
                  dotWidth: 7,
                  jumpScale: .7,
                  verticalOffset: 10,
                  activeDotColor: AppColors.darkGreenColor,
                  dotColor: Colors.grey),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              width: size.width,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("categories")
                    .snapshots(),
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
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 16),
                      child: Container(
                        child: GridView.builder(
                            padding: EdgeInsets.only(top: 8),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisExtent: size.height * 0.22,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return InkWell(
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                IncidentReportView()));
                                  }

                                  if (index == 1) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FeedbackScreen()));
                                  }

                                  if (index == 2) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DrivingTipsScreen()));
                                  }
                                  if (index == 3) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EmergencyService()));
                                  } else {
                                    // Navigator.push(
                                    //   context,
                                    //   PageRouteBuilder(
                                    //     pageBuilder: (c, a1, a2) => CategoryItemScreen(category: snapshot.data!.docs[index]["categoryName"].toString(),),
                                    //     transitionsBuilder: (c, anim, a2, child) =>
                                    //         FadeTransition(opacity: anim, child: child),
                                    //     transitionDuration: Duration(milliseconds: 0),
                                    //   ),
                                    // );
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 4),
                                  child: Container(
                                    // height: size.height*0.25,
                                    width: size.width * 0.43,
                                    decoration: BoxDecoration(
                                      color: index == 0
                                          ? AppColors.purpleColor
                                              .withOpacity(0.5)
                                          : index == 1
                                              ? AppColors.greenColor2
                                                  .withOpacity(0.5)
                                              : index == 2
                                                  ? AppColors.darkRedColor
                                                      .withOpacity(0.5)
                                                  : index == 3
                                                      ? AppColors.orangeColor
                                                          .withOpacity(0.5)
                                                      : index == 4
                                                          ? Colors.teal
                                                              .withOpacity(0.5)
                                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.lightGreyColor,
                                            spreadRadius: 2,
                                            blurRadius: 3)
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            snapshot.data!.docs[index]["image"]
                                                .toString(),
                                            fit: BoxFit.scaleDown,
                                            height: size.height * 0.08,
                                            width: size.width * 0.4,
                                            // height: 80,
                                            // width: 80,
                                          ),
                                        ),
                                        Container(
                                          width: size.width * 0.43,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Text(
                                                snapshot
                                                    .data!.docs[index]["name"]
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
          ],
        ),
      ),
    );
  }
}
