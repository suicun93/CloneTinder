import 'dart:ui';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return Container(
			height: 56.0, // in logical pixels
			padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
			decoration: BoxDecoration(color: Colors.white),
			// Row is a horizontal, linear layout.
			child: Row(
				// <Widget> is the type of items in the list.
				children: <Widget>[
					IconButton(
						icon: Icon(
							Icons.settings,
							color: Colors.black26,
						),
					),
					// Expanded expands its child to fill the available space.
					Expanded(
						child: Text("tinder",
							style: TextStyle(
								color: Colors.red,
								height: 1.3,
								fontSize: 30,
								fontWeight: FontWeight.bold,
								fontFamily: 'Arial',
							),
							textAlign: TextAlign.center,
						),
					),
					IconButton(
						icon: Icon(Icons.chat_bubble,
							color: Colors.black26,
						),
					),
				],
			),
		);
	}
}
