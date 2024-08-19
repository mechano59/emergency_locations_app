import 'package:flutter/material.dart';
import 'models/location.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailsPage extends StatelessWidget {
  final Location location;

  DetailsPage({required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: 'https://backend.houston24hourer.com/storage/${location.img}',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              location.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('${location.city}, ${location.state}\n${location.address}'),
            SizedBox(height: 16.0),
            Text('Phone: ${location.tel}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16.0),
            Text(location.content, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16.0),
            Text('Coordinates: (${location.latitude}, ${location.longitude})', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
