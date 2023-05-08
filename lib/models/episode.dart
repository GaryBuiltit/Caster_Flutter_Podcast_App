class Episode {
  final String epsiodeTitle;
  final String episodeImage;
  final String episodeDescription;
  final String episodeURL;
  final Duration episodeLen;
  Episode(
      {required this.epsiodeTitle,
      required this.episodeImage,
      required this.episodeDescription,
      required this.episodeURL,
      required this.episodeLen});

  // Episode.fromJson(Map<String, dynamic>json);

  toJson() => {
        'episodeTitle': epsiodeTitle,
        'episodeImage': episodeImage,
        'episode': episodeDescription
      };
}
