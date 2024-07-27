import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/application/news_provider.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/core/helpers.dart';
import 'package:news_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).getNews();
    });

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
                Text(
                  "IN",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: Colors.white),
                ),
                SizedBox(width: 8.w),

                //Todo:  Removje if not required
                IconButton(
                  onPressed: () async {
                    await AuthServices().signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.r),
        child: Consumer<NewsProvider>(
          builder: (context, newsProvider, child) {
            return newsProvider.isLoading
                ? const Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ))
                : Column(
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
                        itemCount: newsProvider.news.articles?.length ?? 0,
                        itemBuilder: (context, index) {
                          final news = newsProvider.news.articles?[index];

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        news?.source?.name ?? "--",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                      SizedBox(height: 7.h),
                                      Text(
                                        news?.title ?? "--",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 13.h),
                                      Text(
                                        news?.publishedAt == null
                                            ? "Not available"
                                            : formatTimeAgo(news!.publishedAt!),
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
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            news?.urlToImage ??
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
                  );
          },
        ),
      ),
    );
  }
}
