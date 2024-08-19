import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emergency Locations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode, // Manage light/dark theme mode
      home: LocationsPage(
        toggleTheme: _toggleTheme,
        themeIcon: _themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
      ),
    );
  }
}

class LocationsPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final IconData themeIcon;

  LocationsPage({required this.toggleTheme, required this.themeIcon});

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List locations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  fetchLocations() async {
    final response = await http.get(Uri.parse('https://backend.houston24hourer.com/api/admin/locations'));
    if (response.statusCode == 200) {
      setState(() {
        locations = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load locations');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Locations'),
        actions: [
          IconButton(
            icon: Icon(widget.themeIcon),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: Image.network(
                      'https://backend.houston24hourer.com/storage/${location['img']}',
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(location['title']),
                    subtitle: Text('${location['city']}, ${location['state']}\n${location['address']}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(location: location),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
