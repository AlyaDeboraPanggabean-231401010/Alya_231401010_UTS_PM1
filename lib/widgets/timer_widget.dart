import 'package:flutter/material.dart';
import '../utils/constants.dart';

class TimerWidget extends StatelessWidget {
  final int timeRemaining;
  final double size;

  const TimerWidget({
    super.key,
    required this.timeRemaining,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = timeRemaining / AppConstants.quizTimerSeconds;
    Color timerColor;
    
    if (percentage > 0.6) {
      timerColor = Colors.green;
    } else if (percentage > 0.3) {
      timerColor = Colors.orange;
    } else {
      timerColor = Colors.red;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            value: percentage,
            strokeWidth: 6,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(timerColor),
          ),
        ),
        Text(
          '$timeRemaining',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: size * 0.3,
            fontWeight: FontWeight.bold,
            color: timerColor,
          ),
        ),
      ],
    );
  }
}