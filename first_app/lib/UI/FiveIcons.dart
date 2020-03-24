import 'dart:ui';
import 'package:flutter/material.dart';

class FiveIcons extends StatefulWidget {
	@override
	FiveIconsState createState() {
		return FiveIconsState();
	}
	
	const FiveIcons({@required onSelect});
}

class FiveIconsState extends State<FiveIcons> {
	var _iconColors = [
		Colors.black38,
		Colors.black38,
		Colors.black38,
		Colors.black38,
		Colors.black38
	];
	
	void Function(int) onSelect;
	int selected = 0;
	@override
	Widget build(BuildContext context) {
		_iconColors[selected] = Colors.red;
		if (onSelect != null) {
			onSelect(selected);
		}
		return Row(
				mainAxisAlignment:
				MainAxisAlignment.center,
				children: <Widget>[
					IconButton(
							onPressed: () =>
							{
								setState(() {
									_iconColors[selected] = Colors.black38;
									selected = 0;
								}),
							},
							icon: Icon(
								Icons.slow_motion_video,
								color: _iconColors[0],
							)
					),
					IconButton(
							onPressed: () =>
							{
								setState(() {
									_iconColors[selected] = Colors.black38;
									selected = 1;
								}),
							},
							color: Colors.black38,
							icon: Icon(
								Icons.account_circle,
								color: _iconColors[1],
							)
					),
					IconButton(
							onPressed: () =>
							{
								setState(() {
									_iconColors[selected] = Colors.black38;
									selected = 2;
								}),
							},
							icon: Icon(
								Icons.ac_unit,
								color: _iconColors[2],
							)
					),
					IconButton(
						onPressed: () =>
						{
							setState(() {
								_iconColors[selected] = Colors.black38;
								selected = 3;
							}),
						},
						icon: Icon(
							Icons.star,
							color: _iconColors[3],
						),
					),
					IconButton(
							onPressed: () =>
							{
								setState(() {
									_iconColors[selected] = Colors.black38;
									selected = 4;
								}),
							},
							icon: Icon(
								Icons.whatshot,
								color: _iconColors[4],
							)
					),
				]
		);
	}
	
}