import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateField extends StatefulWidget {
  final String label;
  final bool showLabel;
  final Color labelColor;
  final double radius;

  const AppDateField({
    super.key,
    required this.label,
    this.showLabel = true,
    this.labelColor = Colors.black,
    this.radius = 30,
  });

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  TextEditingController _controller = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1995, 5, 5),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        _controller.text = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = "05/05/1995"; // default value
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.showLabel,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: widget.labelColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today, color: Color(0xFF0C2D48)),
              onPressed: _selectDate,
            ),
          ),
        ),
      ],
    );
  }
}
