{config, ...}: {
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      "redlib" = {
        autoStart = true;
        image = "quay.io/redlib/redlib:latest";
        ports = ["8089:8080"];
        user = "nobody";
        environment = {
          "REDLIB_DEFAULT_AUTOPLAY_VIDEOS" = "off";
          "REDLIB_DEFAULT_COMMENT_SORT" = "confidence";
          "REDLIB_DEFAULT_DISABLE_VISIT_REDDIT_CONFIRMATION" = "off";
          "REDLIB_DEFAULT_FIXED_NAVBAR" = "on";
          "REDLIB_DEFAULT_FRONT_PAGE" = "default";
          "REDLIB_DEFAULT_HIDE_AWARDS" = "off";
          "REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION=" = "off";
          "REDLIB_DEFAULT_HIDE_SCORE" = "off";
          "REDLIB_DEFAULT_LAYOUT" = "card";
          "REDLIB_DEFAULT_POST_SORT" = "hot";
          "REDLIB_DEFAULT_BLUR_NSFW" = "off";
          "REDLIB_DEFAULT_SHOW_NSFW" = "on";
          "REDLIB_DEFAULT_THEME" = "dark";
          "REDLIB_DEFAULT_USE_HLS" = "off";
          "REDLIB_DEFAULT_WIDE" = "off";
          "REDLIB_PUSHSHIFT_FRONTEND" = "undelete.pullpush.io";
          "REDLIB_ROBOTS_DISABLE_INDEXING" = "on";
          "REDLIB_SFW_ONLY" = "off";
          "REDLIB_DEFAULT_HIDE_SIDEBAR_AND_SUMMARY" = "on";
        };
      };
    };
  };
}
