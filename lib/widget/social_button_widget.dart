import 'package:flutter/material.dart';

Widget socialButton(Function() ontap, String title, String image) {
  return InkWell(
    onTap: () => ontap,
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          Image.asset(image),
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    ),
  );
}
