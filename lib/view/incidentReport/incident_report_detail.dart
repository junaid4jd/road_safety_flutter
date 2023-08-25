import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/constants.dart';

class IncidentReportDetailView extends StatefulWidget {
  final String image;
  final String address;
  final String title;
  final String description;
  const IncidentReportDetailView({super.key,
  required this.address,
  required this.image,
  required this.title,
  required this.description,
  });

  @override
  State<IncidentReportDetailView> createState() => _IncidentReportDetailViewState();
}

class _IncidentReportDetailViewState extends State<IncidentReportDetailView> {
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
          'Incident Detail',
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

      body: SingleChildScrollView(
        //  height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              //      height: size.height*0.3,
              width: size.width,
              decoration: BoxDecoration(
                color: lightButtonGreyColor,
                //  borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                //borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  height: size.height * 0.3,
                  width: size.width,
                  fit: BoxFit.cover,
                  imageUrl: widget.image.toString(),
                  //placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Container(
              width: size.width ,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.95,
                          child: Text(
                            widget.title.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: size.width * 0.95,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                            'Description',
                                  style: TextStyle(
                                      color: AppColors.purpleColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  widget.description.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: size.width * 0.95,
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Address',
                                  style: TextStyle(
                                      color: AppColors.purpleColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  widget.address.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),

          ],
        ),
      ),

    );
  }
}
