import 'package:flutter/material.dart';

///
/// Created by Auro  on 23/01/22 at 10:52 pm
///

class CounterButton extends StatefulWidget {
  final int count;
  final Function(int r)? onChanged;

  const CounterButton({this.count = 0, this.onChanged});

  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  int count = 0;

  @override
  void initState() {
    super.initState();
    count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColoredButton(
          color: Color(0xffDEDEDE),
          name: "-",
          onTap: () {
            if (count > 0) {
              setState(() {
                count--;
              });
            }
            widget.onChanged?.call(count);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "$count",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ColoredButton(
          name: "+",
          textColor: Colors.white,
          onTap: () {
            setState(() {
              count++;
            });
            widget.onChanged?.call(count);
          },
        ),
      ],
    );
  }
}

class ColoredButton extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;
  final Color? color;
  final Color? textColor;

  const ColoredButton({this.name = '', this.onTap, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 32,
        width: 32,
        alignment: Alignment.center,
        child: Text(
          "$name",
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        decoration: BoxDecoration(
          color: color ?? Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
