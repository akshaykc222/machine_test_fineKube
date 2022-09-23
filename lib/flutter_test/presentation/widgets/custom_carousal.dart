import 'package:flutter/material.dart';
import 'package:machine_test02/core/pretty_printer.dart';

class CustomCarousal extends StatefulWidget {
  final List<Widget> items;

  const CustomCarousal({Key? key, required this.items}) : super(key: key);

  @override
  State<CustomCarousal> createState() => _CustomCarousalState();
}

class _CustomCarousalState extends State<CustomCarousal> {
  final controller = PageController(initialPage: 1, viewportFraction: 0.4);
  int current = 1;
  @override
  void initState() {
    controller.addListener(() {
      prettyPrint("${controller.position.pixels}");
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.animateTo(MediaQuery.of(context).size.width * 0.572,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        pageSnapping: false,
        controller: controller,
        itemCount: widget.items.length,
        scrollDirection: Axis.horizontal,
        onPageChanged: (page) {
          setState(() {
            current = page;
          });
        },
        itemBuilder: (context, index) {
          return Transform.scale(
            scale: (index == current || index == current + 1) ? 1 : 0.8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: widget.items[index],
            ),
          );
        });
  }
}
