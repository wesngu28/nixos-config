{

	services.syncthing = {
		enable			= true;
		user			  = "serpe";
		dataDir			= "/home/serpe";
		configDir		= "/home/serpe/.config/syncthing";

		settings = {
			devices = {
				"homeaway"		= { id = "KZBQ4JJ-MOKQDFV-3OKO64X-VHCUSSU-H4D55M2-LCBREUM-EHZLXGH-77GQEAT"; };
				"vanguard"	= { id = "NGOSQ5C-V2WZO5D-VOTUULM-63NUIWR-NEQTCHZ-EP4BASI-FUW2K5Z-C6EWBQX"; };
			};

			folders = {
				"Obsidian" = {
					enable	 = true;
					id		= "stutq-qr54k";
					path	= "/home/serpe/Obsidian";
					devices	= [ "homeaway" "vanguard" ];
				};
			};
		};
	};

  networking.firewall.allowedTCPPorts = [ 22000 ];
	networking.firewall.allowedUDPPorts = [ 22000 21027 ];

}