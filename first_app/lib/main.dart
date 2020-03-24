import 'dart:ui';
import 'package:firstapp/Common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'UI/MyAppBar.dart';

void main() {
	runApp(MaterialApp(
		title: 'My app', // used by the OS task switcher
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
	String _title = 'My address is';
	String _info = '3choume, Shizuokaken';
	String _image = 'assets/platzhalter_bild.jpg';
	static Color defColor = Colors.black38;
	IconType selected = IconType.Webcam;
	var ready = false;
	var _iconColors = [
		defColor,
		defColor,
		defColor,
		defColor,
		defColor
	];
	
	@override
	Widget build(BuildContext context) {
		_title = 'My ${selected.value} is';
		_info = '3choume, Shizuokaken ${selected.value}';
		_iconColors[selected.value] = selectedColor;
		return Material(
			child: Column(
				children: <Widget>[
					MyAppBar(),
					Divider(height: 40, color: Colors.transparent),
					Column(
							children: <Widget>[
								Image.asset(
									_image,
									fit: BoxFit.cover,
									height: 380,
									width: 380,
								),
								Text(
									_title,
									style: TextStyle(
											height: 5,
											fontSize: 15,
											color: Colors.black.withAlpha(
													920)
									),
								),
								Text(
									_info,
									style: TextStyle(
											height: 1.3,
											fontSize: 30
									),
								),
								Divider(color: Colors.transparent,
										height: 40),
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
}