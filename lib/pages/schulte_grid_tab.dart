import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kids_focus/common/config.dart';
import 'base_page.dart';

class SchulteGridTab extends StatefulWidget {
  const SchulteGridTab({super.key});

  @override
  State<SchulteGridTab> createState() => _SchulteGridTabState();
}

class _SchulteGridTabState extends State<SchulteGridTab> {
  int gridSize = 5;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Schulte Grid',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Grid Size: ', style: TextStyle(fontSize: 16)),
                DropdownButton<int>(
                  value: gridSize,
                  items: [3, 4, 5, 6, 7, 8, 9]
                      .map((size) => DropdownMenuItem(
                            value: size,
                            child: Text('${size}x$size'),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        gridSize = val;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(child: SchulteGrid(gridSize: gridSize)),
          ],
        ),
      ),
    );
  }
}

class SchulteGrid extends StatelessWidget {
  final int gridSize;
  final List<int>? numbers;

  const SchulteGrid({super.key, required this.gridSize, this.numbers});

  @override
  Widget build(BuildContext context) {
    final nums = numbers ?? (List.generate(gridSize * gridSize, (i) => i + 1)..shuffle(Random()));
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridSize,
        childAspectRatio: 1,
      ),
      itemCount: nums.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.lightGreenAccent,
          child: Center(
            child: Text(
              '${nums[index]}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
