import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/constants.dart';
import '../common/network.dart';
import '../dom/database_helpers.dart';
import '../model/JSON_user.dart';
import '../common/string_extension.dart';

class HomePage extends StatefulWidget {
	@override
	_HomePageState createState() {
		return _HomePageState();
	}
}

class _HomePageState extends State<HomePage> {
	String _title = 'Data is loading';
	String _info = 'XXXX';
	String _image = 'assets/platzhalter_bild.jpg';
	static Color defColor = Colors.black38;
	UserBean _userBean;
	bool loading = false;
	IconType selectedIcon = IconType.Webcam;
	var _iconColors = [defColor, defColor, defColor, defColor, defColor];
	var _icons = [
		IconType.Webcam,
		IconType.Calendar,
		IconType.Map,
		IconType.Phone,
		IconType.Lock];
	
	
	@override
	Widget build(BuildContext context) {
		if (_userBean != null) {
			_image = _userBean.picture;
			_title = 'My ${selectedIcon.text} is';
			switch (selectedIcon) {
				case IconType.Webcam:
					_info = ('${_userBean.name.title} '
							'${_userBean.name.first} '
							'${_userBean.name.last}')
							.titleCase();
					break;
				case IconType.Calendar:
					_info = _userBean.email;
					break;
				case IconType.Map:
					_info = _userBean.location.street.titleCase();
					break;
				case IconType.Phone:
					_info = _userBean.phone;
					break;
				case IconType.Lock:
					_info = _userBean.username.capitalize();
					break;
				default:
					break;
			}
		}
		_iconColors[selectedIcon.value] = selectedColor;
		return
			Column(
					children: <Widget>[
						GestureDetector(onPanUpdate: (details) {
							if (details.delta.dx > 0)
								saveData();
							else
								loadAPI();
						},
							child: Container(
								alignment: Alignment.center,
								margin: EdgeInsets.fromLTRB(0, 30, 0, 60),
								width: 380,
								height: 380,
								child: ClipRRect(
										borderRadius: BorderRadius.circular(20.0),
										child: FittedBox(
											child: _buildImage(),
											alignment: Alignment.center,
											fit: BoxFit.cover,
										)
								),
							),
						),
						Text(
								_title,
								style: TextStyle(
										fontSize: 15, color: Colors.black.withAlpha(920))
						),
						Text(
								_info,
								style: TextStyle(height: 1.3, fontSize: 35)
						),
						Divider(color: Colors.transparent, height: 30),
						Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									_icon(0),
									_icon(1),
									_icon(2),
									_icon(3),
									_icon(4),
								]
						)
					]
			);
	}
	
	Widget _buildImage() {
		if (!loading) {
			return FadeInImage.assetNetwork(
					fadeInDuration: Duration(milliseconds: 10),
					fadeOutDuration: Duration(milliseconds: 10),
					imageScale: 0.33,
					placeholder: 'assets/platzhalter_bild.jpg',
					image: _image,
					width: 380.0,
					height: 380.0);
		} else {
			return Image.asset(
					_image,
					width: 380,
					height: 380);
		}
	}
	
	Widget _icon(int index) {
		IconType iconType = _icons[index];
		return Column(
			children: <Widget>[
				Container(
					width: 30,
					height: 4,
					color: selectedIcon == iconType ? selectedColor : Colors.transparent,
				),
				IconButton(
						onPressed: () =>
								setState(() {
									_iconColors[selectedIcon.value] = defColor; // Change previous selected icon's color
									selectedIcon = _icons[index];
								}),
						splashColor: Colors.transparent,
						highlightColor: Colors.transparent,
						icon: Icon(
							iconType.icon,
							color: _iconColors[index],
						)
				)
			],
		);
	}
	
	void saveData() async {
		if (!loading) {
			loading = true;
			DatabaseHelper databaseHelper = DatabaseHelper.instance;
			await databaseHelper.save(User.fromJSON(_userBean));
			loading = false;
		}
		loadAPI();
	}
	
	void loadAPI() async {
		if (!loading) {
			loading = true;
			setState(() =>
			{
				_userBean = null,
				_title = 'Data is loading',
				_info = '...',
				_image = 'assets/platzhalter_bild.jpg',
				_iconColors[selectedIcon.value] = defColor,
				selectedIcon = IconType.Webcam,
				_iconColors[0] = selectedColor
			});
			JSONUser futureUser = await Network.loadUser();
			_userBean = futureUser.results[0].user;
			loading = false;
			setState(() => {});
		}
	}
	
	@override
	void initState() {
		super.initState();
		loadAPI();
	}
}