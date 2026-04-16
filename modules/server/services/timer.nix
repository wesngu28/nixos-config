{
  systemd.timers."check-timer" = {
    wantedBy = ["timers.target"];
    timerConfig.OnCalendar = ["08:59 America/Los_Angeles" "20:59 America/Los_Angeles"];
    timerConfig.Unit = "check-timer.service";
  };

  systemd.services."check-timer" = {
    script = "/home/serpe/NotReproducible/check.sh";
    serviceConfig = {
      Type = "oneshot";
      User = "serpe";
    };
  };

  systemd.timers."gacha-timer" = {
    wantedBy = [ "timers.target" ];
    timerConfig.OnCalendar = [ "hourly" ];
    timerConfig.Unit = "gacha-timer.service";
  };

  systemd.services."gacha-timer" = {
    script = "/home/serpe/NotReproducible/gacher/checker.sh";
    serviceConfig = {
      Type = "oneshot";
      User = "serpe";
    };
  };
}
