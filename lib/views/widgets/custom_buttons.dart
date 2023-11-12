import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSelector extends StatefulWidget {
  final bool forwardIcon;
  final bool backwardIcon;
  final bool centerText;
  final String titleText;
  final VoidCallback onPress;
  final bool isSquareShapeButton;
  final bool isSelected;
  final String path;

  const CustomSelector({
    super.key,
    required this.forwardIcon,
    required this.backwardIcon,
    required this.centerText,
    required this.titleText,
    required this.onPress,
    required this.isSquareShapeButton,
    required this.isSelected,
    required this.path,
  });

  @override
  State<CustomSelector> createState() => _CustomSelectorState();
}

class _CustomSelectorState extends State<CustomSelector> {
  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        widget.isSelected ? const Color(0xffFF5858) : Colors.white;
    Color textColor = widget.isSelected ? Colors.white : Colors.black;
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        // animation of button is pending
        height: 50,
        // width: MediaQuery.sizeOf(context).width * 0.29,

        decoration: BoxDecoration(
          color: buttonColor,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 177, 169, 169),
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
          borderRadius: widget.isSquareShapeButton == true
              ? BorderRadius.circular(10)
              : BorderRadius.circular(30),
          // border: Border.all(width: 1, color: Colors.white)
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          widget.backwardIcon == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    widget.path,
                    height: 25,
                    width: 25,
                  ))
              : const SizedBox(),
          Padding(
            padding: widget.centerText == false
                ? const EdgeInsets.fromLTRB(0, 0, 10, 0)
                : const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(' ${widget.titleText} ',
                style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: textColor)),
          ),
        ]),
      ),
    );
  }
}
