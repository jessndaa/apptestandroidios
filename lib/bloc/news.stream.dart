import 'package:apptest/model/NewsModel.dart';
import 'package:rxdart/rxdart.dart';

class NewsStream {
    static NewsStream _instance;
  
  static NewsStream get intance{
    if (_instance == null) {
      _instance = new NewsStream();
    }
    return _instance;
  }
  bool isFisrtTime = true;
  BehaviorSubject<List<NewsModel>> _news$ = new BehaviorSubject.seeded([]);
  BehaviorSubject<int> _evnt$ = new BehaviorSubject.seeded(0);
  List<NewsModel> _news = [];
  int get size => _news$.value.length;
  int sizeNew = 0;
  Observable<List<NewsModel>> get newsChangedHandler$ => _news$.stream;
  Observable<int> get newsComeEventHandler$ => _evnt$.stream;

  setNews(List<NewsModel> news){
    if (isSameNot(news)) {
      _news = news.reversed.toList();
      _news$.add(news);
    }
  }

  addNews(NewsModel news){
    _news.add(news);
    _news$.add(_news);
  }
  setCount(int val){
    sizeNew = val;
    _evnt$.add(sizeNew);
  }
  resetCount(){
    sizeNew = 0;
    _evnt$.add(sizeNew);
  }
  bool isSameNot(List<NewsModel> news){
    if (isFisrtTime) {
      isFisrtTime = false;
      return true;
    }
    if (_news.length != news.length) {
      if (_news.length> news.length) {
         sizeNew = sizeNew > 1 ? sizeNew-- : 0;
      }
      if ( news.length > _news.length) {
         sizeNew++;
      }
      _evnt$.add(sizeNew);
      return true;
    }
    for (var item in news) {
      for (var item1 in _news) {
        if (item.title != item1.title || item.message != item1.message
              || item.sender != item1.sender || item.time != item1.time) {
              return true;
        } 
      }
    }
    return false;
  }
}