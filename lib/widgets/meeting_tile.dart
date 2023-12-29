import 'package:core_soft_meeting/config/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeetingTile extends StatelessWidget {
  final String status;
  final String startDate;
  final String endDate;
  final String place;
  final String description;
  final String startTime;
  final String endTime;

  final String meetingTitle;

  const MeetingTile({
    Key? key,
    required this.status,
    required this.meetingTitle,
    required this.startDate,
    required this.endDate,
    required this.place,
    required this.description,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: getStatusColor(status),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meetingTitle,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: black),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: black,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$startTime - $endTime',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(fontSize: 13, color: black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '$startDate - $endDate',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(fontSize: 15, color: black),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: black,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              status.toUpperCase(),
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.bold, color: black),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Color getStatusColor(String status) {
  return status == 'pendiente'
      ? orange
      : status == 'cancelada'
          ? red
          : status == 'realizada'
              ? green 
              : status == 'postergada'
                  ? blue
                  : status == 'no realizada'
                      ? Colors.grey 
                      : Colors.black; 
}
}
