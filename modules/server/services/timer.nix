{
  services.cron = {
    enable = true;
    systemCronJobs = [
      "59 8,20 * * * /home/serpe/NotReproducible/check.sh"
    ];
  };
}
