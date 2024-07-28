import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/application/login_provider.dart';
import 'package:news_app/application/news_provider.dart';
import 'package:news_app/application/signup_provider.dart';
import 'package:news_app/core/colors.dart';
import 'package:news_app/core/helpers.dart';
import 'package:news_app/core/strings.dart';
import 'package:news_app/presentation/screens/login_screen.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsProvider>(context, listen: false).getNews();
    });

    return Consumer<NewsProvider>(builder: (context, newsProvider, child) {
      newsProvider.countryCodeFailureOrSuccess.fold(
        () {},
        (either) => either.fold(
          (failure) {
            final errorMessage = failure.maybeMap(
              throttled: (_) =>
                  "Frequency of requests exceeds throttled limits, default country code will be used.",
              orElse: () => "Something went wrong",
            );

            WidgetsBinding.instance.addPostFrameCallback((_) {
              showSnackbar(context, errorMessage);
            });
          },
          (_) {},
        ),
      );
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
                    color: Colors.white,
                    size: 15.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    newsProvider.isLoading
                        ? "--"
                        : newsProvider.countryCode.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 8.w),

                  //Todo:  Removje if not required
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content:
                                const Text('Are you sure you want to logout?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .logout(context);
                                  Provider.of<SignupProvider>(context,
                                          listen: false)
                                      .clearState();
                                  Provider.of<LoginProvider>(context,
                                          listen: false)
                                      .clearState();

                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
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
        body: newsProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : newsProvider.isError
                ? Center(
                    child: Text(
                        newsProvider.news.message ?? "Something went wrong",
                        style: Theme.of(context).textTheme.displayLarge),
                  )
                : SingleChildScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              : formatTimeAgo(
                                                  news!.publishedAt!),
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
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              news?.urlToImage ?? kImageUrl,
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
    });
  }
}
