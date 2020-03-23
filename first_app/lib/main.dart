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
			padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
								height: 1,
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
					Divider(
						height: 10,
						color: Colors.white,
					),
					Column(
							children: <Widget>[
								Image.asset('assets/platzhalter_bild.jpg'),
								Text(
									'My address is',
									style: TextStyle(
										height: 3,
										fontSize: 15,
										color: Colors.black.withAlpha(900),
									),
								),
								Text(
									'3choume, Shizuokaken',
									style: TextStyle(
										height: 1,
										fontSize: 28,
									),
								),
								Align(
										child:
										Container(
											child: Row(
													children: <Widget>[
														IconButton(
																icon: Icon(Icons
																		.slow_motion_video
																)),
														IconButton(
																icon: Icon(Icons
																		.account_circle
																)),
														IconButton(
																icon: Icon(Icons
																		.ac_unit
																)),
														IconButton(
																icon: Icon(Icons
																		.zoom_out_map
																)),
														IconButton(
																icon: Icon(Icons
																		.whatshot
																)),
													]
											),
										)
								
								),
							]
					),
				],
			),
			color: Colors.white,
		);
	}
}

//
//class RandomWords extends StatefulWidget {
//	@override
//	RandomWordsState createState() => RandomWordsState();
//}
//
//class RandomWordsState extends State<RandomWords> {
//	final _suggestions = <WordPair>[];
//	final _biggerFont = const TextStyle(fontSize: 18.0);
//
//	@override
//	Widget build(BuildContext context) {
//		return Scaffold(
//			appBar: AppBar(
//				title: Text('Startup Name Generator'),
//			),
//			body: _buildSuggestions(),
//		);
//	}
//
//	Widget _buildSuggestions() {
//		return ListView.builder(
//				padding: const EdgeInsets.all(10.0),
//				itemBuilder: /*1*/ (context, i) {
//					if (i.isOdd) return Divider();
//					/*2*/
//
//					final index = i ~/ 2; /*3*/
//					if (index >= 10) {
//						_suggestions.addAll(
//								generateWordPairs().take(1)); /*4*/
//					}
//					return _buildRow(_suggestions[index]);
//				});
//	}
//
//	Widget _buildRow(WordPair pair) {
//		return ListTile(
//			title: Text(
//				pair.asPascalCase,
//				style: _biggerFont,
//			),
//		);
//	}
//}