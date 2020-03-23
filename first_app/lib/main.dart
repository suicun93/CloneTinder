import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
	runApp(MaterialApp(
		title: 'My app', // used by the OS task switcher
		home: MyScaffold(),
	));
	SystemChrome.setEnabledSystemUIOverlays([]);
}

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
						icon: Icon(Icons.settings,
							color: Colors.black26,
						),
					),
					// Expanded expands its child to fill the available space.
					Expanded(
						child: Text("tinder",
							style: TextStyle(
								color: Colors.red,
								height: 1.2,
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
								Image.asset('assets/platzhalter_bild.jpg'),
								Text('My address is',
									style: TextStyle(
										height: 5,
										fontSize: 15,
										color: Colors.black.withAlpha(920),),
								),
								Text(
									'3choume, Shizuokaken',
									style: TextStyle(
										height: 1.3,
										fontSize: 27,
									),
								),
								Divider(color: Colors.transparent,height: 40,),
								Row(
										mainAxisAlignment: MainAxisAlignment
												.center,
										children: <Widget>[
											IconButton(
													onPressed: null,
													icon: Icon(Icons
															.slow_motion_video
													)
											),
											IconButton(
													onPressed: null,
													icon: Icon(Icons
															.account_circle
													)),
											IconButton(
													onPressed: null,
													icon: Icon(Icons
															.ac_unit
													)),
											IconButton(
													onPressed: null,
													icon: Icon(Icons
															.zoom_out_map
													)),
											IconButton(
													onPressed: null,
													icon: Icon(Icons
															.whatshot
													)),
										]
								),
							]
					),
				],
			),
			color: Colors.white,
		);
	}
}