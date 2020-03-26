import 'dart:convert';

import 'package:Tinder/DOM/database_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'dart:typed_data';

import 'Common/Constants.dart';
import 'Common/Network.dart';
import 'Common/StringExtension.dart';
import 'Model/JSONUser.dart';


void main() {
	runApp(MaterialApp(
		debugShowCheckedModeBanner: false,
		title: app_name,
		home: MyScaffold(),
	));
	SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyScaffold extends StatefulWidget {
	@override
	MyScaffoldState createState() {
		return MyScaffoldState();
	}
}

class MyScaffoldState extends State<MyScaffold> {
	String _title = 'Data is loading';
	String _info = 'XXXX';
	String _image = 'assets/platzhalter_bild.jpg';
	static Color defColor = Colors.black38;
	bool loading = false;
	IconType selected = IconType.Webcam;
	static bool currentPageIsHome = true;
	var _iconColors = [defColor, defColor, defColor, defColor, defColor];
	UserBean userBean;
	
	void loadAPI() async {
		if (!loading) {
			loading = true;
			setState(() =>
			{
				userBean = null,
				_title = 'Data is loading',
				_info = '...',
				_image = 'assets/platzhalter_bild.jpg',
				_iconColors[selected.value] = defColor,
				selected = IconType.Webcam,
				_iconColors[0] = selectedColor
			});
			JSONUser futureUser = await Network.loadUser();
			userBean = futureUser.results[0].user;
			loading = false;
			setState(() => {});
		}
	}
	
	void saveData() async {
		if (!loading) {
			loading = true;
			DatabaseHelper databaseHelper = DatabaseHelper.instance;
			await databaseHelper.save(User.fromJSON(userBean));
			loading = false;
		}
		loadAPI();
	}
	
	@override
	void initState() {
		super.initState();
		loadAPI();
	}
	
	@override
	Widget build(BuildContext context) {
		return Material(
			child: Column(
				children: <Widget>[
					Container(
						height: 60.0, // in logical pixels
						padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
						decoration: BoxDecoration(color: Colors.white),
						// Row is a horizontal, linear layout.
						child: Row(
							// <Widget> is the type of items in the list.
							children: <Widget>[
								IconButton(
									onPressed: () =>
											setState(() => currentPageIsHome = true),
									icon: Icon(
										Icons.home,
										color: Colors.black26,
									),
								),
								// Expanded expands its child to fill the available space.
								Expanded(
									child: Text(
										app_name,
										style: TextStyle(
											color: selectedColor,
											fontSize: 30,
											fontWeight: FontWeight.bold,
											fontFamily: 'Arial',
										),
										textAlign: TextAlign.center,
									),
								),
								IconButton(
									onPressed: () =>
											setState(() => currentPageIsHome = false),
									icon: Icon(Icons.favorite,
										color: Colors.black26,
									),
								),
							],
						),
					),
					buildPage()
				],
			),);
	}
	
	Widget buildPage() {
		if (currentPageIsHome) {
			if (userBean != null) {
				_image = userBean.picture;
				_title = 'My ${selected.text} is';
				switch (selected) {
					case IconType.Webcam:
						_info = (userBean.name.title + ' ' +
								userBean.name.first + ' ' +
								userBean.name.last)
								.titleCase();
						break;
					case IconType.Calendar:
						_info = userBean.email;
						break;
					case IconType.Map:
						_info = userBean.location.street.titleCase();
						break;
					case IconType.Phone:
						_info = userBean.phone;
						break;
					case IconType.Lock:
						_info = userBean.username.capitalize();
						break;
					default:
						break;
				}
			}
			_iconColors[selected.value] = selectedColor;
			return
				Column(
						children: <Widget>[
							GestureDetector(onPanUpdate: (details) {
								if (details.delta.dx > 0)
									saveData();
								else
									loadAPI();
							},
								child: Container(
									margin: EdgeInsets.only(top: 30),
									padding: EdgeInsets.symmetric(horizontal: 20),
									child: ClipRRect(
											borderRadius: BorderRadius.circular(20.0),
											child: FittedBox(
												child: _buildImage(),
												alignment: Alignment.center,
												fit: BoxFit.fill,
											)
									),
								),
							),
							Text(
									_title,
									style: TextStyle(
											height: 5, fontSize: 15, color: Colors.black.withAlpha(920))
							),
							Text(
									_info,
									style: TextStyle(height: 1.3, fontSize: 35)
							),
							Divider(color: Colors.transparent, height: 30),
							Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>[
										Column(
											children: <Widget>[
												Container(
													width: 30,
													height: 4,
													color: getColor(IconType.Webcam),
												),
												IconButton(
														onPressed: () =>
																setState(() {
																	_iconColors[selected.value] = defColor;
																	selected = IconType.Webcam;
																}),
														splashColor: Colors.transparent,
														highlightColor: Colors.transparent,
														icon: Icon(
															IconType.Webcam.icon,
															color: _iconColors[0],
														)
												)
											],
										),
										Column(
												children: <Widget>[
													Container(
														width: 30,
														height: 4,
														color: getColor(IconType.Calendar),
													),
													IconButton(
															onPressed: () =>
																	setState(() {
																		_iconColors[selected.value] = defColor;
																		selected = IconType.Calendar;
																	}),
															color: defColor,
															splashColor: Colors.transparent,
															highlightColor: Colors.transparent,
															icon: Icon(
																	IconType.Calendar.icon,
																	color: _iconColors[1]
															)
													)
												]
										),
										Column(
												children: <Widget>[
													Container(
														width: 30,
														height: 4,
														color: getColor(IconType.Map),
													),
													IconButton(
															onPressed: () =>
																	setState(() {
																		_iconColors[selected.value] = defColor;
																		selected = IconType.Map;
																	}),
															splashColor: Colors.transparent,
															highlightColor: Colors.transparent,
															icon: Icon(
																	IconType.Map.icon,
																	color: _iconColors[2]
															)
													),
												]
										),
										Column(
												children: <Widget>[
													Container(
														width: 30,
														height: 4,
														color: getColor(IconType.Phone),
													),
													IconButton(
														onPressed: () =>
																setState(() {
																	_iconColors[selected.value] = defColor;
																	selected = IconType.Phone;
																}),
														splashColor: Colors.transparent,
														highlightColor: Colors
																.transparent,
														icon: Icon(
																IconType.Phone.icon,
																color: _iconColors[3]
														),
													),
												]
										),
										Column(
												children: <Widget>[
													Container(
														width: 30,
														height: 4,
														color: getColor(IconType.Lock),
													),
													IconButton(
															onPressed: () =>
																	setState(() {
																		_iconColors[selected.value] = defColor;
																		selected = IconType.Lock;
																	}),
															splashColor: Colors.transparent,
															highlightColor: Colors.transparent,
															icon: Icon(
																	IconType.Lock.icon,
																	color: _iconColors[4]
															)
													),
												]
										),
									]
							)
						]
				);
		} else {
			return FutureBuilder<List<User>>(
				future: DatabaseHelper.instance.read(), // a previously-obtained Future<String> or null
				builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
					Widget child;
					if (snapshot.hasData) {
						List<User> users = snapshot.data;
						child =
								Expanded(
									child: ListView.builder(
										itemBuilder: (context, index) {
											return _buildItem(users[index]);
										},
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
							Text((user.nameTitle + ' ' + user.nameFirst + ' ' + user.nameLast).titleCase(),
									style: TextStyle(
											fontSize: 20,
											fontWeight: FontWeight.bold,
											height: 1.5)
							),
							Text(user.address.titleCase(), style: TextStyle(height: 1.5)),
							Text(user.email, style: TextStyle(height: 1.5))
						],
					),
				],
			),
		);
	}
	
	Widget _buildImage() {
		if (!loading) {
			return FadeInImage.assetNetwork(
					fadeInDuration: Duration(milliseconds: 10),
					fadeOutDuration: Duration(milliseconds: 10),
					imageScale: 0.33,
					placeholder: 'assets/platzhalter_bild.jpg',
					image: _image,
					width: 380.0,
					height: 380.0);
		} else {
			return Image.asset(_image);
		}
	}
	
	Color getColor(IconType iconType) {
		return selected == iconType ? selectedColor : Colors.transparent;
	}
}