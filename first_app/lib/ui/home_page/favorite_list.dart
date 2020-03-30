import 'package:Tinder/data/repository/users_repository.dart';
import 'package:Tinder/feature/home/favorite_list/get_users_bloc.dart';
import 'package:Tinder/feature/home/favorite_list/get_users_state.dart';
import 'package:Tinder/feature/home/favorite_list/users_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'dart:typed_data';

import '../../dom/database_helpers.dart';
import '../../common/string_extension.dart';

class FavoriteList extends StatefulWidget {
	@override
	_FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
	GetUsersBloc _getUsersBloc;
	
	@override
	void initState() {
		super.initState();
		_getUsersBloc = GetUsersBloc(userRepository: UserRepository());
	}
	
	@override
	Widget build(BuildContext context) {
		_getUsersBloc.dispatch(GetUsersEvent());
		return
			BlocProvider(
				builder: (context) => _getUsersBloc,
				child: BlocBuilder(
						bloc: _getUsersBloc,
						builder: (context, GetUsersState state) {
							if (state is GetUsersUnInitial)
								return Container();
							else if (state is GetUsersLoading)
								return _loadingWidget();
							else if (state is GetUsersSuccess)
								return _listBuilder(state.users);
							else
								return _errorWidget();
						}),
			);
	}
	
	Widget _buildItem(User user) {
		Uint8List bytes = base64Decode(user.image);
		return Container(
			height: 100,
			margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
			child: Row(
				children: <Widget>[
					ClipRRect(
						borderRadius: BorderRadius.circular(10.0),
						child: Image.memory(bytes),
					),
					VerticalDivider(width: 20),
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Text(
									'${user.nameTitle} ${user.nameFirst} ${user.nameLast}'.titleCase(),
									style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.5)
							),
							Text(user.address.titleCase(), style: TextStyle(height: 1.5)),
							Text(user.email, style: TextStyle(height: 1.5))
						],
					),
				],
			),
		);
	}
	
	Widget _listBuilder(List<User> users) {
		return Expanded(
				child: ListView.builder(
					itemBuilder: (context, index) => _buildItem(users[index]),
					itemCount: users.length,
				)
		);
	}
	
	Widget _loadingWidget() {
		return
			Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: <Widget>[
						SizedBox(
							child: CircularProgressIndicator(),
							width: 60,
							height: 60,
						),
						const Padding(
							padding: EdgeInsets.only(top: 16),
							child: Text('Awaiting result...'),
						)
					]
			);
	}
	
	Widget _errorWidget() {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: <Widget>[
				Icon(
					Icons.error_outline,
					color: Colors.red,
					size: 60,
				),
				Padding(
					padding: const EdgeInsets.only(top: 16),
					child: Text('Error'),
				)
			],
		);
	}
}