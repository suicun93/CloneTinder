import 'package:Tinder/dom/database_helpers.dart';

class UserRepository {
	Future<List<User>> getFavoriteUsers() async {
		return await DatabaseHelper.instance.read();
	}
}