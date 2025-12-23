import 'package:flutter/material.dart';
import 'package:protfolio/utils/project_utils.dart';

import '../constants/colors.dart';
import 'package:protfolio/utils/url_opener.dart' as url_opener;

class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({super.key, required this.project});
  final ProjectUtils project;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 290,
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CustomColor.bgLight2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // project img
          Image.asset(
            project.image,
            height: 140,
            width: 260,
            fit: BoxFit.cover,
          ),
          // title
          Padding(
            padding: EdgeInsets.fromLTRB(12, 15, 12, 12),
            child: Text(
              project.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CustomColor.whitePrimary,
              ),
            ),
          ),
          // subtitle
          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Text(
              project.subtitle,
              style: TextStyle(fontSize: 12, color: CustomColor.whiteSecondary),
            ),
          ),
          Spacer(),
          // footer
          Container(
            color: CustomColor.bgLight1,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Text(
                  "Available on:",
                  style: TextStyle(
                    color: CustomColor.yellowSecondary,
                    fontSize: 10,
                  ),
                ),
                Spacer(),
                if (project.iosLink != null)
                  InkWell(
                    onTap: () => url_opener.openUrl(project.iosLink!),
                    child: Image.asset("assets/ios_icon.png", width: 19),
                  ),
                if (project.androidLink != null)
                  Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: InkWell(
                      onTap: () => url_opener.openUrl(project.androidLink!),
                      child: Image.asset("assets/android_icon.png", width: 17),
                    ),
                  ),
                if (project.webLink != null)
                  Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: InkWell(
                      onTap: () => url_opener.openUrl(project.webLink!),
                      child: Image.asset("assets/web_icon.png", width: 17),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
