import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController{

  final List<Map<String, dynamic>> gridItems = [
    {'icon': Icons.access_time, 'name': 'Clocking'},
    {'icon': Icons.work, 'name': 'Attendance'},
    {'icon': Icons.card_travel, 'name': 'Travel'},
    {'icon': Icons.event, 'name': 'Change Request'},
    {'icon': Icons.medical_services, 'name': 'Medical'},
    {'icon': Icons.people, 'name': 'Grievance'},
    {'icon': Icons.restaurant, 'name': 'Canteen'},
    {'icon': Icons.help, 'name': 'Ticket Application'},
    {'icon': Icons.exit_to_app, 'name': 'Exit Application'},
    {'icon': Icons.account_box, 'name': 'CRM'},
    {'icon': Icons.receipt, 'name': 'Claim'},
    {'icon': Icons.leave_bags_at_home, 'name': 'Leaves'},
  ];

  int selectedIndex = -1; // Track selected index
}