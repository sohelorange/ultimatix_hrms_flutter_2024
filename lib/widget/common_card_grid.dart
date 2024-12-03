import 'package:flutter/material.dart';

class CommonCardGrid extends StatelessWidget {
  final List<int> counts;
  final List<String> names;
  final Function(int)? onCardPressed; // Function to handle card press

  const CommonCardGrid({
    super.key,
    required this.counts,
    required this.names,
    this.onCardPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 125,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: counts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (onCardPressed != null) {
                onCardPressed!(index); // Pass the index of the tapped card
              }
            },
            child: Card(
              //color: AppColors.colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(5), // Adjust padding here
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      counts[index].toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      names[index],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
