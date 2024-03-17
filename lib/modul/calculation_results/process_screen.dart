import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../model/shortest_way_model.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({
    Key? key,
    this.isProgress,
    this.shortestWayModel,
  }) : super(key: key);

  final bool? isProgress;
  final ShortestWayModel? shortestWayModel;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _progressAnimation;
  late Animation<double> _fabOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _colorAnimation = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.yellow),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 50,
      ),
    ]).animate(_animationController);

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _fabOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 1.0), // Курва для анімації прозорості
      ),
    );

    if (widget.isProgress == true) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD0BCFF),
        title: const Text('Process screen'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'All calculations have finished, you can send your results to server',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 15.0,
                  animation: true,
                  progressColor: _colorAnimation.value,
                  percent: _progressAnimation.value,
                  animateFromLastPercent: true,
                  center: Text(
                    '${(_progressAnimation.value * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _fabOpacityAnimation,
        builder: (context, child) {
          return Opacity(
            opacity: _fabOpacityAnimation.value,
            child: FloatingActionButton.extended(
              backgroundColor: const Color(0xFFD0BCFF),
              onPressed: () {},
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Text(
                  'Send results to server',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
