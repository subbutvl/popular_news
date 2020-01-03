import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card.dart';
import 'package:clean_news_ai/ui/ui_elements/list_element/news_card_presenter.dart';
import 'package:clean_news_ai/ui/widgets/title_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osam/osam.dart';

import '../../../main.dart';
import 'favorites_presenter.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen(Key key) : super(key: key);
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey<SliverAnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterProvider.of<FavoritesPresenter>(context);
    return CustomScrollView(
      physics: scrollPhysics,
      slivers: <Widget>[
        TitleAppBar(title: 'Favorites'),
        SliverPadding(
          padding: EdgeInsets.only(top: 8),
        ),
        StreamBuilder(
          stream: presenter.stream,
          initialData: presenter.initialData,
          builder: (ctx, AsyncSnapshot<List<Article>> snapshot) {
            return SliverAnimatedList(
              key: _listKey,
              initialItemCount: snapshot.data.length,
              itemBuilder: (ctx, index, animation) {
                return PresenterProvider(
                  key: ValueKey(snapshot.data[index]),
                  presenter: NewsCardPresenter(snapshot.data[index]),
                  child: NewsCard(listKey: _listKey, index: index),
                );
              },
            );
          },
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 20),
        ),
      ],
    );
  }
}
