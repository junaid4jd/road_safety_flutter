import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/components/app_text.dart';
import 'package:road_safety/res/components/round_button.dart';
import 'package:road_safety/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String userName = '', address = '';
  bool isLoading = false;
  String name = '',email = '', docId = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;


  getData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('uid',isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        docId = value.docs[0].id.toString();
        name = value.docs[0]['name'];
        email = value.docs[0]['email'];
        _emailAddressController.text = value.docs[0]['email'];
        _phoneController.text = value.docs[0]['phone'];
        _nameController.text = value.docs[0]['name'];
        _addressController.text = value.docs[0]['address'];
      });
    });

    print(userName.toString() + ' name is here');

  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  bool isLoadingImage = false;

  //final FirebaseAuth auth = FirebaseAuth.instance;
  String? profileImage = '',
      driverEmail = '',
      driverName = '',
      driverUid = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor3,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              color: AppColors.darkGreenColor,
              fontWeight: FontWeight.bold,
              fontSize: TextStylesData.titleFontSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Stack(children: [
              ClipOval(
                child: profileImage == ''
                    ? Image.network(
                        'https://www.omanobserver.om/omanobserver/uploads/images/2021/11/24/1827722.jpg',
                        width: 120,
                        // color: Colors.grey,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        profileImage.toString(),
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
              ),
              // Positioned(
              //   left: size.width * 0.2,
              //   top: size.height * 0.1,
              //   child: InkWell(
              //     // onTap: () =>    _showPicker(context),
              //     child: Container(
              //       decoration: BoxDecoration(
              //           // color: Colors.black.withOpacity(0.3), shape: BoxShape.circle,
              //           // border: Border.all(width: 1, color: Theme.of(context).primaryColor),
              //           ),
              //       child: Container(
              //         // height: 30,
              //         // width: 30,
              //         margin: EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           //border: Border.all(width: 2, color: Colors.white),
              //           color: Colors.white,
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Colors.black26,
              //                 offset: Offset(0, 4),
              //                 blurRadius: 2.0)
              //           ],
              //           shape: BoxShape.circle,
              //         ),
              //         child: Center(
              //           child: Padding(
              //             padding: const EdgeInsets.all(5.0),
              //             child: Image.asset(
              //               'assets/images/editProfile.png',
              //               width: 15,
              //               height: 15,
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ])),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
                width: size.width,
                child: Center(
                  child: Text(
                    '$name',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
                width: size.width,
                child: Center(
                  child: Text(
                    '$email',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  ),
                )),
            SizedBox(
              height: size.height * 0.0,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: TextFormField(
                      controller: _nameController,
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
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        hintText: "Full Name",

                        //make hint text
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                        //create lable
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: TextFormField(
                      controller: _emailAddressController,
                      enabled: false,
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
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        hintText: "Email",

                        //make hint text
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                        //create lable
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: TextFormField(
                      controller: _phoneController,
                      enabled: false,
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
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        hintText: "Phone",

                        //make hint text
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                        //create lable
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.lightGreyColor2,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 0),
                    child: TextFormField(
                      controller: _addressController,
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
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.purpleColor, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        hintText: "Address",

                        //make hint text
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),

                        //create lable
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  isLoading
                      ? CircularProgressIndicator(
                    color: Colors.orange,
                    strokeWidth: 2,
                  )
                      :
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: RoundButton(
                      width: size.width,
                      //isLoading: authViewModel.loading,
                      round: 30.0,
                      color: AppColors.orangeColor,
                      title: 'Update',
                      onPress: () async {

                        if(_nameController.text.isEmpty) {
                          Utils.flushBarErrorMessage("Name is required", context, AppColors.darkRedColor, "Error", 2);

                        } else if (_addressController.text.isEmpty) {
                          Utils.flushBarErrorMessage("Address is required", context, AppColors.darkRedColor, "Error", 2);

                        } else {
                          setState(() {
                            isLoading = true;
                          });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(docId)
        .update({
      'name':_nameController.text,
      'address':_addressController.text,
    })
        .then((value) {
      setState(() {
        isLoading = false;
      });
          Navigator.of(context).pop();
      Utils.flushBarErrorMessage("Updated successfully", context, AppColors.greenColor2, "Success", 2);



    });

                        }

                        // Navigator.pushNamed(context, RoutesName.dashView);
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
