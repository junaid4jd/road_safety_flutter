
import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/view/authentication/login_view.dart';




class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child:Stack(children: <Widget>[ //stack overlaps widgets
                  Opacity( //semi red clippath with more height and with 0.5 opacity
                    opacity: 0.5,
                    child: ClipPath(
                      clipper:WaveClipper(), //set our custom wave clipper
                      child:Container(
                        color:AppColors.greenColor2,
                        height:300,
                      ),
                    ),
                  ),

                  ClipPath(  //upper clippath with less height
                    clipper:WaveClipper(), //set our custom wave clipper.
                    child:Container(
                      padding: EdgeInsets.only(bottom: 50),
                      color:AppColors.purpleColor,
                      height:280,
                      alignment: Alignment.center,
                      child:            Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset('assets/images/logo.png', height: 100,width: 100,fit: BoxFit.scaleDown,),
                          ),
                          Text('ROAD SAFETY', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center),
                        ],
                      ),

                    ),
                  ),
                ],)
            ),
            SizedBox(
              height: size.height*0.1,
            ),
            Container(

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                ],
                // border: Border.all(width: 0.5,color: Colors.black),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    AppColors.greenColor2,
                    AppColors.greenColor2,
                  ],
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(AppColors.greenColor2),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),

                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        LoginView(userType: 'Admin',)));

                  }, child: Text('Admin', // style: buttonStyle
              )),
            ),
          SizedBox(
            height: size.height*0.03,
          ),
            Container(

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                ],
                border: Border.all(color: Colors.white,width: 0.2),
               // color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  colors: [
                    AppColors.greenColor2,
                    AppColors.greenColor2,
                  ],
                ),
                // color: Colors.deepPurple.shade300,
                borderRadius: BorderRadius.circular(0),
              ),

              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),

                    ),
                    minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(AppColors.greenColor2),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),

                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginView(userType: 'Users',)));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                    // );

                  }, child: Text('User / Driver', //style: buttonStyle.copyWith(color: Colors.white)

              )),
            ),
          SizedBox(
            height: size.height*0.03,
          ),


        ],),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {

    var path = new Path();
    path.lineTo(0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
