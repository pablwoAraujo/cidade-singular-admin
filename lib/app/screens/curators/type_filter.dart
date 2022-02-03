import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TypeFilter extends StatefulWidget {
  const TypeFilter({Key? key, required this.onSelect}) : super(key: key);

  final Function(String?) onSelect;

  @override
  _TypeFilterState createState() => _TypeFilterState();
}

class _TypeFilterState extends State<TypeFilter> {
  CuratorType curatorFilter = CuratorType.values[0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: CuratorType.values.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              curatorFilter = CuratorType.values[index];
            });
            widget.onSelect(curatorFilter != CuratorType.values[0]
                ? curatorFilter.toString().split(".").last
                : null);
          },
          child: Opacity(
            opacity: curatorFilter == CuratorType.values[index] ? 1 : .6,
            child: Container(
              decoration: BoxDecoration(
                  color: Constants.getColor(
                      CuratorType.values[index].toString().split(".").last),
                  borderRadius: BorderRadius.circular(50)),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.only(
                left: index == 0 ? 32 : 0,
                right: 16,
                top: curatorFilter == CuratorType.values[index] ? 0 : 5,
                bottom: curatorFilter == CuratorType.values[index] ? 0 : 5,
              ),
              child: index == 0
                  ? Center(
                      child: Text(
                      "Todos",
                      style: TextStyle(color: Colors.black),
                    ))
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(CuratorType.values[index].value),
                        SvgPicture.asset(
                            "assets/images/${CuratorType.values[index].toString().split(".").last}.svg",
                            width: 20)
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
