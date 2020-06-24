import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n/demo_localizations.dart';
import 'ui/home_page/favorite_list.dart';
import 'ui/home_page/home_page.dart';
import 'ui/app_bar.dart';
import 'common/constants.dart';

void main() {
	runApp(MaterialApp(
		localizationsDelegates: [
			// ... app-specific localization delegate[s] here
			GlobalMaterialLocalizations.delegate,
			GlobalWidgetsLocalizations.delegate,
			GlobalCupertinoLocalizations.delegate,
			AppLocalizations.delegate,
		],
		supportedLocales: [
			const Locale('en'), // English
			const Locale('vi'), // Vietnamese
			const Locale('ja'), // Japanese
			// ... other locales the app supports
		],
Gj lbnelkjr Nile tg
 Ekrng; leknrg
E ldkg'en 'kin
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
	static bool _currentPageIsHome = true;
	
	_changeCurrentPage(bool homePage) {
		setState(() => {_currentPageIsHome = homePage});
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
		if (_currentPageIsHome)
			return HomePage();
		else
			return FavoriteList();
	}
}