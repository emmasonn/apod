import 'package:apod/styles/apod_theme.dart';
import 'package:apod/widget/input_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid.dart';
import 'package:google_fonts/google_fonts.dart';

import '../domain/journal_model.dart';

class AddJournalEntry extends StatefulWidget {
  const AddJournalEntry({
    Key? key,
    this.entry,
    required this.onSave,
  }) : super(key: key);

  final Journal? entry;
  final Function(Journal) onSave;

  @override
  State<AddJournalEntry> createState() => _AddJournalEntryState();
}

class _AddJournalEntryState extends State<AddJournalEntry> {
  final TextEditingController titleEditTextcontroller = TextEditingController();
  final TextEditingController bodyEditTextController = TextEditingController();
  late DateTime? date;
  late Journal entry;

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      titleEditTextcontroller.text = widget.entry!.title;
      bodyEditTextController.text = widget.entry!.body;
      date = widget.entry!.date;
    }
    date = DateTime.now();
  }

  void _savedEntry() {
    final entry = Journal(
        id: widget.entry?.id ?? const Uuid().v4(),
        title: widget.entry?.title ?? titleEditTextcontroller.text,
        body: widget.entry?.body ?? bodyEditTextController.text,
        date: widget.entry?.date ?? date!);
    widget.onSave(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.entry?.title ?? 'Add Journal Entry',
          style: ApodTheme.darkTextTheme.headline2,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _savedEntry();
            },
            icon: const Icon(
              Icons.done,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(
            height: 32,
          ),
          InputTextField(
            controller: titleEditTextcontroller,
            label: 'Title',
            hintText: 'eg..Deep Thought',
          ),
          const SizedBox(
            height: 32,
          ),
          InputTextField(
            controller: bodyEditTextController,
            label: 'Body',
            hintText: 'What\'s up',
          ),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date',
                    style: GoogleFonts.lato(fontSize: 28),
                  ),
                  TextButton(
                    onPressed: () async {
                      final currentDate = DateTime.now();
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: currentDate,
                        firstDate: currentDate,
                        lastDate: DateTime(currentDate.year + 5),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          date = selectedDate;
                        });
                      }
                    },
                    child: Text(
                      'Select',
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat('yyyy-MM-dd').format(date!),
                style: GoogleFonts.lato(fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }
}
