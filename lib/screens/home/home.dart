import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/screens/home/home_category_item.dart';
import 'package:listar_flutter/screens/home/home_sliver_app_bar.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  HomePageModel _homePage;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  ///On select category
  void _onTapService(CategoryModel item) {
    switch (item.type) {
      case null:
        Navigator.pushNamed(context, Routes.category);
        break;

      default:
        Navigator.pushNamed(context, Routes.listProduct, arguments: item.title);
        break;
    }
  }

  ///Fetch API
  Future<void> _loadData() async {
    final ResultApiModel result = await Api.getHome();
    if (result.success) {
      final more = CategoryModel.fromJson({
        "id": 8,
        "name": Translate.of(context).translate('more'),
        "icon": "more_horiz",
        "color": "#ff8a65",
      });

      _homePage = HomePageModel.fromJson(result.data);
      _homePage.category.add(more);
      setState(() {
        _homePage = _homePage;
      });
    }
  }

  ///On navigate product detail
  void _onProductDetail(ProductModel item) {
    String route = item.type == ProductType.place
        ? Routes.productDetail
        : Routes.productDetailTab;
    Navigator.pushNamed(context, route);
  }

  ///Build category UI
  Widget _buildCategory() {
    if (_homePage?.category == null) {
      return Wrap(
        runSpacing: 10,
        alignment: WrapAlignment.center,
        children: List.generate(8, (index) => index).map(
          (item) {
            return HomeCategoryItem();
          },
        ).toList(),
      );
    }

    return Wrap(
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _homePage.category.map(
        (item) {
          return HomeCategoryItem(
            item: item,
            onPressed: (item) {
              _onTapService(item);
            },
          );
        },
      ).toList(),
    );
  }

  ///Build popular UI
  Widget _buildPopular() {
    if (_homePage?.popular == null) {
      return ListView(
        padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
        scrollDirection: Axis.horizontal,
        children: List.generate(8, (index) => index).map(
          (item) {
            return Padding(
              padding: EdgeInsets.only(left: 15),
              child: AppProductItem(
                type: ProductViewType.cardLarge,
              ),
            );
          },
        ).toList(),
      );
    }

    return ListView(
      padding: EdgeInsets.only(left: 5, right: 20, top: 10, bottom: 15),
      scrollDirection: Axis.horizontal,
      children: _homePage.popular.map(
        (item) {
          return Padding(
            padding: EdgeInsets.only(left: 15),
            child: SizedBox(
              width: 135,
              height: 160,
              child: AppProductItem(
                item: item,
                type: ProductViewType.cardLarge,
                onPressed: _onProductDetail,
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  ///Build list recent
  Widget _buildList() {
    if (_homePage?.list == null) {
      return Column(
        children: List.generate(8, (index) => index).map(
          (item) {
            return Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: AppProductItem(type: ProductViewType.small),
            );
          },
        ).toList(),
      );
    }

    return Column(
      children: _homePage.list.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: AppProductItem(
            onPressed: _onProductDetail,
            item: item,
            type: ProductViewType.small,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: AppBarHomeSliver(
              expandedHeight: 250,
              banners: _homePage?.banner ?? [],
            ),
            pinned: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                ),
                child: _buildCategory(),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Translate.of(context)
                              .translate('homepage.popular_wash_centers'),
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Padding(padding: EdgeInsets.only(top: 3)),
                        Text(
                          Translate.of(context).translate(
                              'homepage.let_find_popular_wash_center_desc'),
                          style: Theme.of(context).textTheme.body2,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 195,
                child: _buildPopular(),
              ),

              // popular service centers
              Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Translate.of(context)
                              .translate('homepage.popular_service_centers'),
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Padding(padding: EdgeInsets.only(top: 3)),
                        Text(
                          Translate.of(context).translate(
                              'homepage.let_find_popular_service_center_desc'),
                          style: Theme.of(context).textTheme.body2,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 195,
                child: _buildPopular(),
              ),

              //
            ]),
          )
        ],
      ),
    );
  }
}
