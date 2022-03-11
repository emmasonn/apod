import 'package:apod/styles/apod_theme.dart';
import 'package:apod/widget/input_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../domain/journal_model.dart';

class AddJournalEntry extends StatefulWidget {
  const AddJournalEntry({
    Key? key,
    this.entry,
    required this.onCreate,
    required this.onUpdate,
  })  : isUpdating = (entry != null),
        super(key: key);

  final Journal? entry;
  final Function(Journal) onCreate;
  final Function(Journal) onUpdate;
  final bool isUpdating;

  @override
  State<AddJournalEntry> createState() => _AddJournalEntryState();
}

class _AddJournalEntryState extends State<AddJournalEntry> {
  final TextEditingController titleEditTextcontroller = TextEditingController();
  final TextEditingController bodyEditTextController = TextEditingController();
  late DateTime? date;
  late Journal entry;
  late Color _currentColor;
  String? _title;
  String? _body;

  @override
  void initState() {
    super.initState();
    if (widget.entry != null) {
      titleEditTextcontroller.text = widget.entry!.title;
      bodyEditTextController.text = widget.entry!.body;
      date = widget.entry!.date;
    }
    date = DateTime.now();
    _currentColor = Colors.blue;

    // titleEditTextcontroller.addListener(() {
    //   if (titleEditTextcontroller.text != '') {
    //     setState(() {
    //       _title = titleEditTextcontroller.text;
    //     });
    //   }
    // });

    // bodyEditTextController.addListener(() {
    //   if (titleEditTextcontroller.text != '') {
    //     setState(() {
    //       _body = bodyEditTextController.text;
    //     });
    //   }
    // });
  }

  void _savedEntry() {
    final entry = Journal(
        id: widget.entry?.id ?? const Uuid().v4(),
        title: titleEditTextcontroller.text,
        body: bodyEditTextController.text,
        date: widget.entry?.date ?? date!);

    if (widget.isUpdating) {
      widget.onUpdate(entry);
    } else {
      widget.onCreate(entry);
    }
  }

  @override
  void disposed() {
    titleEditTextcontroller.dispose();
    bodyEditTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.entry?.title ?? 'Add Journal Entry',
          // style: ApodTheme.darkTextTheme.headline2,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InputTextField(
                  controller: titleEditTextcontroller,
                  label: 'Title',
                  hintText: 'eg..Deep Thought',
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: CircleAvatar(
                      backgroundColor: _currentColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: BlockPicker(
                              pickerColor: Colors.white,
                              onColorChanged: (color) {
                                setState(() {
                                  _currentColor = color;
                                });
                              },
                            ),
                            actions: [
                              TextButton(
                                child: const Text('Save'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
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
            ],
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
                (date == null) ? DateFormat('yyyy-MM-dd').format(date!) : '',
                style: GoogleFonts.lato(fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }
}
