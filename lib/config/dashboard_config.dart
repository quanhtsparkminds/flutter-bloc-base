import 'package:flutter/material.dart';
import 'package:myapp/commands/core/app_color.dart';
import 'package:myapp/feature/bottom_tabbar/widgets/menu_bottom_component.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

double width = 30;
double height = 30;

List<MenuBottomModel> listMenuBottom = [
  MenuBottomModel(
      title: 'Home page',
      icon: Icon(Icons.home, color: AppColors.primaryColor, size: 22),
      color: AppColors.primaryColor,
      onTap: () {}),
  MenuBottomModel(
      title: 'Book Sell',
      icon: Icon(Icons.book, color: AppColors.primaryColor, size: 22),
      color: AppColors.grey,
      onTap: () {}),
  MenuBottomModel(
      title: 'Questions',
      icon:
          Icon(Icons.question_answer, color: AppColors.primaryColor, size: 22),
      color: AppColors.grey,
      onTap: () {}),
  MenuBottomModel(
      title: 'Accounts',
      icon:
          Icon(Icons.account_balance, color: AppColors.primaryColor, size: 22),
      color: AppColors.grey,
      onTap: () {})
];

List<SalomonBottomBarItem> listMenuBottoms = [
  SalomonBottomBarItem(
    title: const Text('Home page'),
    icon: Icon(Icons.home, color: AppColors.primaryColor, size: 22),
    selectedColor: AppColors.primaryColor,
    unselectedColor: AppColors.grey,
  ),
  SalomonBottomBarItem(
    title: const Text('Book Sell'),
    icon: Icon(Icons.book, color: AppColors.primaryColor, size: 22),
    selectedColor: AppColors.primaryColor,
    unselectedColor: AppColors.grey,
  ),
  SalomonBottomBarItem(
    title: const Text('Questions'),
    icon: Icon(Icons.question_answer, color: AppColors.primaryColor, size: 22),
    unselectedColor: AppColors.grey,
    selectedColor: AppColors.primaryColor,
  ),
  SalomonBottomBarItem(
    title: const Text('Settings'),
    icon: Icon(Icons.account_balance, color: AppColors.primaryColor, size: 22),
    unselectedColor: AppColors.grey,
    selectedColor: AppColors.primaryColor,
  )
];
