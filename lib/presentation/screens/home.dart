import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:rimza/presentation/screens/otpscr.dart';


class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  final List<Map<String, String>> allDevices = [
    {'name': 'RASPP002', 'version': 'v1.12', 'date': '06.06.2024'},
    {'name': 'imatrix', 'version': 'v1.13', 'date': '06.06.2024'},
    {'name': 'RTS office', 'version': 'v1.12', 'date': '06.06.2024'},
    {'name': 'RTS0008', 'version': 'v1.12', 'date': '06.06.2024'},
  ];

  final box = GetStorage();
  List<Map<String, String>> filteredDevices = [];

  
  @override
  void initState() {
    super.initState();
    filteredDevices = allDevices;
  }

  void filterSearch(String query) {
    setState(() {
      filteredDevices = allDevices.where((device) => device['name']!.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

   void handleLogout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textCancel: "Cancel",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () {
        box.erase();
        Get.offAll(() => LoginScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    drawer: Drawer(
        backgroundColor: Colors.blue.shade50,
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
              ),
              child: Center(
                child: Text(
                  "Welcome 👋",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout"),
              onTap: handleLogout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Devices(${filteredDevices.length})", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Text("v1.8", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(width: 10),
          Lottie.asset('assets/lotties/green.json', width: 50, height: 50),
          SizedBox(width: 10),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterSearch,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.blue[50],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDevices.length,
              itemBuilder: (context, index) {
                final device = filteredDevices[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 100,
                    child: ListTile(
                      leading: Image.asset('assets/images/Bell Ring.png', width: 60, height: 60,),
                      title: Text(
                        device['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: device['name'] == 'RTS office' ? Colors.grey : Colors.black,
                        ),
                      ),
                      subtitle: Text(device['date']!),
                      trailing: Text(device['version']!, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
