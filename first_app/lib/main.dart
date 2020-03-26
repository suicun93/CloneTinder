import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui/favorite_list.dart';
import 'ui/home_page.dart';
import 'ui/app_bar.dart';
import 'Common/constants.dart';

void main() {
	runApp(MaterialApp(
		debugShowCheckedModeBanner: false,
		title: app_name,
		home: MyHomePage(),
	));
	SystemChrome.setEnabledSystemUIOverlays([]);
}

class MyHomePage extends StatefulWidget {
	@override
	_MyHomePageState createState() {
		return _MyHomePageState();
	}
}

class _MyHomePageState extends State<MyHomePage> {
	static bool currentPageIsHome = true;
	
	_changeCurrentPage(bool homePage) {
		setState(() => {currentPageIsHome = homePage});
	}
	
	@override
	Widget build(BuildContext context) {
		return Material(
				child: Column(
						children: <Widget>[
							MyAppBar(
									homeClick: () => {_changeCurrentPage(true)},
									favoriteClick: () => {_changeCurrentPage(false)}
							),
							_mainPageBuild()
						]
				)
		);
	}
	
	Widget _mainPageBuild() {
		if (currentPageIsHome) {
			return HomePage();
		} else
			return FavoriteList();
	}
}