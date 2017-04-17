if!(local player ) exitWith {};

sleep 20;

[] spawn 
{ 
    {
   	    if(_x isKindOf 'Car') then
	    {
            switch (_x getVariable ["AUG",'']) do
		    {
		        case 'hammer' :
                {
				    if!( _x getVariable ["aug_actions",false]) then 
				    {
				        [_x] execVM "functions\HammerAUG.sqf";
				    };
                };
		        case 'offroad' :
                {
				    if!( _x getVariable ["aug_actions",false]) then 
				    {
				        [_x] execVM "functions\OffroadAUG.sqf";
                    };					 
                };
		        case 'zamak' :
                {
				    if!( _x getVariable ["aug_actions",false]) then  
				    {				
				        [_x] execVM "functions\ZamakAUG.sqf";
					};
                };
		        case 'uaz' :
                {
				    if!( _x getVariable ["aug_actions",false]) then  
				    {				
				        [_x] execVM "functions\UazAUG.sqf";
					};
                };
                default {};				
		    };
        };
    } forEach vehicles;		
};