import 'package:http/http.dart' as http;
import 'dart:convert';

class MyJSON {
  var jsonResponse;

  void getData(String pincode) async{
    http.Response response = await http.get('https://api.postalpincode.in/pincode/$pincode');
    jsonResponse = jsonDecode(response.body);
    if(response.statusCode == 200)
    {
      print(jsonResponse[0]['Message']);
    }
  }

  String getCity(){
    return jsonResponse[0]['PostOffice'][0]['Circle'];
  }

  String getDistrict(){
    return jsonResponse[0]['PostOffice'][0]['District'];
  }

  String getDivision(){
    return jsonResponse[0]['PostOffice'][0]['Division'];
  }

  String getRegion(){
    return jsonResponse[0]['PostOffice'][0]['Region'];
  }

  String getState(){
    return jsonResponse[0]['PostOffice'][0]['State'];
  }
}