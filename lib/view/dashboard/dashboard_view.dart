import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/view/home/home_view.dart';
import 'package:road_safety/view/settings/setting_view.dart';

//class needs to extend StatefulWidget since we need to make changes to the bottom app bar according to the user clicks
class DashboardView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardViewState();
  }
}

class DashboardViewState extends State<DashboardView> {
  bool clickedCentreFAB = false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex = 0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";

  int _selectedIndex = 0;
  List<Widget> _pages = [
    HomeView(),
    // MyContent(),
    SettingView()
  ];


  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      if(index== 0) {
        setState(() {
          _pages[0] = HomeView();
        });
      }  else if(index== 1) {
        setState(() {
          _pages[1] = SettingView();
        });
      } else {
      }

      text = buttonText;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor3,
      body: _pages.elementAt(selectedIndex),
      //specify the location of the FAB
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.only(left: 0.0, right: 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                //update the bottom app bar view each time an item is clicked
                onPressed: () {
                  updateTabSelection(0, "Home");
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                iconSize: 27.0,
                icon: Image.asset('assets/images/home.png',
                  color: _selectedIndex == 0 ? Colors.orange : AppColors.greyColor,
                  fit: BoxFit.scaleDown,width: 25,height: 25,),
              ),
              //to leave space in between the bottom app bar items and below the FAB
              IconButton(
                onPressed: () {
                  updateTabSelection(1, "settings");
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                iconSize: 27.0,
                icon: Image.asset('assets/images/user.png',
                  color: _selectedIndex == 1 ? Colors.orange : AppColors.greyColor,
                  fit: BoxFit.scaleDown,width: 25,height: 25,),
              ),
            ],
          ),
        ),
        //to add a space between the FAB and BottomAppBar
        shape: CircularNotchedRectangle(),
        //color of the BottomAppBar

      ),
    );
  }
}