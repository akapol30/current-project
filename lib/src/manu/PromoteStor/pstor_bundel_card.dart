import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_towin/src/modelclass/class_bundel.dart';

class PromoteStorBundleCard extends StatelessWidget {
  final PStorBundle promoteStorBundle;
  final VoidCallback press;

  const PromoteStorBundleCard(
      {Key? key, required this.promoteStorBundle, required this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: promoteStorBundle.color,
          borderRadius: BorderRadius.circular(18), //18
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20), //20
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    Text(
                      promoteStorBundle.title,
                      style: const TextStyle(
                          fontSize: 22, //22
                          color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5), // 5
                    Text(
                      promoteStorBundle.description,
                      style: const TextStyle(color: Colors.white54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    buildInfoRow(
                      70,
                      iconSrc: "assets/icons/pot.svg",
                      text: "${promoteStorBundle.amoutstor} Stor",
                    ),
                    const SizedBox(height: 5), //5
                    buildInfoRow(
                      70,
                      iconSrc: "assets/icons/chef.svg",
                      text: "${promoteStorBundle.post} Post",
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5), //5
            AspectRatio(
              aspectRatio: 0.71,
              child: Image.asset(
                promoteStorBundle.imageSrc,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildInfoRow(double defaultSize, {String? iconSrc, text}) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(iconSrc!),
        const SizedBox(width: 10), // 10
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
