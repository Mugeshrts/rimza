import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rimza/presentation/widgts/widgets.dart';

class ModeSelectionScreen extends StatefulWidget {
  final Map<String, String> device;
  const ModeSelectionScreen({Key? key, required this.device}) : super(key: key);

  @override
  _ModeSelectionScreenState createState() => _ModeSelectionScreenState();
}

class _ModeSelectionScreenState extends State<ModeSelectionScreen> {
  String currentTime = '';
  String currentDate = '';
  String selectedMode = 'Exam Mode'; // or 'Regular Mode'
  bool isExamMode = true;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    updateTime();
    timer = Timer.periodic(Duration(seconds: 1), (timer) => updateTime());
  }

  void updateTime() {
    final now = DateTime.now();
    setState(() {
      currentTime = DateFormat('hh:mm:ss a').format(now);
      currentDate = DateFormat('EEE, dd-MM-yyyy').format(now);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Widget modeButton(String label, IconData icon) {
    bool isSelected = selectedMode == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedMode = label);
        },
        child: Container(
          height: 50,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.orange.shade100 : Colors.blue.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isSelected ? Colors.orange : Colors.white),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.orange : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButton(String label, IconData icon) {
    return Expanded(
      child: Container(
        height: 60,
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton.icon(
          onPressed: () {
            // TODO: Add logic
          },
          icon: Icon(icon, color: Colors.white),
          label: Text(
            label,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(
    "${widget.device['name']} (${widget.device['version']})",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.blue.shade900,
    ),
  ),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.blue.shade900,
                  size: 30,
                ),
                onPressed: () {},
              ),
        ),
        actions: [
          Lottie.asset('assets/lotties/green.json', width: 60, height: 60),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue.shade900),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentTime,
                          style: TextStyle(
                            // color: const Color(0xFF2E3192),
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Technology',
                            // fontStyle: FontStyle.italic
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(currentDate, style: TextStyle(fontSize: 20)),
                        Text(
                          "Today : Working Day",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 1,
                    color: const Color.fromARGB(255, 7, 7, 7),
                    margin: EdgeInsets.symmetric(horizontal: 35),
                  ),
                  // Container(
                  //   width: 80,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //     color: Colors.orange,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Icon(Icons.view_module, color: Colors.white),
                  // ),
                  // RIGHT SECTION: Toggle (Rectangle Shape)
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade900),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExamMode = true;
                                });
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color:
                                      isExamMode
                                          ? Colors.amber
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.list_alt,
                                  color:
                                      isExamMode
                                          ? Colors.white
                                          : Colors.black54,
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExamMode = false;
                                });
                              },
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color:
                                      !isExamMode
                                          ? Colors.amber
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.alarm,
                                  color:
                                      !isExamMode
                                          ? Colors.white
                                          : Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(isExamMode ? "Exam Mode" : "Regular Mode"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Row(
            //   children: [
            //     modeButton('Regular Mode', Icons.lightbulb),
            //     modeButton('Exam Mode', Icons.assignment),
            //   ],
            // ),
            // SizedBox(height: 10),
            // Wrap(
            //   spacing: 10,
            //   runSpacing: 10,
            //   children: [
            //     Row(
            //       children: [
            //         actionButton('Holiday', Icons.calendar_today),
            //         actionButton('Music', Icons.music_note),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         actionButton('SVM', Icons.schedule),
            //         actionButton('DVM', Icons.video_call),
            //       ],
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ModeCard(
                      icon: Icons.alarm,
                      text: "Regular Mode",
                      onTap: () {},
                    ),
                    ModeCard(
                      icon: Icons.edit_document,
                      text: "Exam Mode",
                      onTap: () {},
                    ),
                    ModeCard(icon: Icons.calendar_month_outlined, text: "Holiday", onTap: () {}),
                  ],
                ),
                Column(
                  children: [
                    ModeCard(icon: Icons.music_note_sharp, text: "Music", onTap: () {}),
                    ModeCard(icon: Icons.timer, text: "SVM", onTap: () {}),
                    ModeCard(icon: Icons.speaker, text: "DVM", onTap: () {}),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
