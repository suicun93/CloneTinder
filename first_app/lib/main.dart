import 'dart:ui';
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

class MyScaffold extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		// Material is a conceptual piece of paper on which the UI appears.
		return Material(
			// Column is a vertical, linear layout.
			child: Column(
				children: <Widget>[
					MyAppBar(),
					Divider(height: 40, color: Colors.transparent,),
					Column(
							children: <Widget>[
								Image.asset(
										'assets/platzhalter_bild.jpg',
										fit: BoxFit.cover,
										height: 380,
										width: 380
								),
								Text('My address is',
									style: TextStyle(
											height: 5,
											fontSize: 15,
											color: Colors.black.withAlpha(920)
									),
								),
								Text(
									'3choume, Shizuokaken',
									style: TextStyle(
											height: 1.3,
											fontSize: 30
									),
								),
								Divider(color: Colors.transparent, height: 40),
								FiveIcons(
									onSelect: (selected) => {
										print(selected),
									},
								)
							]
					),
				],
			),
			color: Colors.white,
		);
	}
}