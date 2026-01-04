import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/prayer_time_model.dart';
import '../../services/prayer_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prayerService = PrayerService();
    final prayerTimes = prayerService.getPrayerTimes();
    return Scaffold(
      appBar: AppBar(
          title: const Text("Masjid App Home")),
      body: StreamBuilder<PrayerTime>(
          stream: prayerTimes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final prayer = snapshot.data!;

            return Padding(padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  prayerTile('Fajr', prayer.fajr),
                  prayerTile('Zuhr', prayer.zuhr),
                  prayerTile('Asr', prayer.asr),
                  prayerTile('Magrib', prayer.magrib),
                  prayerTile('Isha', prayer.isha),
                  const Divider(),
                  prayerTile('Jummah', prayer.jummah, highlight: true),
                ],
              ),
            );
          }
      ),
    );
  }

  Widget prayerTile(String prayerName, String prayerTime,
      {bool highlight = false}) {
    return Card(
        color: highlight ? Colors.green.shade50 : null,
        child: ListTile(
          title: Text(prayerName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: highlight ? Colors.green : null,
            ),
          ),
          trailing: Text(
            prayerTime,
            style: TextStyle(
              fontSize: 18,
              color: highlight ? Colors.green : null,
            ),
          ),
        ));
  }
}
