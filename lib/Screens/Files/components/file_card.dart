import 'package:flutter/material.dart';

class FileCard extends StatelessWidget {
  final String title, size;
  final Function onTap;
  final Icon icon;
  const FileCard({Key key, @required this.title, @required this.onTap, @required this.icon, @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      size,
                      style: TextStyle(
                          fontSize: 16
                      ),
                    )
                  ],
                ),
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
