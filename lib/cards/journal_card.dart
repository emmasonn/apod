import 'package:apod/domain/journal_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class JournalCard extends StatelessWidget {
  const JournalCard({Key? key, required this.journal}) : super(key: key);
  final Journal journal;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.greenAccent),
          child: Text(
            journal.title,
            style:
                GoogleFonts.lato(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          journal.body,
          style: GoogleFonts.lato(fontSize: 18),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          DateFormat('yyyy-MM-dd').format(journal.date),
          style: GoogleFonts.lato(fontSize: 14),
        ),
      ]),
    );
  }
}
