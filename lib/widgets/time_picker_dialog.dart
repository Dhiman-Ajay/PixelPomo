// lib/widgets/time_picker_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pixelpomo/providers/timer_provider.dart';
import 'package:pixelpomo/theme/app_theme.dart';

class CustomTimePickerDialog extends StatefulWidget {
  final int initialWorkSeconds;
  final int initialBreakSeconds;

  const CustomTimePickerDialog({
    super.key,
    required this.initialWorkSeconds,
    required this.initialBreakSeconds,
  });

  @override
  State<CustomTimePickerDialog> createState() => _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
  late TextEditingController _workHoursController, _workMinutesController, _workSecondsController;
  late TextEditingController _breakHoursController, _breakMinutesController, _breakSecondsController;

  @override
  void initState() {
    super.initState();
    _workHoursController = TextEditingController(text: (widget.initialWorkSeconds ~/ 3600).toString());
    _workMinutesController = TextEditingController(text: ((widget.initialWorkSeconds % 3600) ~/ 60).toString());
    _workSecondsController = TextEditingController(text: (widget.initialWorkSeconds % 60).toString());

    _breakHoursController = TextEditingController(text: (widget.initialBreakSeconds ~/ 3600).toString());
    _breakMinutesController = TextEditingController(text: ((widget.initialBreakSeconds % 3600) ~/ 60).toString());
    _breakSecondsController = TextEditingController(text: (widget.initialBreakSeconds % 60).toString());
  }

  @override
  void dispose() {
    _workHoursController.dispose();
    _workMinutesController.dispose();
    _workSecondsController.dispose();
    _breakHoursController.dispose();
    _breakMinutesController.dispose();
    _breakSecondsController.dispose();
    super.dispose();
  }

  void _onDone() {
    final workHours = int.tryParse(_workHoursController.text) ?? 0;
    final workMinutes = int.tryParse(_workMinutesController.text) ?? 0;
    final workSeconds = int.tryParse(_workSecondsController.text) ?? 0;
    final totalWorkSeconds = (workHours * 3600) + (workMinutes * 60) + workSeconds;

    final breakHours = int.tryParse(_breakHoursController.text) ?? 0;
    final breakMinutes = int.tryParse(_breakMinutesController.text) ?? 0;
    final breakSeconds = int.tryParse(_breakSecondsController.text) ?? 0;
    final totalBreakSeconds = (breakHours * 3600) + (breakMinutes * 60) + breakSeconds;

    final finalWorkSeconds = totalWorkSeconds > 0 ? totalWorkSeconds : 1;
    final finalBreakSeconds = totalBreakSeconds > 0 ? totalBreakSeconds : 1;

    final provider = Provider.of<TimerProvider>(context, listen: false);
    provider.updateDurations(finalWorkSeconds, finalBreakSeconds);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.surface,
      title: const Text('Set Durations', style: TextStyle(color: AppTheme.white)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Focus Time (H:M:S)", style: TextStyle(color: AppTheme.grey)),
            const SizedBox(height: 8),
            _buildTimeInputRow(_workHoursController, _workMinutesController, _workSecondsController),
            const SizedBox(height: 20),
            const Text("Break Time (H:M:S)", style: TextStyle(color: AppTheme.grey)),
            const SizedBox(height: 8),
            _buildTimeInputRow(_breakHoursController, _breakMinutesController, _breakSecondsController),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: AppTheme.grey)),
        ),
        TextButton(
          onPressed: _onDone,
          child: const Text('Done', style: TextStyle(color: AppTheme.primaryPurple, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildTimeInputRow(TextEditingController h, TextEditingController m, TextEditingController s) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeField(h),
        const Text(' : ', style: TextStyle(fontSize: 24, color: AppTheme.white, fontWeight: FontWeight.bold)),
        _buildTimeField(m),
        const Text(' : ', style: TextStyle(fontSize: 24, color: AppTheme.white, fontWeight: FontWeight.bold)),
        _buildTimeField(s),
      ],
    );
  }

  Widget _buildTimeField(TextEditingController controller) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppTheme.white, fontSize: 22),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12)
        ),
      ),
    );
  }
}