import 'package:cidade_singular_admin/app/models/user.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CuratorWidget extends StatelessWidget {
  const CuratorWidget({
    Key? key,
    required this.user,
    this.margin = const EdgeInsets.all(16),
  }) : super(key: key);

  final User user;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(width: 15),
          CircleAvatar(
            radius: 40,
            foregroundImage: NetworkImage(user.picture),
            onForegroundImageError: (_, __) {},
            child: Text(
              user.name[0],
              style: TextStyle(fontSize: 38),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Constants.primaryColor.withOpacity(.7),
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          user.email,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    user.description,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                        color: Constants.getColor(
                            user.curator_type.toString().split(".").last),
                        borderRadius: BorderRadius.circular(50)),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(user.curator_type?.value ?? ""),
                        SvgPicture.asset(
                            "assets/images/${user.curator_type.toString().split(".").last}.svg",
                            width: 20)
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
