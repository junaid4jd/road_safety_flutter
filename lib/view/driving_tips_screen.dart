import 'package:flutter/material.dart';

import '../res/colors.dart';

class DrivingTipsScreen extends StatefulWidget {
  const DrivingTipsScreen({super.key});

  @override
  State<DrivingTipsScreen> createState() => _DrivingTipsScreenState();
}

class _DrivingTipsScreenState extends State<DrivingTipsScreen> {
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
          'Driving Tips and Tricks',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              "Focus on driving",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "Ignoring distractions while driving and maintaining focus on the road is key to driving safely. In order to keep focused while driving, you should follow these steps:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "● Keep 100% of your attention on driving at all times – no multi-tasking.\n● Don’t use your phone or any other electronic device while driving.\n● Slow down. Speeding gives you less time to react and increases the severity of an accident.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),

            Text(
              "Defensive driving",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "What is defensive driving? Defensive driving is when motorists use accident-preventing techniques with a focus on driving safely. You may even be eligible for a defensive driving discount. To practice defensive driving:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "● Be aware of what other drivers around you are doing, and expect the unexpected.\n● Assume other motorists will do something crazy, and always be prepared to avoid it.\n● Keep a 2-second cushion between you and the car in front of you.\n● Make that 4 seconds if the weather is bad.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),


            SizedBox(
              height: size.height * 0.03,
            ),

            Text(
              "Make a safe driving plan",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "● Build time into your trip schedule to stop for food, rest breaks, phone calls or other business.\n● Adjust your seat, mirrors, and climate controls before putting the car in gear.\n● Pull over to eat or drink. It takes only a few minutes.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),


            Text(
              "Practice safety",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "● Secure cargo that may move around while the vehicle is in motion.\n● Don’t attempt to retrieve items that fall to the floor.\n● Have items needed within easy reach – such as toll fees, toll cards and garage passes.\n● Always wear your seat belt and drive sober and drug-free.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(
              height: size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
