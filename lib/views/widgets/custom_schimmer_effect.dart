import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10, // Number of shimmering items
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30.0,
            ),
            title: Container(
              height: 16.0,
              width: double.infinity,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 12.0,
              width: double.infinity,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
