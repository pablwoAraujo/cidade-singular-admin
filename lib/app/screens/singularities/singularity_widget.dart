import 'package:cidade_singular_admin/app/models/singularity.dart';
import 'package:cidade_singular_admin/app/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SingularityWidget extends StatelessWidget {
  const SingularityWidget({
    Key? key,
    required this.sing,
    this.margin = const EdgeInsets.all(16),
  }) : super(key: key);

  final Singularity sing;
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
          Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                sing.photos.isNotEmpty
                    ? sing.photos.first
                    : "https://via.placeholder.com/150",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sing.title,
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
                      SvgPicture.asset(
                        "assets/images/places.svg",
                        width: 16,
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          sing.address,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/hour.svg",
                        width: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        sing.visitingHours,
                        softWrap: false,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 25,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                  color: Colors.black26,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Remover",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              SizedBox(width: 5),
                              SvgPicture.asset(
                                "assets/images/trash.svg",
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
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
