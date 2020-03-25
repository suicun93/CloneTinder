import 'package:firstapp/Model/JSONUser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
	static Future<JSONUser> loadUser() async {
		final response = await http.get(
				'https://randomuser.me/api/0.4/?randomapi');
		
		if (response.statusCode == 200) {
			// If the server did return a 200 OK response,
			// then parse the JSON.
			final Map parsed = jsonDecode(response.body);
			return JSONUser.fromMap(parsed);
		} else {
			// If the server did not return a 200 OK response,
			// then throw an exception.
			throw Exception('Failed to load user');
		}
	}
}