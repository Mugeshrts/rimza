import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockModeCard extends StatefulWidget {
  @override
  _ClockModeCardState createState() => _ClockModeCardState();
}

class _ClockModeCardState extends State<ClockModeCard> {
  late Timer _timer;
  String _currentTime = '';
  bool isExamMode = true;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = DateFormat('hh.mm.ss a').format(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEEE, dd-MM-yyyy').format(DateTime.now());

    return Scaffold(
      body: 
       Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade100),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // LEFT SECTION
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentTime,
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Technology', // Optional
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    today,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Today : Working Day",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
      
            // DIVIDER
            Container(
              height: 70,
              width: 1,
              color: const Color.fromARGB(255, 7, 7, 7),
              margin: EdgeInsets.symmetric(horizontal: 12),
            ),
      
            // RIGHT SECTION: Toggle
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.list_alt),
                        color: isExamMode ? Colors.white : Colors.black54,
                        onPressed: () {
                          setState(() {
                            isExamMode = true;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            isExamMode ? Colors.amber : Colors.transparent,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.lightbulb_outline),
                        color: !isExamMode ? Colors.white : Colors.black54,
                        onPressed: () {
                          setState(() {
                            isExamMode = false;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            !isExamMode ? Colors.amber : Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text("Exam Mode"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
