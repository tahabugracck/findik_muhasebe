// settings_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:findik_muhasebe/screens/main_screens/settings_folder/employee_add_tab.dart';
import 'package:findik_muhasebe/screens/main_screens/settings_folder/user_info_tab.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Kullanıcı Bilgileri'),
            Tab(text: 'Çalışan Ekle'),
            //Tab(text: 'Çalışan Listesi'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          UserInfoTab(),
          EmployeeAddTab(),
         // EmployeeListTab(),
        ],
      ),
    );
  }
}
