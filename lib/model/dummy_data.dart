import 'package:flutter/material.dart';
import 'package:road_safety/model/car_repair_service_model.dart';
import 'package:road_safety/model/month_model.dart';
import 'package:road_safety/model/settings_model.dart';
import 'package:road_safety/res/colors.dart';

class DummyData {


  static  List<MonthModel> monthList = [

    MonthModel(name: 'January', locked: true, reserved: false),
    MonthModel(name: 'February', locked: false, reserved: false),
    MonthModel(name: 'March', locked: false, reserved: true),
    MonthModel(name: 'April', locked: false, reserved: true),
    MonthModel(name: 'May', locked: false, reserved: false),
    MonthModel(name: 'June', locked: true, reserved: true),
    MonthModel(name: 'July', locked: false, reserved: false),
    MonthModel(name: 'August', locked: false, reserved: true),
    MonthModel(name: 'September', locked: true, reserved: false),
    MonthModel(name: 'October', locked: false, reserved: true),
    MonthModel(name: 'November', locked: false, reserved: false),
    MonthModel(name: 'December', locked: false, reserved: true),

  ];
  static  List<SettingsModel> settingList = [
    SettingsModel(name: 'Edit Profile', isIcon: true, icon: Icon(Icons.edit,size: 20,color: AppColors.purpleColor,), image: ''),
    SettingsModel(name: 'Notifications', isIcon: true, icon: Icon(Icons.notification_important_outlined,size: 20,color: AppColors.purpleColor,), image: ''),
    SettingsModel(name: 'Logout', isIcon: true, icon: Icon(Icons.logout,size: 20,color:AppColors.purpleColor,), image: ''),
  ];

  static  List<CarRepairServiceModel> carRepairList = [
    CarRepairServiceModel(
        name: 'PitSpot Automotive Services',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUOAiA8E-jXCD6IpU7evNQRFzFr9JprGbUpqIa3FWaXAr7CujI',
        address: 'Muscat, Sultanate of Oman Behind Towell Service Center, WadiKabir',
        phone: '+968 97746869',
        status: '9.00 - 16.30 and Friday - Closed',
        service: 'Services: Auto glass repair, Engine repair, Steering and suspension repair, Transmission repair, Vehicle body and trim repair,'),

    CarRepairServiceModel(
        name: 'PRECISION TUNE AUTO CARE | SEEB',
        image: 'https://lh5.googleusercontent.com/p/AF1QipOqCCZ4I44YKCs4UrdmMudTNtdY-LifkDUL41SK=w408-h306-k-no',
        address: 'Inside Shell Fuel Filling station Seeb Sharadi Oman السيب‎ OM, 112, Oman',
        phone: '+96898047973',
        status: '8am–1pm 4–8pm and Friday - Closed',
        service: 'Services: Vehicle brake repair, Steering and suspension repair, General repairs & maintenance, A/C installation and repair,'),

    CarRepairServiceModel(
        name: 'CARFiX Maintenance and Repair Center كارفكس مركز صيانة واصلاح',
        image: 'https://lh5.googleusercontent.com/p/AF1QipOyFtseegnjQe4gVBXG05Iy-kdl2L-7dyxp_Ajo=w426-h240-k-no',
        address: 'Alseeb Bowling Center, Al Hail South Al Seeb Shell station, Muscat, Oman',
        phone: '+96895846640',
        status: '10am–11pm and Friday - Closed',
        service: 'Services: Engine repair, Engine building, Electrical system service & repair, Supercharger/blower/turbo installations, A/C installation'),

    CarRepairServiceModel(
        name: 'Naser - Car Services At Your Home',
        image: 'https://lh5.googleusercontent.com/p/AF1QipPUduHauUE3veNywOR-H6TjJ0cllJWjqBqF-ljC=w408-h306-k-no',
        address: 'Building Office 27, Street 4312 Building 4583 Al Sherif, South Khuwair, 243, Oman',
        phone: '+96871902000',
        status: 'Open 24 hours',
        service: 'Services: Transmission repair, Tyres, Electrical repair, Battery, Oil change, Air and cabin filter replacement, Vehicle engine diagnostic,'),


  ];


  static  List<CarRepairServiceModel> hospitalList = [
    CarRepairServiceModel(
        name: 'Accident & Emergeny department قسم الطوارئ',
        image: 'https://lh3.googleusercontent.com/p/AF1QipN_HpaL0oGSc98HQyoGZ8yBP4v9zhYqumaCQxau=s680-w680-h510',
        address: 'Muscat, Sultanate of Oman Behind Towell Service Center, WadiKabir',
        phone: '+968 24 147307',
        status: 'Open 24 hours',
        service: 'Emergency department provides acute care to patients who present without prior appointment; either by their own means or by that of an ambulance.,'),
    CarRepairServiceModel(
        name: 'Emergencies/Fire',
        image: 'https://www.omanobserver.om/uploads/imported_images/uploads/2018/01/PACDA.jpg',
        address: 'H632+CXV, Seeb, Oman',
        phone: '999',
        status: 'Open 24 hours',
        service: 'It’s service center is fully equipped with a team of qualified, experienced and well trained engineers & technicians'),


    CarRepairServiceModel(
        name: 'Ruwi',
        image: 'https://lh5.googleusercontent.com/p/AF1QipOyFtseegnjQe4gVBXG05Iy-kdl2L-7dyxp_Ajo=w426-h240-k-no',
        address: 'Alseeb Bowling Center, Al Hail South Al Seeb Shell station, Muscat, Oman',
        phone: ' 701099',
        status: 'Open 24 hours',
        service: 'It’s service center is fully equipped with a team of qualified, experienced and well trained engineers & technicians'),

    CarRepairServiceModel(
        name: 'Salalah',
        image: 'https://lh5.googleusercontent.com/p/AF1QipPUduHauUE3veNywOR-H6TjJ0cllJWjqBqF-ljC=w408-h306-k-no',
        address: 'Building Office 27, Street 4312 Building 4583 Al Sherif, South Khuwair, 243, Oman',
        phone: '290099',
        status: 'Open 24 hours',
        service: 'It’s service center is fully equipped with a team of qualified, experienced and well trained engineers & technicians'),


  ];

  static  List<CarRepairServiceModel> ropList = [
    CarRepairServiceModel(
        name: 'Royal Oman Police',
        image: 'https://imagevars.gulfnews.com/2021/01/06/Royal-Oman-Police_176d89a807c_large.jpg',
        address: 'H85M+293, Muscat, Oman',
        phone: '9999',
        status: 'Open 24 hours',
        service: 'Upholding the law fairly and firmly by preventing crimes, firstly, and pursuing and bringing to justice those who break the law.'),

    CarRepairServiceModel(
        name: 'Police (Capital)',
        image: 'https://shabiba.eu-central-1.linodeobjects.com/2019/07/9/1041713.jpg',
        address: 'Inside Shell Fuel Filling station Seeb Sharadi Oman السيب‎ OM, 112, Oman',
        phone: '560099',
        status: 'Open 24 hours',
        service: 'It’s service center is fully equipped with a team of qualified, experienced and well trained engineers & technicians'),


  ];

}