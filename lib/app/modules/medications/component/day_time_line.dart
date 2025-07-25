import 'package:flutter/material.dart';

class DayTimeline extends StatelessWidget {
  final List<DoseStep> steps;
  final int currentStep; // index starting from 0

  const DayTimeline({
    Key? key,
    required this.steps,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps.length, (index) {
        final isCompleted = index < currentStep;
        final isCurrent = index == currentStep;

        return Expanded(
          child: Column(
            children: [
              // الخط والدائرة
              Row(
                children: [
                  if (index != 0)
                    Expanded(
                      child: Container(
                        height: 4,
                        color: isCompleted
                            ? Colors.blue
                            : isCurrent
                                ? Colors.orange
                                : Colors.grey.shade300,
                      ),
                    ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? Colors.blue
                          : isCurrent
                              ? Colors.white
                              : Colors.grey.shade200,
                      border: Border.all(
                        color: isCurrent
                            ? Colors.orange
                            : isCompleted
                                ? Colors.blue
                                : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check,
                              size: 18, color: Colors.white)
                          : Text(
                              '${index + 1}',
                              style: TextStyle(
                                color:
                                    isCurrent ? Colors.orange : Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  if (index != steps.length - 1)
                    Expanded(
                      child: Container(
                        height: 4,
                        color: index < currentStep
                            ? Colors.blue
                            : index == currentStep
                                ? Colors.orange
                                : Colors.grey.shade300,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                steps[index].label,
                style: TextStyle(
                  color: isCurrent || isCompleted
                      ? Colors.blue.shade900
                      : Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                steps[index].time,
                style: TextStyle(
                  color: isCurrent || isCompleted
                      ? Colors.blue.shade700
                      : Colors.grey,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class DoseStep {
  final String label;
  final String time;

  DoseStep({required this.label, required this.time});
}
