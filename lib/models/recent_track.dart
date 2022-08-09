class RecentTrack {
  String episodeTitle;
  String showTitle;
  String episodePic;

  RecentTrack(this.episodePic, this.showTitle, this.episodeTitle);

  RecentTrack.fromJson(Map<String, dynamic> json)
      : showTitle = json['showTitle'],
        episodePic = json['episodePic'],
        episodeTitle = json['episodeTitle'];

  Map<String, dynamic> toJson() => {
        'showTitle': showTitle,
        'episodePic': episodePic,
        'episodeTitle': episodeTitle,
      };
}
