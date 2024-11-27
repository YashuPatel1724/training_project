import 'dart:convert';

import 'package:http/http.dart' as http;

class Apihelper {
  Apihelper._();

  static Apihelper apihelper = Apihelper._();

  Future<Map<String, dynamic>> fetchData(String search) async {
    final url = Uri.parse(
        'https://imdb-movies-web-series-etc-search.p.rapidapi.com/q=$search.json');

    try{
      final response = await http.get(
        url,
        headers: {
          'X-Rapidapi-Key': '28b8c07be7mshf2e9ae6f2a4a5f6p1b264fjsn93aeeca29eca',
          'X-Rapidapi-Host': 'imdb-movies-web-series-etc-search.p.rapidapi.com',
        },
      );

      if(response.statusCode == 200)
      {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
      else
      {
        throw Exception("Failed!");
      }
    } catch(e){
      throw Exception("Failed to fetch Data!");
    }
  }
}