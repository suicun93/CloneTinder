import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import '../common/constants.dart';
import '../generated/demo_localizations.dart';

class MyAppBar extends StatelessWidget {
	VoidCallback homeClick;
	VoidCallback favoriteClick;
	
	MyAppBar({@required this.homeClick, @required this.favoriteClick});
	
	@override
	Widget build(BuildContext context) {
		return Container(
			height: 60.0,
			padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
			decoration: BoxDecoration(color: Colors.white),
			child: Row(
				children: <Widget>[
					IconButton(
						onPressed: () => homeClick(),
						icon: Icon(
							Icons.home,
							color: Colors.black26,
						),
					),
					Expanded(
						child: Text(
							AppLocalizations.of(context).translate(app_name),
							style: TextStyle(
								color: defaultSelectedColor,
								fontSize: 30,
								fontWeight: FontWeight.bold,
								fontFamily: 'Arial',
							),
							textAlign: TextAlign.center,
						),
					),
					IconButton(
						onPressed: () => favoriteClick(),
						icon: Icon(
							Icons.favorite,
							color: Colors.black26,
						),
					),
				],
			),
		);
	}
	
}