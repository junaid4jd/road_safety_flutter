import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewMap extends StatefulWidget {
  const ViewMap({super.key});

  @override
  State<ViewMap> createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  String onTapped = 'cover';

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  static CameraPosition? _kGooglePlexCurrent;
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.4735, 55.9754),
    zoom: 15.4746,
  );
  openMap() async {
    if (await canLaunch(
        _currentPosition != null ?
        'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}'
            :
        'https://www.google.com/maps/search/?api=1&query=${21.4735},${55.9754}')) {
      await launch(
          _currentPosition != null ?
          'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}'
              :
          'https://www.google.com/maps/search/?api=1&query=${23.5880},${55.9754}');
    } else {
      throw 'Could not launch https://api.whatsapp.com/send/?phone=03314257676';

    }
  }

  List<Marker> _marker = [];
  List<Marker> _list =[];

  @override
  void initState() {
    // TODO: implement initState

    _getGeoLocationPosition();

    super.initState();
  }


  String? _currentAddress;
  Position? _currentPosition;

  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }
  //
  // Future<void> _getCurrentPosition() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final hasPermission = await _handleLocationPermission();
  //
  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     setState(() => _currentPosition = position);
  //
  //
  //
  //     if(_currentPosition != null) {
  //
  //     }
  //     print(_currentPosition!.latitude.toString() + ' This is lat ');
  //     print(_currentPosition!.longitude.toString()+ ' This is long ');
  //     prefs.setDouble('lat', _currentPosition!.latitude);
  //     prefs.setDouble('long',_currentPosition!.longitude);
  //
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  Future<Position> _getGeoLocationPosition() async {

    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();





    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        var snackBar = SnackBar(content: Text('Please give location permission otherwise you will not be able to move further. '
          ,style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
      else if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {



      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else {
      print(  ' Get Current Location we are in else');
      //_getCurrentPosition();
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {

      // Position position;
      setState(() => _currentPosition = value);
      print(_currentPosition!.latitude.toString() + ' This is lat ');
      print(_currentPosition!.longitude.toString()+ ' This is long ');

      setState(() {
        _kGooglePlexCurrent = CameraPosition(
          target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 15.4746,
        );

      });


      setState(() {
        _list.clear();
        onTapped = 'cover';

        _kGooglePlex = CameraPosition(
          target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 15.4746,
        );

        _list =  [
          Marker(
              markerId: MarkerId('1'),
              position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
              infoWindow: InfoWindow(
                title: 'My Position',
              )
          ),];

        _marker.addAll(_list);
      });



      return value;

    });

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
          'View Map',
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

      body:
      _currentPosition == null ? const Center(
          child: CircularProgressIndicator(
            color: AppColors.greenColor2,
            strokeWidth: 2,
          ))
          :

      Padding(
        padding: const EdgeInsets.all(0.0),
        child: GestureDetector(
          onTap: () async {
            if (await canLaunch(
                _currentPosition != null ?
                'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}'
                    :
                'https://www.google.com/maps/search/?api=1&query=${23.5880},${58.3829}'


            )) {
              await launch(
                  _currentPosition != null ?
                  'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}'
                      :
                  'https://www.google.com/maps/search/?api=1&query=${23.5880},${58.3829}');
            } else {
              throw 'Could not launch https://api.whatsapp.com/send/?phone=03314257676';
            }
          },
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () async {
                // if (await canLaunch(
                //     'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}')) {
                //   await launch(
                //       'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}');
                // } else {
                //   throw 'Could not launch https://api.whatsapp.com/send/?phone=03314257676';
                // }
                if (await canLaunch(
                    _currentPosition != null ?
                    'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}'
                        :
                    'https://www.google.com/maps/search/?api=1&query=${23.5880},${58.3829}')) {
                  await launch(
                      _currentPosition != null ?
                      'https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}'
                          :
                      'https://www.google.com/maps/search/?api=1&query=${23.5880},${58.3829}');
                } else {
                  throw 'Could not launch https://api.whatsapp.com/send/?phone=03314257676';
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  markers: Set<Marker>.of(_marker),
                  onTap: (Lat) {
                    openMap();
                  },
                  initialCameraPosition:  _kGooglePlexCurrent!,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
