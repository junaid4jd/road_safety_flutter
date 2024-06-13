import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/colors.dart';
import '../../utils/utils.dart';

class AddEmergencyDetailScreen extends StatefulWidget {
  final String? type;

  const AddEmergencyDetailScreen({super.key, this.type});

  @override
  State<AddEmergencyDetailScreen> createState() =>
      _AddEmergencyDetailScreenState();
}

class _AddEmergencyDetailScreenState extends State<AddEmergencyDetailScreen> {
  var _nameController = TextEditingController();
  var _statusController = TextEditingController();
  var _serviceController = TextEditingController();
  var _phoneController = TextEditingController();
  var _addressController = TextEditingController();
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
          'Add ${widget.type}',
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
              controller: _nameController,
              keyboardType: TextInputType.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              onChanged: (value) {
                // setState(() {
                //   userInput.text = value.toString();
                // });
              },
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                //add prefix icon

                // errorText: "Error",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.lightGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "Name",

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
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: TextFormField(
              controller: _statusController,
              keyboardType: TextInputType.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              onChanged: (value) {
                // setState(() {
                //   userInput.text = value.toString();
                // });
              },
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                //add prefix icon

                // errorText: "Error",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.lightGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "Open/Close Timings",

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
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: TextFormField(
              controller: _serviceController,
              keyboardType: TextInputType.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              onChanged: (value) {
                // setState(() {
                //   userInput.text = value.toString();
                // });
              },
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                //add prefix icon

                // errorText: "Error",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.lightGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "Services",

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
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              onChanged: (value) {
                // setState(() {
                //   userInput.text = value.toString();
                // });
              },
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                //add prefix icon

                // errorText: "Error",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.lightGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "Address",

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
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(left: 16, right: 16, bottom: 15),
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.name,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              onChanged: (value) {
                // setState(() {
                //   userInput.text = value.toString();
                // });
              },
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                focusColor: Colors.white,
                //add prefix icon

                // errorText: "Error",

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.lightGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.grey,
                hintText: "Phone Number",

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
                          if (_nameController.text.isEmpty) {
                            Utils.flushBarErrorMessage("Name is required",
                                context, AppColors.darkRedColor, "Error", 2);
                          } else if (_phoneController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                "Phone number is required",
                                context,
                                AppColors.darkRedColor,
                                "Error",
                                2);
                          } else if (_statusController.text.isEmpty) {
                            Utils.flushBarErrorMessage(
                                "Opening/Closing time is required",
                                context,
                                AppColors.darkRedColor,
                                "Error",
                                2);
                          } else if (_addressController.text.isEmpty) {
                            Utils.flushBarErrorMessage("Address is required",
                                context, AppColors.darkRedColor, "Error", 2);
                          } else if (_serviceController.text.isEmpty) {
                            Utils.flushBarErrorMessage("Services is required",
                                context, AppColors.darkRedColor, "Error", 2);
                          } else {
                            setState(() {
                              _isLoading = true;
                              print('We are in loading');
                              //  state = ButtonState.loading;
                            });
                            addEmergencyService();
                          }
                        },
                        child: Text('Add ${widget.type}')),
                  ),
                ),
        ],
      ),
    );
  }

  addEmergencyService() {
    FirebaseFirestore.instance.collection(widget.type ?? "Hospital").doc().set({
      "name": _nameController.toString(),
      "service": _serviceController.text.toString(),
      "phone": _phoneController.text.toString(),
      "status": _statusController.text.toString(),
      'address': _addressController.text.toString(),
      "image": ""
    }).then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
      Utils.flushBarErrorMessage("Feedback submitted successfully", context,
          AppColors.greenColor2, "Success", 2);
    });
  }
}
