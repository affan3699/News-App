import 'package:flutter/material.dart';

Widget NewsCard(BuildContext context, int index, List newsList) {
  return Container(
    width: 300.0,
    padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 20.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Color(0xFFEAEAEA), width: 1.0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                  (newsList[index].newsImage == null)
                      ? "https://ak.picdn.net/shutterstock/videos/6137654/thumb/1.jpg"
                      : (newsList[index].newsImage),
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        SizedBox(height: 5.0),
        Text(
          newsList[index].newsTitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
