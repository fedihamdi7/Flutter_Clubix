import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_rental/responsable/post/EditPost.dart';

class oneelementPost extends StatefulWidget {
  final dynamic placeModel;
  oneelementPost({this.placeModel});

  @override
  State<oneelementPost> createState() => _oneelementPostState();
}

class _oneelementPostState extends State<oneelementPost> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12,
      ),
      child: Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          // color: Colors.blue,
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(3, 5),
            ),
            BoxShadow(
              blurRadius: 10,
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(-3, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image(
                  height: 220,
                  width: 300,
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "asset/img/posts/" + widget.placeModel["post_img"]),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.placeModel["post_title"],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(widget.placeModel["post_description"]),
                    SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      child: ButtonTheme(
                        height: 40,
                        child: RaisedButton(
                          onPressed: () {
                            // Navigator.pushReplacementNamed(context, '/home');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => editPost(widget.placeModel)));
                          },
                          color: CupertinoColors.activeBlue,
                          child: Text(
                            "Edit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
