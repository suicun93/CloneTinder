import 'dart:ui';

import 'package:Tinder/common/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIconList extends StatefulWidget {
	Function(IconType) onPressIcon;
	
	MyIconList({this.onPressIcon}) {
		__myIconListState = _MyIconListState(this);
	}
	
	_MyIconListState __myIconListState;
	
	reset() {
		if (__myIconListState != null) {
			__myIconListState.reset();
		}
	}
	
	@override
	_MyIconListState createState() => __myIconListState;
}

class _MyIconListState extends State<MyIconList> {
	static Color defaultColor = Colors.black38;
	MyIconList _myIconList;
	IconType _selectedIcon = IconType.Webcam;
	
	_MyIconListState(this._myIconList);
	
	var _iconColors = [defaultColor, defaultColor, defaultColor, defaultColor, defaultColor];
	var _icons = [
		IconType.Webcam,
		IconType.Calendar,
		IconType.Map,
		IconType.Phone,
		IconType.Lock];
	
	@override
	Widget build(BuildContext context) {
		_iconColors[_selectedIcon.value] = defaultSelectedColor;
		
		return Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					_icon(_icons[0]),
					_icon(_icons[1]),
					_icon(_icons[2]),
					_icon(_icons[3]),
					_icon(_icons[4])
				]
		);
	}
	
	Widget _icon(IconType iconType) {
		return Column(
			children: <Widget>[
				Container(
					width: 30,
					height: 4,
					color: _selectedIcon == iconType ? defaultSelectedColor : Colors.transparent,
				),
				IconButton(
						onPressed: () =>
								setState(() =>
								{
									_iconColors[_selectedIcon.value] = defaultColor,
									// Change previous selected icon's color
									_selectedIcon = _icons[iconType.value],
									_myIconList.onPressIcon(_icons[iconType.value])
								}),
						splashColor: Colors.transparent,
						highlightColor: Colors.transparent,
						icon: Icon(
							iconType.icon,
							color: _iconColors[iconType.value],
						)
				)
			],
		);
	}
	
	void reset() {
		setState(() =>
		{
			_iconColors[_selectedIcon.value] = defaultColor,
			_selectedIcon = IconType.Webcam
		});
	}
}