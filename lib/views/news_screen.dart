import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/colors.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyNews",
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: Colors.white)),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Row(
              children: [
                Icon(
                  Icons.near_me,
                  size: 15.sp,
                ),
                SizedBox(width: 8.w),
                Text("IN",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.white))
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top Headlines",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 15.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(13.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "News Source",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            SizedBox(height: 7.h),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                              style: Theme.of(context).textTheme.bodyLarge,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 13.h),
                            Text(
                              "10 min ago",
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  height: 15.sp / 10.sp,
                                  color: kMistGray),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 119.h,
                        width: 119.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: const DecorationImage(
                                image: NetworkImage(
                                  "https://thumbs.dreamstime.com/b/breaking-news-background-breaking-news-background-world-global-tv-news-banner-design-100399311.jpg",
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 15.h);
              },
            ),
          ],
        ),
      ),
    );
  }
}
