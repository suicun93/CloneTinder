import 'package:Tinder/ui/home_page/MyIconList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../common/network.dart';
import '../../dom/database_helpers.dart';
import '../../model/JSON_user.dart';
import '../../common/string_extension.dart';

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
	UserBean _userBean;
	bool loading = false;
	IconType selectedIcon = IconType.Webcam;
	
	_HomePageState() {
		_myIconListBuild = MyIconList(
				onPressIcon: (selectedIcon2) =>
						setState(() => this.selectedIcon = selectedIcon2)
		);
	}
	
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
								style: TextStyle(fontSize: 15, color: Colors.black54)
						),
						Text(
								_info,
								textAlign: TextAlign.center,
								maxLines: 2,
								style: TextStyle(height: 1.3, fontSize: 30)
						),
						Divider(color: Colors.transparent, height: 35),
						_myIconListBuild
					]
			);
	}
	
	MyIconList _myIconListBuild;
	
	Widget _buildImage() {
		if (!loading)
			return FadeInImage.assetNetwork(
					fadeInDuration: Duration(milliseconds: 10),
					fadeOutDuration: Duration(milliseconds: 10),
					imageScale: 0.33,
					placeholder: 'assets/platzhalter_bild.jpg',
					image: _image,
					width: 380.0,
					height: 380.0);
		else
			return Image.asset(
					_image,
					width: 380,
					height: 380);
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
			_myIconListBuild.reset();
			setState(() =>
			{
				_userBean = null,
				_title = 'Data is loading',
				_info = '...',
				_image = 'assets/platzhalter_bild.jpg',
				selectedIcon = IconType.Webcam,
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