import 'package:chat/Presentation/Theme/MyTheme.dart';
import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        padding: const EdgeInsets.all(20),
        itemCount: 20,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: MyTheme.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0,5)
              )
            ],
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/icons/movies.png",
                height: 80,
              ),
              Text(
                "The Movies Zone",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "13 members",
                style: Theme.of(context).textTheme.displaySmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
