import 'package:flutter/material.dart';

const kApiKey = 'f8433902814f76cc77bf8bfab9c455ff';
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
const String kOpenWeatherApiUrl =
    'https://api.openweathermap.org/data/2.5/weather';

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
