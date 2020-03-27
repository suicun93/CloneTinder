import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../common/network.dart';
import '../../common/string_extension.dart';
import '../../dom/database_helpers.dart';
import '../../model/JSON_user.dart';
import '../../ui/home_page/my_icon_list.dart';
import '../../generated/demo_localizations.dart';

class HomePage extends StatefulWidget {
	@override
	_HomePageState createState() {
		return _HomePageState();
	}
}

class _HomePageState extends State<HomePage> {
	String _title = 'Data is loading';
	String _info = '...';
	String _image = 'assets/platzhalter_bild.jpg';
	UserBean _currentUserbean;
	bool isLoading = false;
	MyIconList _myIconListBuild;
	
	_HomePageState() {
		_myIconListBuild = MyIconList(
				onPressIcon: (selectedIcon) =>
						setState(() =>
								_updateInfoByIcon(selectedIcon)
						)
		);
	}
	
	@override
	Widget build(BuildContext context) {
		return
			Column(
					children: <Widget>[
						GestureDetector(onPanUpdate: (details) {
							if (details.delta.dx > 0)
								_saveData();
							else
								_loadAPI();
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
	
	void _loadAPI() async {
		if (!isLoading) {
			isLoading = true;
			// Reset UI to wait API
			setState(() => _setupUser(null));
			// Load from API
			JSONUser futureUser = await Network.loadUser();
			// Change data on UI
			setState(() => _setupUser(futureUser.results[0].user));
			isLoading = false;
		}
	}
	
	void _saveData() async {
		if (!isLoading) {
			isLoading = true;
			DatabaseHelper databaseHelper = DatabaseHelper.instance;
			await databaseHelper.save(User.fromJSON(_currentUserbean));
			isLoading = false;
		}
		_loadAPI();
	}
	
	_setupUser(UserBean userBean) {
		_currentUserbean = userBean;
		if (userBean == null) {
//			_title = AppLocalizations.of(context).translate('data_is_loading');
			_info = '...';
			_image = 'assets/platzhalter_bild.jpg';
			// Reset icon to first icon
			_resetMyIconList();
		} else {
			_image = userBean.picture;
			_updateInfoByIcon(IconType.Webcam);
		}
	}
	
	@override
	didChangeDependencies() {
		super.didChangeDependencies();
		_title = '${AppLocalizations.of(context).translate('My')} '
				'${AppLocalizations.of(context).translate(this._selectedIcon.text)} '
				'${AppLocalizations.of(context).translate('is')}';
	}
	
	IconType _selectedIcon = IconType.Webcam;
	
	_updateInfoByIcon(IconType selectedIcon) {
		_selectedIcon = selectedIcon;
		_title = '${AppLocalizations.of(context).translate('My')} '
				'${AppLocalizations.of(context).translate(selectedIcon.text)} '
				'${AppLocalizations.of(context).translate('is')}';
		switch (selectedIcon) {
			case IconType.Webcam:
				_info = ('${_currentUserbean.name.title} '
						'${_currentUserbean.name.first} '
						'${_currentUserbean.name.last}')
						.titleCase();
				break;
			case IconType.Calendar:
				_info = _currentUserbean.email;
				break;
			case IconType.Map:
				_info = _currentUserbean.location.street.titleCase();
				break;
			case IconType.Phone:
				_info = _currentUserbean.phone;
				break;
			case IconType.Lock:
				_info = _currentUserbean.username.capitalize();
				break;
			default:
				break;
		}
	}
	
	_resetMyIconList() {
		try {
			_myIconListBuild.reset();
		}
		catch (Exception1) {
			print(Exception1);
		}
	}
	
	Widget _buildImage() {
		if (!isLoading)
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
	
	@override
	void initState() {
		super.initState();
		_loadAPI();
	}
}