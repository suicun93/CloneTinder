import 'dart:ui';
import 'package:firstapp/Common/Constants.dart';
import 'package:firstapp/UI/FiveIcons.dart';
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
	FiveIcons fiveIcons = FiveIcons();
	IconType selected = IconType.Webcam;
	var ready = false;
	
	MyScaffoldState() {
		fiveIcons.onSelected = (selected) {
			print(selected.value);
			this.selected = selected;
//			switch (selected) {
//				case IconType.Webcam:
//				case IconType.Calendar:
//				case IconType.Map:
//				case IconType.Phone:
//				case IconType.Lock:
//				default:
//					break;
//			}
		};
	}
	
	@override
	Widget build(BuildContext context) {
		_title = 'My ${selected.value} is';
		_info = '3choume, Shizuokaken ${selected.value}';
		return Material(
			// Column is a vertical, linear layout.
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
											color: Colors.black.withAlpha(920)
									),
								),
								Text(
									_info,
									style: TextStyle(
											height: 1.3,
											fontSize: 30
									),
								),
								Divider(color: Colors.transparent, height: 40),
								fiveIcons
							]
					),
				],
			),
			color: Colors.
			white
			,
		);
	}
}