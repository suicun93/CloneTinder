import 'package:flutter/material.dart';

enum IconType {
	Webcam,
	Calendar,
	Map,
	Phone,
	Lock
}
extension IconExtension on IconType {
	int get value {
		switch (this) {
			case IconType.Webcam:
				return 0;
			case IconType.Calendar:
				return 1;
			case IconType.Map:
				return 2;
			case IconType.Phone:
				return 3;
			case IconType.Lock:
				return 4;
			default:
				return 0;
		}
	}
	
	IconData get icon {
		switch (this) {
			case IconType.Webcam:
				return Icons.account_circle;
			case IconType.Calendar:
				return Icons.calendar_today;
			case IconType.Map:
				return Icons.map;
			case IconType.Phone:
				return Icons.phone;
			case IconType.Lock:
				return Icons.lock;
			default:
				return Icons.lock;
		}
	}
	
	String get text {
		switch (this) {
			case IconType.Webcam:
				return 'name';
			case IconType.Calendar:
				return 'email';
			case IconType.Map:
				return 'address';
			case IconType.Phone:
				return 'phone';
			case IconType.Lock:
				return 'username';
			default:
				return 'name';
		}
	}
}

Color selectedColor = Colors.redAccent;
String app_name = 'tinder';