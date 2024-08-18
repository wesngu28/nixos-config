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
          "REDLIB_DEFAULT_AUTOPLAY_VIDEOS" = "false";
          "REDLIB_DEFAULT_COMMENT_SORT" = "confidence";
          "REDLIB_DEFAULT_DISABLE_VISIT_REDDIT_CONFIRMATION" = "false";
          "REDLIB_DEFAULT_FIXED_NAVBAR" = "true";
          "REDLIB_DEFAULT_FRONT_PAGE" = "default";
          "REDLIB_DEFAULT_HIDE_AWARDS" = "false";
          "REDLIB_DEFAULT_HIDE_HLS_NOTIFICATION=" = "off";
          "REDLIB_DEFAULT_HIDE_SCORE" = "false";
          "REDLIB_DEFAULT_LAYOUT" = "card";
          "REDLIB_DEFAULT_POST_SORT" = "hot";
          "REDLIB_DEFAULT_BLUR_NSFW" = "false";
          "REDLIB_DEFAULT_SHOW_NSFW" = "true";
          "REDLIB_DEFAULT_THEME" = "dark";
          "REDLIB_DEFAULT_USE_HLS" = "true";
          "REDLIB_DEFAULT_WIDE" = "false";
          "REDLIB_PUSHSHIFT_FRONTEND" = "undelete.pullpush.io";
          "REDLIB_ROBOTS_DISABLE_INDEXING" = "true";
          "REDLIB_SFW_ONLY" = "false";
        };
      };
    };
  };
}
