import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'Common/Constants.dart';
import 'Common/Network.dart';
import 'Common/StringExtension.dart';
import 'Model/JSONUser.dart';
import 'UI/MyAppBar.dart';

void main() {
	runApp(MaterialApp(
		title: 'tinder', // used by the OS task switcher
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
	IconType selected = IconType.Webcam;
	var _iconColors = [defColor, defColor, defColor, defColor, defColor];
	UserBean userBean;
	bool loading = false;
	
	void loadAPI() async {
		if (!loading) {
			loading = true;
			setState(() =>
			{
				userBean = null,
				_title = 'Data is loading',
				_info = 'XXXX',
				_image = 'assets/platzhalter_bild.jpg',
				_iconColors[selected.value] = defColor,
				selected = IconType.Webcam,
				_iconColors[0] = selectedColor
			});
			JSONUser futureUser = await Network.loadUser();
			userBean = futureUser.results[0].user;
			loading = false;
			setState(() =>
			{
			});
		}
	}
	
	void saveData() {
	
	}
	
	@override
	void initState() {
		super.initState();
		loadAPI();
	}
	
	@override
	Widget build(BuildContext context) {
		if (userBean != null) {
			_image = userBean.picture;
			_title = 'My ${selected.text} is';
			switch (selected) {
				case IconType.Webcam:
					_info = (userBean.name.title + ' ' +
							userBean.name.first +
							' ' + userBean.name.last).titleCase();
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
		return Material(
			child: Column(
				children: <Widget>[
					MyAppBar(),
					Divider(height: 40, color: Colors.transparent),
					Column(
							children: <Widget>[
								GestureDetector(onPanUpdate: (details) {
									if (details.delta.dx > 0) {
										saveData();
									} else {
										loadAPI();
									}
								},
									child: Container(
										width: 380,
										height: 380,
										child: ClipRRect(
												borderRadius: BorderRadius
														.circular(
														20.0),
												child: FittedBox(
													child: buildImage(),
													fit: BoxFit.fill,
												)
										),
									),
								),
								Text(
										_title,
										style: TextStyle(
												height: 5, fontSize: 15,
												color: Colors.black.withAlpha(
														920))
								),
								Text(
										_info,
										style: TextStyle(
												height: 1.3, fontSize: 30)
								),
								Divider(color: Colors.transparent, height: 40),
								Row(
										mainAxisAlignment:
										MainAxisAlignment.center,
										children: <Widget>[
											IconButton(
													onPressed: () =>
													{
														setState(() {
															_iconColors[selected
																	.value] =
																	defColor;
															selected = IconType
																	.Webcam;
														}),
													},
													splashColor: Colors
															.transparent,
													highlightColor: Colors
															.transparent,
													icon: Icon(
														IconType.Webcam.icon,
														color: _iconColors[0],
													)
											),
											IconButton(
													onPressed: () =>
													{
														setState(() {
															_iconColors[selected
																	.value] =
																	defColor;
															selected = IconType
																	.Calendar;
														}),
													},
													color: defColor,
													splashColor: Colors
															.transparent,
													highlightColor: Colors
															.transparent,
													icon: Icon(
														IconType.Calendar.icon,
														color: _iconColors[1],
													)
											),
											IconButton(
													onPressed: () =>
													{
														setState(() {
															_iconColors[selected
																	.value] =
																	defColor;
															selected = IconType
																	.Map;
														}),
													},
													splashColor: Colors
															.transparent,
													highlightColor: Colors
															.transparent,
													icon: Icon(
														IconType.Map.icon,
														color: _iconColors[2],
													)
											),
											IconButton(
												onPressed: () =>
												{
													setState(() {
														_iconColors[selected
																.value] =
																defColor;
														selected =
																IconType.Phone;
													}),
												},
												splashColor: Colors.transparent,
												highlightColor: Colors
														.transparent,
												icon: Icon(
													IconType.Phone.icon,
													color: _iconColors[3],
												),
											),
											IconButton(
													onPressed: () =>
													{
														setState(() {
															_iconColors[selected
																	.value] =
																	defColor;
															selected = IconType
																	.Lock;
														}),
													},
													splashColor: Colors
															.transparent,
													highlightColor: Colors
															.transparent,
													icon: Icon(
														IconType.Lock.icon,
														color: _iconColors[4],
													)
											),
										]
								)
							]
					),
				],
			),
		);
	}
	
	Widget buildImage() {
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
}