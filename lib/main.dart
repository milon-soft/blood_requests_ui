import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Requests',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        fontFamily: 'Roboto',
      ),
      home: const BloodRequestsScreen(),
    );
  }
}

class BloodRequest {
  final String bloodGroup;
  final int units;
  final String hospital;
  final bool urgent;

  const BloodRequest({
    required this.bloodGroup,
    required this.units,
    required this.hospital,
    this.urgent = true,
  });
}

class BloodRequestsScreen extends StatelessWidget {
  const BloodRequestsScreen({super.key});

  static const Color navy = Color(0xFF142F59);
  static const Color red = Color(0xFFEF233C);
  static const Color muted = Color(0xFF8491A4);

  final List<BloodRequest> requests = const [
    BloodRequest(
      bloodGroup: 'O-',
      units: 3,
      hospital: 'Khulna City Medical College Hospital, KDA Ave...',
    ),
    BloodRequest(
      bloodGroup: 'O+',
      units: 2,
      hospital: 'Khulna City Medical College Hospital, KDA Ave...',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                const SizedBox(height: 17),

                const Text(
                  'Blood Requests',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF293548),
                  ),
                ),

                const SizedBox(height: 23),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 23),
                    padding: const EdgeInsets.fromLTRB(14, 11, 14, 14),
                    color: const Color(0xFFF4F6F9),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: requests.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return BloodRequestCard(
                          request: requests[index],
                          navy: navy,
                          red: red,
                          muted: muted,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BloodRequestCard extends StatelessWidget {
  final BloodRequest request;
  final Color navy;
  final Color red;
  final Color muted;

  const BloodRequestCard({
    super.key,
    required this.request,
    required this.navy,
    required this.red,
    required this.muted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFE8EDF2), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF25364D).withValues(alpha: 0.07),
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 5, color: red),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11, 13, 13, 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Urgency and units
                    Row(
                      children: [
                        if (request.urgent)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE3E3),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'URGENT',
                              style: TextStyle(
                                color: Color(0xFFED303B),
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        const Spacer(),
                        Icon(Icons.water_drop, color: red, size: 13),
                        const SizedBox(width: 5),
                        Text(
                          '${request.units} Units',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF364152),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Blood group
                    Text(
                      '${request.bloodGroup} Blood Needed',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: navy,
                      ),
                    ),

                    const SizedBox(height: 9),

                    // Hospital location
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: muted,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            request.hospital,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: muted,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13),

                    // View details button
                    SizedBox(
                      width: double.infinity,
                      height: 34,
                      child: ElevatedButton(
                        onPressed: () {
                          // UI only: no additional functionality.
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: navy,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
