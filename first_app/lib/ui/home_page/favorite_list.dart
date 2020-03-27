import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

import '../../dom/database_helpers.dart';
import '../../common/string_extension.dart';

class FavoriteList extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return FutureBuilder<List<User>>(
			future: DatabaseHelper.instance.read(),
			builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
				Widget child;
				if (snapshot.hasData) {
					List<User> users = snapshot.data;
					child = Expanded(
						child: ListView.builder(
							itemBuilder: (context, index) => _buildItem(users[index]),
							itemCount: users.length,
						),
					);
				} else if (snapshot.hasError)
					child =
							Column(
								mainAxisAlignment: MainAxisAlignment.center,
								crossAxisAlignment: CrossAxisAlignment.center,
								children: <Widget>[
									Icon(
										Icons.error_outline,
										color: Colors.red,
										size: 60,
									),
									Padding(
										padding: const EdgeInsets.only(top: 16),
										child: Text('Error: ${snapshot.error}'),
									)
								],
							);
				else
					child = Column(
							mainAxisAlignment: MainAxisAlignment.center,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: <Widget>[
								SizedBox(
									child: CircularProgressIndicator(),
									width: 60,
									height: 60,
								),
								const Padding(
									padding: EdgeInsets.only(top: 16),
									child: Text('Awaiting result...'),
								)
							]
					);
				return
					child;
			},
		);
	}
	
	Widget _buildItem(User user) {
		Uint8List bytes = base64Decode(user.image);
		return Container(
			height: 100,
			margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
			child: Row(
				children: <Widget>[
					ClipRRect(
						borderRadius: BorderRadius.circular(10.0),
						child: Image.memory(bytes),
					),
					VerticalDivider(width: 20),
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Text(
									'${user.nameTitle} ${user.nameFirst} ${user.nameLast}'.titleCase(),
									style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.5)
							),
							Text(user.address.titleCase(), style: TextStyle(height: 1.5)),
							Text(user.email, style: TextStyle(height: 1.5))
						],
					),
				],
			),
		);
	}
	
}