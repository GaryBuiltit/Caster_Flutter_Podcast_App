class RecentTrack {
  final double id;
  final String episodeImage;
  final String showTitle;
  final String showImage;
  final String episodeTitle;
  final String episodeDescription;
  final String episodeURL;
  final String episodeLen;
  final String showURL;
  final String currentPosition;

  RecentTrack({
    required this.id,
    required this.episodeImage,
    required this.showTitle,
    required this.showImage,
    required this.episodeTitle,
    required this.episodeDescription,
    required this.episodeURL,
    required this.episodeLen,
    required this.showURL,
    required this.currentPosition,
  });

  // RecentTrack.fromJson(Map<String, dynamic> json)
  //     : showTitle = json['showTitle'],
  //       episodeImage = json['episodeImage'],
  //       episodeTitle = json['episodeTitle'],
  //       episodeDescription = json['episodeDescription'],
  //       episodeLen = json['episodeLen'],
  //       showURL = json['showURL'],
  //       showImage = json['showImage'],
  //       episodeURL = json['episodeURL'];

  // Map<String, dynamic> toJson() => {
  //       'showTitle': showTitle,
  //       'episodeImage': episodeImage,
  //       'episodeTitle': episodeTitle,
  //       'episodeDescription': episodeDescription,
  //       'episodeLen': episodeLen,
  //       'showURL': showURL,
  //       'episodeURL': episodeURL,
  //       'showImage': showImage,
  //     };

  Map<String, dynamic> toMap() => {
        'id': id,
        'show_title': showTitle,
        'episode_image': episodeImage,
        'episode_title': episodeTitle,
        'episode_description': episodeDescription,
        'episode_length': episodeLen,
        'show_url': showURL,
        'episode_url': episodeURL,
        'show_image': showImage,
        'current_position': currentPosition,
      };
}
