import 'package:flutter/material.dart';
import 'package:flutter_education/Screens/Courses/models/course_model.dart';

class CourseBundleCard extends StatelessWidget {
  final Function onClick;
  final CourseBundle courseBundle;
  const CourseBundleCard({
    Key key,
    this.courseBundle,
    this.onClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            color: courseBundle.color, borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 0.70,
              child: Image.network(
                courseBundle.imageSrc,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseBundle.title,
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    buildInfoRow(
                        icon: Icons.person, text: "${courseBundle.teacher}"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow({@required IconData icon, @required String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 10),
          Icon(
            icon,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
