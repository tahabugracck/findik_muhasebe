import 'package:findik_muhasebe/screens/main_screens/settings_folder/employee_add_tab.dart';
import 'package:findik_muhasebe/screens/main_screens/settings_folder/employee_list_tab.dart';
import 'package:findik_muhasebe/screens/main_screens/settings_folder/user_info_tab.dart';
import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Tab sayısı
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ayarlar'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kullanıcı Bilgileri'),
              Tab(text: 'Çalışan Ekle'),
              Tab(text: 'Çalışan Listesi'),
            ],
          ),
        ),
        body: const Column(
          children: [
            
            Expanded(
              child: TabBarView(
                children: [
                  UserInfoTab(),
                  EmployeeAddTab(),
                  EmployeeListTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
