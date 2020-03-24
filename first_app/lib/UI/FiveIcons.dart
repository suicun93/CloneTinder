import 'package:flutter/material.dart';
import 'package:firstapp/Common/Constants.dart';

class FiveIcons extends StatefulWidget {
	final FiveIconsState fiveIconsState = FiveIconsState();
	
	set onSelected(Function(IconType) onSelected) {
		fiveIconsState.onSelected = onSelected;
	}
	
	@override
	FiveIconsState createState() {
		return fiveIconsState;
	}
}

class FiveIconsState extends State<FiveIcons> {
	var _iconColors = [
		Colors.black38,
		Colors.black38,
		Colors.black38,
		Colors.black38,
		Colors.black38
	];
	Function(IconType) onSelect;
	
	IconType selected = IconType.Webcam;
	
	set onSelected(Function(IconType) onSelected) {
		this.onSelect = onSelected;
	}
	
	@override
	Widget build(BuildContext context) {
		_iconColors[selected.value] = selectedColor;
		if (onSelect != null)
			onSelect(selected);
		return Row(
				mainAxisAlignment:
				MainAxisAlignment.center,
				children: <Widget>[
					IconButton(
							onPressed: () =>
							{
								setState(() {
									_iconColors[selected.value] = Colors.black38;
									selected = IconType.Webcam;
								}),
							},
							splashColor: Colors.transparent,
							highlightColor: Colors.transparent,
							icon: Icon(
								IconType.Webcam.icon,
								color: _iconColors[0],
							)
					),
					IconButton(
							onPressed: () =>
							{
								setState(() {
									_iconColors[selected.value] = Colors.black38;
									selected = IconType.Calendar;
								}),
							},
							color: Colors.black38,
							splashColor: Colors.transparent,
							highlightColor: Colors.transparent,
							icon: Icon(
								IconType.Calendar.icon,
								color: _iconColors[1],
							)
					),
					IconButton(
							onPressed: () =>
							{
								setState(() {
									_iconColors[selected.value] = Colors.black38;
									selected = IconType.Map;
								}),
							},
							splashColor: Colors.transparent,
							highlightColor: Colors.transparent,
							icon: Icon(
								IconType.Map.icon,
								color: _iconColors[2],
							)
					),
					IconButton(
						onPressed: () =>
						{
							setState(() {
								_iconColors[selected.value] = Colors.black38;
								selected = IconType.Phone;
							}),
						},
						splashColor: Colors.transparent,
						highlightColor: Colors.transparent,
						icon: Icon(
							IconType.Phone.icon,
							color: _iconColors[3],
						),
					),
					IconButton(
							onPressed: () =>
							{
								setState(() {
									_iconColors[selected.value] = Colors.black38;
									selected = IconType.Lock;
								}),
							},
							splashColor: Colors.transparent,
							highlightColor: Colors.transparent,
							icon: Icon(
								IconType.Lock.icon,
								color: _iconColors[4],
							)
					),
				]
		);
	}
}