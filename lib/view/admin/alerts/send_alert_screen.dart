

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/utils/utils.dart';

class SendAlertScreen extends StatefulWidget {
  const SendAlertScreen({super.key});

  @override
  State<SendAlertScreen> createState() => _SendAlertScreenState();
}

class _SendAlertScreenState extends State<SendAlertScreen> {
  var _titleController = TextEditingController();
  var _messageController = TextEditingController();
  bool _isLoading = false;

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
          'Send Alert',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: TextFormField(
              controller: _titleController,
              keyboardType: TextInputType.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColors.lightGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "Alert Title",

                //make hint text
                hintStyle: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 16,
                  fontFamily: "verdana_regular",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: TextFormField(
              controller: _messageController,
              keyboardType: TextInputType.name,
              maxLines: 5,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: AppColors.lightGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "Alert Message",

                //make hint text
                hintStyle: TextStyle(
                  color: AppColors.greyColor,
                  fontSize: 16,
                  fontFamily: "verdana_regular",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          _isLoading
              ? CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          )
              : Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5.0)
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Colors.green,
                    Colors.green,
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    minimumSize:
                    MaterialStateProperty.all(Size(size.width, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.green),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () async {
                    if (_titleController.text.isEmpty) {
                      Utils.flushBarErrorMessage("Alert Title is required",
                          context, AppColors.darkRedColor, "Error", 2);
                    } else if (_messageController.text.isEmpty) {
                      Utils.flushBarErrorMessage("Alert Message is required",
                          context, AppColors.darkRedColor, "Error", 2);
                    }else {
                      setState(() {
                        _isLoading = true;
                      });
                      sendAlert();
                    }
                  },
                  child: Text('Send Alert')),
            ),
          ),
        ],
      ),
    );
  }

  void sendAlert() {
    FirebaseFirestore.instance.collection("Alerts").doc().set({
      "title": _titleController.toString(),
      "message": _messageController.text.toString(),
    }).then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
      Utils.flushBarErrorMessage("Alert sent successfully", context,
          AppColors.greenColor2, "Success", 2);
    });
  }
}
