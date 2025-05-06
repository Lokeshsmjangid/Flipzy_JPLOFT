
import 'dart:convert';
import 'dart:developer';

import 'package:flipzy/Api/api_constant.dart';
import 'package:flipzy/Api/api_models/places_auto_suggestion-Starting/lib/models/autocomplate_prediction.dart';
import 'package:flipzy/Api/api_models/places_auto_suggestion-Starting/lib/models/place_auto_complate_response.dart';
import 'package:flipzy/resources/custom_loader.dart';
import 'package:flipzy/resources/debouncer.dart';
import 'package:flipzy/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
String address = '';
class EnableLocationController extends GetxController {

  TextEditingController searchCtrl = TextEditingController();
  final deBounce = Debouncer(milliseconds: 1000); // debouncer

  List<AutocompletePrediction> placePredication = [];

  void getSuggestion(String query) async{
    Uri uri = Uri.https('maps.googleapis.com','maps/api/place/autocomplete/json',{
      'input': query,
      'key': ApiUrls.googleApiKey,
    });

    String? response = await fetchUrl(uri);
    if(response !=null){
      log('AutoCompleteResponse $response');
      PlaceAutocompleteResponse result = PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if(result.predictions!=null){
        placePredication = result.predictions!;
        update();
      }
    }

  }

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers); // Await the HTTP request
      if (response.statusCode == 200) {
        // Do something with the response here if needed
        return response.body; // Return response body or whatever you need
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }

  Future<PlaceDetails> getAddressFromPlaceId(String placeId) async {
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_components,geometry&key=${ApiUrls.googleApiKey}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final addressComponents = data['result']['address_components'];
      final geometry = data['result']['geometry'];

      String address = '';
      String city = '';
      String state = '';
      String country = '';
      String postalCode = '';
      double latitude = 0.0;
      double longitude = 0.0;

      for (var component in addressComponents) {

        List<dynamic> types = component['types'];
        if (types.contains('street_number') || types.contains('route')) {
          address += component['long_name'] + ', ';
        } else if (types.contains('locality')) {
          city = component['long_name'];
        } else if (types.contains('administrative_area_level_1')) {
          state = component['long_name'];
        } else if (types.contains('country')) {
          country = component['long_name'];
        } else if (types.contains('postal_code')) {
          postalCode = component['long_name'];
        }
      }

      latitude = geometry['location']['lat'];
      longitude = geometry['location']['lng'];
      showLoader(false);
      return PlaceDetails(
        responseCode: 200,
        address: address.isEmpty ? '' : address.substring(0, address.length - 2),
        city: city,
        state: state,
        country: country,
        postalCode: postalCode,
        latitude: latitude,
        longitude: longitude,
      );
    } else {
      showLoader(false);

      throw Exception('Failed to load place details');
    }
  }


  // enable location
  var lat;
  var long;

  Future<void> getCurrentLocation() async {
    // Check for location permission
    var permission = await Permission.location.status;
    if (permission == PermissionStatus.denied) {
      // Request location permission if not granted
      await Permission.location.request();
    }

    // Get current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      lat = position.latitude.toString();
      long = position.longitude.toString();
      log('Latitude: $lat, Longitude: $long');
      update();

      _getAddressFromCoordinates(position.latitude,position.longitude);

    } catch (e) {
      address = '${e}'; //   ios not now condition
      // update();
    }
  }
  Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks != null && placemarks.isNotEmpty) {

        log(':::--$placemarks');

        // cityCtrl.text = placemarks[0].locality.toString();
        // postCodeCtrl.text = placemarks[0].postalCode.toString();
        // countryCtrl.text = placemarks[0].country.toString();
        address = placemarks[0].name! + ', ' + placemarks[0].subLocality! + ', '+ placemarks[0].locality! + ', ' + placemarks[0].administrativeArea!+ ' ' +placemarks[0].postalCode!  + ', ' + placemarks[0].country!;
        // streetCtrl.text = placemarks[0].name! + ', ' + placemarks[0].subLocality! + ', '+ placemarks[0].locality! + ', ' + placemarks[0].administrativeArea!+ ' ' +placemarks[0].postalCode!  + ', ' + placemarks[0].country!;

      } else {
        address = 'Address not found';
        showLoader(false);
      }
    } catch (e) {
      showToastError('Please try again');
      address = '$e';
      log('$address');
      showLoader(false);
      update();

    }
  }

}


class PlaceDetails {
  final int responseCode;
  final String address;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final double latitude;
  final double longitude;
  PlaceDetails({
    required this.responseCode,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
  });
}