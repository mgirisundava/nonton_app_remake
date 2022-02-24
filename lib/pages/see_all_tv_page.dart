import 'package:flutter/material.dart';
import 'package:nonton_app/pages/tv_detail_page.dart';
import 'package:nonton_app/providers/see_all_provider.dart';
import 'package:nonton_app/theme.dart';
import 'package:nonton_app/widgets/poster_grid_item.dart';
import 'package:provider/provider.dart';

class SeeAllTvPage extends StatefulWidget {
  const SeeAllTvPage({Key? key}) : super(key: key);
  static const routeName = 'see-all-tv';

  @override
  State<SeeAllTvPage> createState() => _SeeAllTvPageState();
}

class _SeeAllTvPageState extends State<SeeAllTvPage> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final seeAllProvider = Provider.of<SeeAllProvider>(context, listen: false);
    final tvCategory = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        title: Text(
          tvCategory.toUpperCase(),
          style: whiteTextStyle.copyWith(
            fontWeight: bold,
          ),
        ),
        backgroundColor: blackColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: seeAllProvider.getSeeAllTv(tvCategory, 1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text(
                'An error occured!',
                style: whiteTextStyle,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: NotificationListener<ScrollEndNotification>(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 3,
                  ),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        TvDetailPage.routeName,
                        arguments: seeAllProvider.seeAllTv[index].id,
                      );
                    },
                    child: PosterGridItem(
                      index: index,
                      posterPath: seeAllProvider.seeAllTv[index].posterPath,
                      title: seeAllProvider.seeAllTv[index].name!,
                      voteAverage: seeAllProvider.seeAllTv[index].voteAverage!,
                    ),
                  ),
                  itemCount: seeAllProvider.seeAllTvLength,
                ),
                onNotification: (notification) {
                  // currentPage = currentPage + 1;
                  // seeAllProvider.getseeAllTv(
                  //   movieCategory,
                  //   currentPage,
                  // );
                  // print('Add New Data');
                  return true;
                },
              ),
            );
          }
        },
      ),
    );
  }
}
