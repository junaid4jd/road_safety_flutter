import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:road_safety/model/input_validator.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddIncidentReportView extends StatefulWidget {
  const AddIncidentReportView({super.key});

  @override
  State<AddIncidentReportView> createState() => _AddIncidentReportViewState();
}

class _AddIncidentReportViewState extends State<AddIncidentReportView> {

  final TextEditingController _titleControoler = TextEditingController();
  final TextEditingController _descriptionControoler = TextEditingController();
  final TextEditingController _addressControoler = TextEditingController();


  InputValidator _inputValidator = InputValidator();


  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;


  PickedFile? _pickedFile;
  File? imageFile;
  bool isLoading = false;
  bool isLoadingImage = false;

  //final FirebaseAuth auth = FirebaseAuth.instance;
  String? profileImage = '', docId;

  void _showPicker(context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {

                        _imgFromGallery();
                        setState(() {
                          isLoadingImage = true;
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      setState(() {
                        isLoadingImage = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50))!;

    getUrl(_pickedFile!.path).then((value) {
      if (value != null) {
        setState(() {
          profileImage = value.toString();
          prefs.setString('profileImage', profileImage.toString());
          isLoadingImage = false;
        });

      } else {
        setState(() {
          isLoadingImage = false;
        });
        print('sorry error');
      }
    });

    setState(() {
      imageFile = File(_pickedFile!.path);
      //image = 'done';
      // isLoadingImage = false;
      print('List Printed');

    });
  }

  _imgFromGallery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    _pickedFile = (await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50))!;
    getUrl(_pickedFile!.path).then((value) {
      if (value != null) {
        setState(() {
          profileImage = value.toString();
          prefs.setString('profileImage', profileImage.toString());
          isLoadingImage = false;
        });

      } else {
        setState(() {
          isLoadingImage = false;
        });
        print('sorry error');
      }
    });
    setState(() {
      imageFile = File(_pickedFile!.path);
      //  isLoadingImage = false;
      //image = 'done';
      print('List Printed');

    });
  }

  Future<String?> getUrl(String path) async {
    final file = File(path);
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref()
        .child("image" + DateTime.now().toString())
        .putFile(file);
    if (snapshot.state == TaskState.success) {
      return await snapshot.ref.getDownloadURL();
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.greenColor2,
        title: Text(
          'Add Incident Report',
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
        child: Column(
          children: [

            SizedBox(
              height: size.height*0.02,
            ),

            Center(
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
            SizedBox(
              height: size.height*0.02,
            ),



            Container(
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
              child: TextFormField(
                controller: _titleControoler,
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
                  hintText: "Title",

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
              height: size.height*0.02,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
              child: TextFormField(
                controller: _descriptionControoler,
                keyboardType: TextInputType.text,
                maxLines: 3,
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
                  hintText: "Description",

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
              height: size.height*0.02,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
              child: TextFormField(
                controller: _addressControoler,
                keyboardType: TextInputType.text,
                maxLines: 2,
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
            SizedBox(
              height: size.height*0.02,
            ),
            Center(
              child:  OutlinedButton(

                  onPressed: () => _showPicker(context),
                  child: new Text("Upload incident picture", style: TextStyle(color: AppColors.greenColor2, fontSize: 12),)),
            ),
            SizedBox(
              height: size.height*0.01,
            ),

            profileImage == '' ?

            Container()
                : Image.network(profileImage.toString(),
              width: 120,
              height: 150,
              fit: BoxFit.scaleDown,
            )
            ,

            SizedBox(
              height: size.height*0.05,
            ),


            _isLoading
                ? CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 2,
            )
                :

            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Container(

                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.green),
                      // elevation: MaterialStateProperty.all(3),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),

                    onPressed: () async {
                      if(_titleControoler.text.isEmpty)
                      {
                        Utils.flushBarErrorMessage("Title is required", context, AppColors.darkRedColor, "Error", 2);

                      }
                      else if(_descriptionControoler.text.isEmpty)
                      {
                        Utils.flushBarErrorMessage("Description is required", context, AppColors.darkRedColor, "Error", 2);

                      }
                      else if(_addressControoler.text.isEmpty)
                      {
                        Utils.flushBarErrorMessage("Address is required", context, AppColors.darkRedColor, "Error", 2);

                      }
                      else if(profileImage == '')
                      {
                        Utils.flushBarErrorMessage("Upload incident picture", context, AppColors.darkRedColor, "Error", 2);
                      }

                      else {
                        setState(() {
                          _isLoading = true;
                          print('We are in loading');
                          //  state = ButtonState.loading;
                        });

                        FirebaseFirestore.instance
                            .collection('IncidentReport')
                            .doc()
                            .set({
                          "title": _titleControoler.text.trim(),
                          "uid": _auth.currentUser!.uid.toString(),
                          'image': profileImage.toString(),
                          "description": _descriptionControoler.text,
                          "address": _addressControoler.text,

                        }).then((value){


                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pop();
                          Utils.flushBarErrorMessage("Incident report submitted successfully", context, AppColors.greenColor2, "Success", 2);


                        });





                      }
                    }, child: Text('Add incident')),
              ),
            ),
            // SizedBox(
            //   height: size.height*0.1,
            // ),


          ],
        ),
      ),

    );
  }
}
