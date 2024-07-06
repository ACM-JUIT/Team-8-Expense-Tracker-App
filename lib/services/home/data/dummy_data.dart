import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String,dynamic>> myData = [
  {
    'icon': const FaIcon(FontAwesomeIcons.burger,
    color: Colors.white,),
    'name': 'Food',
    'color': Colors.yellow[700],
    'date': 'Today',
    'amount': '-\$45.00'
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.bagShopping,
      color: Colors.white,
    ),
    'name': 'Shopping',
    'color': Colors.purple,
    'date': 'Today',
    'amount': '-\$280.00'
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.ticket,
      color: Colors.white,),
    'name': 'Entertainment',
    'color' : Colors.red,
    'date': 'Yesterday',
    'amount': '-\$60.00'
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.plane,
      color: Colors.white,),
    'name': 'Travel',
    'color': Colors.blue,
    'date': 'Yesterday',
    'amount': '-\$250.00'
  },
  {
    'icon': const FaIcon(
      FontAwesomeIcons.mugSaucer,
      color: Colors.white,),
    'name': 'Coffee',
    'color': Colors.blue[700],
    'date': 'Today',
    'amount': '-\$45.00'
  },
];
