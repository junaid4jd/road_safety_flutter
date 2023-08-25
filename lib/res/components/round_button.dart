import 'package:flutter/material.dart';
import 'package:road_safety/res/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final Color color;
  final double round;
  final double width;
  final VoidCallback onPress;

  const RoundButton(
      {super.key,
      required this.title,
      required this.width,
      this.isLoading = false,
      required this.onPress,
      required this.color,
      required this.round});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: AppColors.lightBlueColor,
            strokeWidth: 2,
          ))
        : Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Container(
              decoration:
              title == 'Upload recent salary slip'
                  || title ==  'Upload your id'
                  || title ==  'Upload bank transfer guarantee'
                  || title ==  'Upload Promissory'
                  || title ==  'Upload official agreement with Jam3ia'

                  ?
              BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 1),
                      blurRadius: 5.0)
                ],
                color: AppColors.whiteColor,
                border: Border.all(color: AppColors.purpleColor,width: 1),
                borderRadius: BorderRadius.circular(round),
              ) :
              BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 5.0)
                ],
                color: color,
                borderRadius: BorderRadius.circular(round),
              ) ,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(width, 50)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: onPress,
                  child: Text(
                    title,
                    style:  TextStyle(color:
                    title == 'Upload recent salary slip'
                        || title ==  'Upload your id'
                        || title ==  'Upload bank transfer guarantee'
                        || title ==  'Upload Promissory'
                        || title ==  'Upload official agreement with Jam3ia'
                        ? AppColors.purpleColor :
                    Colors.white),
                  )),
            ),
          );
  }
}
