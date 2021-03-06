import 'package:flutter/material.dart';

import '../views/empty_state.dart';
import 'themes.dart';

class TopicsCard extends StatelessWidget {
  const TopicsCard({
    Key? key,
    required this.size,
    required this.textScale,
    required this.data,
  }) : super(key: key);
  final Size size;
  final double textScale;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300 / mockUpWidth * size.width,
      decoration: BoxDecoration(
        color: const Color(0xff141414),
        borderRadius: BorderRadius.circular(10 / mockUpWidth * size.width),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15 / mockUpWidth * size.width,
        vertical: 14 / mockUpHeight * size.height,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150 / mockUpWidth * size.width,
                  child: Text(
                    "COURSE " + data["course-number"].toString(),
                    overflow: TextOverflow.ellipsis,
                    textScaleFactor: textScale,
                    style: veripolTextStyles.labelSmall.copyWith(
                      color: Colors.white.withOpacity(0.50),
                    ),
                  ),
                ),
                Text(
                  data["percentage-completed"].toString() + "% COMPLETED",
                  textScaleFactor: textScale,
                  style: veripolTextStyles.labelSmall.copyWith(
                    color: Colors.white.withOpacity(0.50),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 257 / mockUpWidth * size.width,
            child: Text(
              data["topic-title"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: textScale,
              style: veripolTextStyles.titleLarge.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 5 / mockUpHeight * size.height,
          ),
          SizedBox(
            width: 257 / mockUpWidth * size.width,
            child: Text(
              data["description"],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textScaleFactor: textScale,
              style: veripolTextStyles.labelSmall.copyWith(
                color: Colors.white.withOpacity(0.80),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EmptyState()));
            },
            style: ElevatedButton.styleFrom(
              primary: const Color(0xff1571F2),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(3 / mockUpWidth * size.width),
              ),
            ),
            child: SizedBox(
              height: 36 / mockUpHeight * size.height,
              child: Center(
                child: Text(
                  "START",
                  style: Theme.of(context).textTheme.overline!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
