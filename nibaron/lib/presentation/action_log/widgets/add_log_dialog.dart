import 'package:flutter/material.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/theme/app_colors.dart';
import '../../../data/models/action_log_entry.dart';

class AddLogDialog extends StatefulWidget {
  final ActionLogEntry? log;
  final Function(ActionLogEntry) onSave;

  const AddLogDialog({
    super.key,
    this.log,
    required this.onSave,
  });

  @override
  State<AddLogDialog> createState() => _AddLogDialogState();
}

class _AddLogDialogState extends State<AddLogDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _durationController = TextEditingController();

  String _selectedCategory = 'Planting';
  String _selectedStatus = 'Completed';
  DateTime _selectedDateTime = DateTime.now();

  final List<String> _categories = [
    'Planting',
    'Watering',
    'Fertilizing',
    'Harvesting',
    'Pest Control',
    'Maintenance'
  ];

  final List<String> _statuses = ['Completed', 'In Progress', 'Pending', 'Cancelled'];

  @override
  void initState() {
    super.initState();

    if (widget.log != null) {
      final log = widget.log!;
      _titleController.text = log.title;
      _descriptionController.text = log.description;
      _locationController.text = log.location ?? '';
      _durationController.text = log.duration?.toString() ?? '';
      _selectedCategory = log.category;
      _selectedStatus = log.status;
      _selectedDateTime = log.timestamp;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.log == null ? 'Add Activity' : 'Edit Activity',
                style: TextStyles.headline3,
              ),
              const SizedBox(height: 20),

              // Title Field
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Activity Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Description Field
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Status Dropdown
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: _statuses.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Location and Duration Row
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _durationController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Duration (hours)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Date Time Selection
              OutlinedButton.icon(
                onPressed: () => _selectDateTime(context),
                icon: const Icon(Icons.access_time),
                label: Text(
                  '${_selectedDateTime.day}/${_selectedDateTime.month}/${_selectedDateTime.year} '
                  '${_selectedDateTime.hour.toString().padLeft(2, '0')}:'
                  '${_selectedDateTime.minute.toString().padLeft(2, '0')}',
                ),
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveLog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(widget.log == null ? 'Add Activity' : 'Update Activity'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveLog() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter activity title')),
      );
      return;
    }

    final log = ActionLogEntry(
      id: widget.log?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      timestamp: _selectedDateTime,
      category: _selectedCategory,
      status: _selectedStatus,
      location: _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
      duration: _durationController.text.trim().isEmpty ? null : double.tryParse(_durationController.text.trim()),
    );

    widget.onSave(log);
    Navigator.pop(context);
  }
}
