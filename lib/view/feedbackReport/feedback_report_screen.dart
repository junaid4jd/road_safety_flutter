import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/model/input_validator.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/utils/utils.dart';

class FeedbackReportScreen extends StatefulWidget {
  final String title;
  final String mechanicId;
  final String mechanicName;
  const FeedbackReportScreen({Key? key,
    required this.title,
    required this.mechanicId,
    required this.mechanicName,

  }) : super(key: key);

  @override
  _FeedbackReportScreenState createState() => _FeedbackReportScreenState();
}

class _FeedbackReportScreenState extends State<FeedbackReportScreen> {
  final TextEditingController _titleControoler = TextEditingController();
  final TextEditingController _descriptionControoler = TextEditingController();


  InputValidator _inputValidator = InputValidator();


  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? userEmail = '', userName = '', userUid = '';
  getRenter() async {

    await FirebaseFirestore.instance
        .collection('Users')
        .where('uid',isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userName = value.docs[0]['name'];
        userEmail = value.docs[0]['email'];
        userUid = _auth.currentUser!.uid;
      });
    });
    print(userName.toString() + ' name is here');
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      userName = '';
      userEmail = '';
      userUid = '';
    });
    getRenter();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.purpleColor,

      resizeToAvoidBottomInset: false,
      body:  SingleChildScrollView(
        child: Container(
          //height: size.height,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              SizedBox(
                height: size.height*0.05,
              ),
              Container(
                width: size.width,
                child: Row(children: [

                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: IconButton(onPressed: (){
                      Navigator.of(context).pop();

                    }, icon: Icon(Icons.arrow_back_ios, size: 18,color: AppColors.lightGreyColor,)),
                  )

                ],),
              ),

              SizedBox(
                height: size.height*0.03,
              ),

              Container(height: size.height*0.8,
                decoration: BoxDecoration(
                  //color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)
                    )
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [

                      SizedBox(
                        height: size.height*0.03,
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
                        height: size.height*0.03,
                      ),

                      Center(
                          child: Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 26,fontWeight: FontWeight.bold),)
                      ),

                      SizedBox(
                        height: size.height*0.05,
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
                          maxLines: 7,
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
                        height: size.height*0.05,
                      ),


                      _isLoading
                          ? CircularProgressIndicator(
                        color: Colors.white,
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

                                else {
                                  setState(() {
                                    _isLoading = true;
                                    print('We are in loading');
                                    //  state = ButtonState.loading;
                                  });

                                  FirebaseFirestore.instance
                                      .collection(widget.title.toString())
                                      .doc()
                                      .set({
                                    "email": userEmail.toString(),
                                    "title": _titleControoler.text.trim(),
                                    "uid": _auth.currentUser!.uid.toString(),
                                    "name": userName.toString(),
                                    'userId': widget.mechanicId.toString(),
                                    'userName': widget.mechanicName.toString(),
                                    "description": _descriptionControoler.text,

                                  }).then((value){


                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.of(context).pop();
                                    Utils.flushBarErrorMessage("Feedback submitted successfully", context, AppColors.greenColor2, "Success", 2);


                                  });





                                }
                              }, child: Text('Submit ${widget.title}')),
                        ),
                      ),
                      // SizedBox(
                      //   height: size.height*0.1,
                      // ),


                    ],
                  ),
                ),

              ),
            ],),
        ),
      ),
    );
  }
}
