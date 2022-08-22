class Subscription {
  final String showURL;
  final String showPic;
  final String showTitle;
  // late final Podcast? show;
  Subscription(this.showPic, this.showTitle, this.showURL);

  Subscription.fromJson(Map<String, dynamic> json)
      : showTitle = json['showTitle'],
        showPic = json['showPic'],
        showURL = json['showURL'];
  // show = json['show'] as Podcast;

  Map<String, dynamic> toJson() => {
        'showTitle': showTitle,
        'showPic': showPic,
        'showURL': showURL,
        // 'show': show.toString(),
      };
}
