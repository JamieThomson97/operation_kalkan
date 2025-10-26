import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:operation_kalkan/features/plan/presentation/widgets/plan_itinerary_card.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateUtils.dateOnly(DateTime.now());
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _selectedDate.subtract(const Duration(days: 365)),
      lastDate: _selectedDate.add(const Duration(days: 365)),
    );
    if (!mounted || picked == null) return;
    setState(() => _selectedDate = DateUtils.dateOnly(picked));
  }

  void _shiftDate(int days) {
    setState(() {
      _selectedDate = DateUtils.dateOnly(
        _selectedDate.add(Duration(days: days)),
      );
    });
  }

  String get _formattedDate =>
      DateFormat('EEE, MMM d').format(_selectedDate).replaceAll('.', '');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Itinerary",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => _shiftDate(-1),
                          icon: const Icon(Icons.chevron_left),
                          tooltip: 'Previous day',
                        ),
                        TextButton(
                          onPressed: _pickDate,
                          child: Text(
                            _formattedDate,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _shiftDate(1),
                          icon: const Icon(Icons.chevron_right),
                          tooltip: 'Next day',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PlanItineraryCard(date: _selectedDate),
            ),
          ],
        ),
      ),
    );
  }
}
