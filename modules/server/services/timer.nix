{
  systemd.timers."check-timer" = {
    wantedBy = ["timers.target"];
    timerConfig.OnCalendar = ["09:59 America/Los_Angeles" "21:59 America/Los_Angeles"];
    timerConfig.Unit = "check-timer.service";
  };

  systemd.services."check-timer" = {
    script = "/home/serpe/NotReproducible/check.sh";
    serviceConfig = {
      Type = "oneshot";
      User = "serpe";
    };
  };
}
