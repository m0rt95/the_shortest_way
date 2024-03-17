import 'package:flutter/material.dart';

import '../../model/shortest_way_model.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({Key? key, required this.shortestWayModel})
      : super(key: key);

  final ShortestWayModel shortestWayModel;

  @override
  Widget build(BuildContext context) {
    final List<List<String>> coordinates = List.generate(4, (int i) {
      return List.generate(4, (int j) {
        return '($j,$i)';
      });
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD0BCFF),
        title: const Text('Preview Screen'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemCount: coordinates.length * coordinates[0].length,
        itemBuilder: (BuildContext context, int index) {
          final int rowIndex = index ~/ 4;
          final int columnIndex = index % 4;
          final String currentCoordinate = coordinates[rowIndex][columnIndex];
          final bool isBlocked = shortestWayModel.data.any((data) {
            final start = data.start;
            final end = data.end;
            return start.x == columnIndex && start.y == rowIndex ||
                end.x == columnIndex && end.y == rowIndex;
          });
          final bool isShortestPath = shortestWayModel.data
              .where((data) => data.field.contains(currentCoordinate))
              .isNotEmpty;
          final Color cellColor = _getCellColor(isBlocked, isShortestPath);
          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: cellColor,
            ),
            child: Center(
              child: Text(currentCoordinate),
            ),
          );
        },
      ),
    );
  }

  Color _getCellColor(bool isBlocked, bool isShortestPath) {
    if (isBlocked) {
      return Colors.black;
    } else if (isShortestPath) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }
}
