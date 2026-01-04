class PrayerTime {
  final String fajr;
  final String zuhr;
  final String asr;
  final String magrib;
  final String isha;
  final String jummah;

  PrayerTime({
    required this.fajr,
    required this.zuhr,
    required this.asr,
    required this.magrib,
    required this.isha,
    required this.jummah,
  });

  factory PrayerTime.fromMap(Map<String, dynamic> json) {
    return PrayerTime(
      fajr: json['fajr'] ?? 'N/A',
      zuhr: json['zuhr'] ?? 'N/A',
      asr: json['asr'] ?? 'N/A',
      magrib: json['magrib'] ?? 'N/A',
      isha: json['isha'] ?? 'N/A',
      jummah: json['jummah'] ?? 'N/A',
    );
  }
}
