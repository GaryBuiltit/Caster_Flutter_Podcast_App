class RecentTrack {
  final String episodeImage;
  final String showTitle;
  final String showImage;
  final String episodeTitle;
  final String episodeDescription;
  final String episodeURL;
  final String episodeLen;
  final String showURL;

  RecentTrack({
    required this.episodeImage,
    required this.showTitle,
    required this.showImage,
    required this.episodeTitle,
    required this.episodeDescription,
    required this.episodeURL,
    required this.episodeLen,
    required this.showURL,
  });

  RecentTrack.fromJson(Map<String, dynamic> json)
      : showTitle = json['showTitle'],
        episodeImage = json['episodeImage'],
        episodeTitle = json['episodeTitle'],
        episodeDescription = json['episodeDescription'],
        episodeLen = json['episodeLen'],
        showURL = json['showURL'],
        showImage = json['showImage'],
        episodeURL = json['episodeURL'];

  Map<String, dynamic> toJson() => {
        'showTitle': showTitle,
        'episodeImage': episodeImage,
        'episodeTitle': episodeTitle,
        'episodeDescription': episodeDescription,
        'episodeLen': episodeLen,
        'showURL': showURL,
        'episodeURL': episodeURL,
        'showImage': showImage,
      };
}
