import 'package:flutter/material.dart';
import 'base_page.dart';

enum RefreshStatus { idle, canRefresh, refreshing, completed }


class ListResult<T> {
  final List<T> items;
  final bool hasMore;
  ListResult(this.items, this.hasMore);
}

abstract class ListPage<T> extends StatefulWidget {
  final String? title;
  const ListPage({Key? key, this.title}) : super(key: key);

  // 子类需实现
  Future<ListResult<T>> fetchData({bool loadMore = false});
  Widget buildItem(BuildContext context, T item, int index);

  @override
  State<ListPage<T>> createState() => _ListPageState<T>();
}

class _ListPageState<T> extends State<ListPage<T>> {
  RefreshStatus _refreshStatus = RefreshStatus.idle;
  bool _showLoadMoreIndicator = false;
  bool _refreshing = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  List<T> _data = [];

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  Future<void> _onRefresh() async {
    if (_refreshing || _refreshStatus == RefreshStatus.refreshing || _isLoadingMore) return;
    _refreshing = true;
    setState(() {
      _refreshStatus = RefreshStatus.refreshing;
      _showLoadMoreIndicator = false;
    });
    final result = await widget.fetchData(loadMore: false);
    setState(() {
      _data = result.items;
      _hasMore = result.hasMore;
      _refreshStatus = RefreshStatus.idle;
      _showLoadMoreIndicator = false;
    });
    _refreshing = false;
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore || _refreshing) return;
    setState(() {
      _isLoadingMore = true;
      _showLoadMoreIndicator = true;
    });
    final result = await widget.fetchData(loadMore: true);
    setState(() {
      _data.addAll(result.items);
      _hasMore = result.hasMore || result.items.isNotEmpty;
      _isLoadingMore = false;
      _showLoadMoreIndicator = false;
    });
  }

  bool _onScrollNotification(ScrollNotification notification) {
    // 下拉刷新
    if (notification is ScrollUpdateNotification && notification.metrics.pixels < 0 && !_refreshing && !_isLoadingMore) {
      if (_refreshStatus != RefreshStatus.refreshing) {
        setState(() {
          _refreshStatus = notification.metrics.pixels < -60 ? RefreshStatus.canRefresh : RefreshStatus.idle;
        });
      }
    }
    if (notification is ScrollEndNotification && notification.metrics.pixels < 0 && _refreshStatus == RefreshStatus.canRefresh && !_refreshing && !_isLoadingMore) {
      _onRefresh();
    }
    // 上拉加载更多
    if (notification.metrics.pixels >= notification.metrics.maxScrollExtent - 60 && !_isLoadingMore && _hasMore && !_refreshing) {
      setState(() {
        _showLoadMoreIndicator = true;
      });
      _loadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: widget.title ?? '',
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  if (_refreshStatus == RefreshStatus.refreshing)
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.blue)),
                          ),
                          const SizedBox(width: 8),
                          Text(_refreshText[_refreshStatus] ?? '', style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  if (_showLoadMoreIndicator && _isLoadingMore && !_refreshing)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.blue)),
                          ),
                          const SizedBox(width: 8),
                          const Text('加载中...', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == _data.length) {
                    if (_hasMore) {
                      return const SizedBox.shrink();
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: Text('没有更多了', style: TextStyle(color: Colors.grey))),
                      );
                    }
                  }
                  return widget.buildItem(context, _data[index], index);
                },
                childCount: _data.length + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const Map<RefreshStatus, String> _refreshText = {
    RefreshStatus.idle: '下拉刷新',
    RefreshStatus.canRefresh: '松手刷新',
    RefreshStatus.refreshing: '加载中...',
    RefreshStatus.completed: '刷新完成',
  };
}
