

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/prayer_time_model.dart';

class PrayerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<PrayerTime> getPrayerTimes() {
    return _firestore
        .collection('Mosques')
        .doc('masjid_001')
        .snapshots()
        .map((convert) {
          final data = convert.data();
          if (data == null || data.isEmpty || data['prayer_times'] == null) {
            throw Exception('Prayer times not found');
          }
          return PrayerTime.fromMap(data['prayer_times']);
        });
    }
  }