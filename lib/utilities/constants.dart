import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
const kCityListApiUrl =
    'https://countriesnow.space/api/v0.1/countries/population/cities';
const String kweatherApiUrl =
    "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/"; // Weather Api URL

const String kweatherApiKey =
    "X2LY7T54WSY7LTRSGBZZVAHT6"; // TODO : compulsory give weather API key for registring visit visualcrossing website , it is free

const kTextFieldInputDecoration = InputDecoration(
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  filled: true,
  fillColor: Colors.white,
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  hintText: 'Enter the city name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);

// For background images

const kSunrisingImage = 'assets/images/Sunrising.jpg';
const kNightImage = 'assets/images/Night.jpg';
const kCloudyImage = 'assets/images/Cloudy.jpg';
const kRainyImage = 'assets/images/Rainy3.jpg';
const kSunnyBeachImage = 'assets/images/Sunny_beach.jpg';
const kFogImage = 'assets/images/Foggy.jpg';
const kSnowyImage = 'assets/images/Snowy.jpg';
