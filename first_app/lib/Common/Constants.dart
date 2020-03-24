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
				break;
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
				break;
		}
	}
}

Color selectedColor = Colors.redAccent;
