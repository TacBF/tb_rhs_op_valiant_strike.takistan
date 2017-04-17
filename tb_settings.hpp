class ICE {
	
    class vehicles {
		
		class armaments {
			
			startFullyRearmed = 1;
        };
    };
	
	class zones {
		
		#include "zoneList.hpp"
	};
	
	class firstAid {
		
		bleedoutTimeSteps[] = {300, 0};
		bleedoutTimeReset = 180;
	};
	
	class mission {
		
		gameMode = "S&D";
		missionScale = "medium";
		recommendedTotalPlayers = 40;
		attackingSide = "west";

        class briefings {
			
			class west {
				
				original = "briefing_blue.hpp";
			};
			
			class east {
				
				original = "briefing_red.hpp";
			};
        };
		
		class factions {
			
			class faction {
				
				bluFor = "BLU_F";
				opFor = "OPF_G_F";
			};
			
			class teamName {
				
				bluFor = "US Special Forces";
				opFor = "Taliban Insurgents";
			};
			
			class teamFlag {
				
				bluFor = "\ice\ice_main\Images\flags\usa.paa";
				opFor = "\ice\ice_main\Images\flags\Taliban.paa";
			};
		};
		
		class scoring {
			
			class tickets {
				
				bluFor = 35;
				opFor = 3;
				ticketsPerCache = 40; // Tickets given to BLUFOR when a cache is destroyed
			};
		};
	};
	
	class respawn {
		
        class vehicles {
			
            class respawnDelay {
				
                multiplier = 0;
            };
        };
		
		class FO {
			
			minSpacingDist = 500;
			minZoneDist = 1000;
			maxFriendlySiteDist = 6000;
			minEnemyZoneDist = 1000;
			minEnemyBaseDist = 1000;
			minEnemyFBDist = 800;
		};
		
		class SRP {
			
			maxFriendlySiteDist = 1500;
		};
		
		class HO {
			
			minSpacingDist = 500;
			maxFriendlySiteDist = 2500;
			maxCacheDist = 1000;
			startingTickets = 20;
		};
		
        class infantry {
			
            baseDuration = 60;
			
            class unevenTeamsPenaltyTime {
				
                ratioDuration = 60;
                maxDuration = 120;
            };
        };
	};
	
	class gameModes {
		
		class objectives {
			
			class zones {
				
				class captureRates {
					
                    heldZoneMultiplier = 1.0;
					neutralZoneMultiplier = 1.5;
					negateNeutral = 1;
                };
			};
		};
		
		class SAD {
			
			class cache {
				
				minSpacingDist = 400;
			};
		};
    };
	
    class gear {
		
		#include "tb_kitDefines.sqh"
		
		class magazineExclusions {
			
			individualClasses[] = {
			
				#include "factions\BLU_F\BLU_F_magazineExclusions.hpp"
				#include "factions\OPF_G_F\OPF_G_F_magazineExclusions.hpp"
			};
	
			baseClasses[] = {
			
			};
		};
	
		class NVGogglesForAll {
		
			west = 1;
            east = 0;
            resistance = 0;
		};
		
		class roles {
	
			#define __unlimited -99
		
			kits[] = {
			
				#include "factions\BLU_F\BLU_F_roleRatio.hpp"
				#include "factions\OPF_G_F\OPF_G_F_roleRatio.hpp"
			};
		};

		class armaments {
		
			class BLU_F {
			
				defaultGear = "factions\BLU_F\default_Gear\BLU_F.sqh";
				#include "factions\BLU_F\_common_smallItems.sqh"
				#include "factions\BLU_F\BLU_F.sqh"
				#include "factions\BLU_F\BLU_F_uniforms.sqh"
			};
			
			class OPF_G_F {
			
				defaultGear = "factions\OPF_G_F\default_Gear\OPF_G_F.sqh";
				#include "factions\OPF_G_F\_common_smallItems.sqh"
				#include "factions\OPF_G_F\OPF_G_F.sqh"
				#include "factions\OPF_G_F\OPF_G_F_uniforms.sqh"
			};
		};
	};
};
