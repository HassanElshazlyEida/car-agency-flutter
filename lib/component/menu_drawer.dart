import 'package:car_agency_flutter/modules/auth/user_repository.dart';
import 'package:car_agency_flutter/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuDrawer extends StatelessWidget {


  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Image.asset('images/logo.png',height: 100,width: 100)),
           
            ListTile(
              leading: const Icon(Icons.logout),
              title:  Text('Logout'),
              onTap: () {
                UserRepository.logout();
                Get.toNamed(Routes.login);
                Get.snackbar('Success', 'Logout Successfully');
              },
            ),
          
          ],
        ),
    );
  }
  
}