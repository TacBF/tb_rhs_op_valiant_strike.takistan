//V2.0
//Add this to the INIT line of the vehicle you want to use nul = [this] execVM "ZamakAUG.sqf";
//Configured to work on Offroaders and trucks. Will work on nearly everything but weapon placing may be unrelyable.


//setup MP
mpAddEventHand = compileFinal "
(_this select 0) setVariable [ (_this select 3),(_this select 0) addEventHandler [(_this select 1),(_this select 2)],false];
";

mpRemoveEventHand = compileFinal "
(_this select 0) removeEventHandler [(_this select 1),(_this select 0) getVariable (_this select 2)];
";

mpSetDir = compileFinal "
(_this select 0) setDir (_this select 1);
"; 

mpSetPos = compileFinal "
(_this select 0) setPosATL (_this select 1);
";

//SetupLocal
_veh = (_this select 0);
_moved = false;
_Cname = nil;
_Dname = nil;
_add = nil;
_MG = ["RDS_M2StaticMG_FIA","RDS_M2StaticMG_CSAT","RDS_KORD_high_FIA","RDS_DSHKM_FIA","RDS_Igla_AA_pod_FIA","RDS_KORD_high_CSAT","RDS_DSHKM_CSAT","RDS_Igla_AA_pod_CSAT"];
_ZU = ["RDS_ZU23_FIA","RDS_ZU23_CSAT"];
_LMG = ["RDS_M2StaticMG_MiniTripod_FIA","RDS_M2StaticMG_MiniTripod_CSAT","RHS_NSV_TriPod_MSV","RDS_KORD_FIA","RDS_DSHkM_Mini_TriPod_FIA","RDS_Metis_FIA","RDS_KORD_CSAT","RDS_DSHkM_Mini_TriPod_CSAT","RDS_Metis_CSAT"];
_SPG = ["RDS_SPG9_FIA","RDS_SPG9_CSAT"];
_L = ["RDS_TOW_TriPod_FIA","RDS_TOW_TriPod_CSAT"];
_M = ["RDS_2b14_82mm_FIA","RDS_M252_FIA","RDS_2b14_82mm_CSAT","RDS_M252_CSAT","RDS_2b14_82mm_AAF"];

if(isNil { _veh getVariable "offAug_attached"}) then {
  _veh setVariable [ "offAug_attached",false,false];
} else {
  _veh setVariable [ "offAug_attached",(_veh getVariable "offAug_attached"),false];
};

//Action
_add = _veh addAction ["",{

	//Import Variables
	_veh = (_this select 3) select 0;
	_L = (_this select 3) select 1;
	_MG = (_this select 3) select 2;
	_M = (_this select 3) select 3;
	_LMG = (_this select 3) select 4;
	_SPG = (_this select 3) select 5;
	_ZU = (_this select 3) select 6;
	_aug = _veh getVariable "offAug_attached";
	_NO = nearestObjects [[(_veh modelToWorld [0,-5,0]) select 0,(_veh modelToWorld [0,-5,0]) select 1,0],_MG + _L + _M + _LMG + _SPG + _ZU,4];

	//Logic
	if(( typeNAME(_veh getVariable["offAug_attached",false]) == "BOOL")  AND ((count _NO) >= 1)) then {

		//Attach
		//Locations
		if(typeOf (_NO select 0) in _L) then {(_NO select 0) attachTo [_veh,[0,-1.5,0.25]];[[(_NO select 0),180],"mpSetDir",true,true]spawn BIS_fnc_MP;};
		if(typeOf (_NO select 0) in _LMG) then {(_NO select 0) attachTo [_veh,[-0.3,-1.5,0.6]];[[(_NO select 0),180],"mpSetDir",true,true]spawn BIS_fnc_MP;_veh animate ["HideDoor3", 1];};
		if(typeOf (_NO select 0) in _SPG) then {(_NO select 0) attachTo [_veh,[-0.1,-2,-0.7]];[[(_NO select 0),180],"mpSetDir",true,true]spawn BIS_fnc_MP;_veh animate ["HideDoor3", 1];};
		if(typeOf (_NO select 0) in _ZU) then {(_NO select 0) attachTo [_veh,[0.05,-2,1.55]];[[(_NO select 0),180],"mpSetDir",true,true]spawn BIS_fnc_MP;_veh animate ["HideDoor3", 1];};
		if(typeOf (_NO select 0) in _MG) then {(_NO select 0)attachTo [_veh,[0.25,-2,1]];};
		if(typeOf (_NO select 0) in _M) then {(_NO select 0) attachTo [_veh,[0,-2,0]];};
		
		//Event Handler
		sleep 1;

		[[ (_NO select 0),"GetOut",{(_this select 2) setPos ((_this select 0) modelToWorld [-3,-1.6,-2.3])},'EH_GETOUT'],"mpAddEventHand",true,true] spawn BIS_fnc_MP;
		 _veh setVariable["offAug_attached",(_NO select 0),true];
		if(typeOf (_NO select 0) in _ZU) then {(_NO select 0) setVariable [ "ICE_cargo_towable", false, true]};
	}else{
		if ( typeNAME(_veh getVariable["offAug_attached",false]) == "OBJECT") then {

			//Detach

			private ["_pos"];
			_pos = [(_veh modelToWorld [0,-7,0]) select 0,(_veh modelToWorld [0,-7,0]) select 1,0.25];
			sleep 0.1;
			_aug attachTo [_veh,[0,-2,3]];
			sleep 0.1;
			detach _aug;
			
			[[ _aug,_pos],"mpSetPos",true,true]spawn BIS_fnc_MP;
			//Remove event Handler
			[[_aug,"GetOut",'EH_GETOUT'],"mpRemoveEventHand",true,true]spawn BIS_fnc_MP;
			_veh setVariable["offAug_attached",false,true];
			if(typeOf _aug in _ZU) then { _aug setVariable [ "ICE_cargo_towable", true, true ]};
		}else{
			//Null
			hint "Nothing Mount/Dismount.";
		};
	};
},[_veh,_L,_MG,_M,_LMG,_SPG,_ZU],1.5,true,true,"","((speed _target <= 1) AND (speed _target >= -1)) and (_this distance _target < 7)"];

_veh setVariable ['AUG','zamak',true];
if(local player) then { _veh setVariable [ "aug_actions",true,false ] };

//scan
while {alive _veh} do {
sleep 1;

	if (speed _veh <= 1 AND speed _veh >= -1 ) then {
		if( typeNAME(_veh getVariable["offAug_attached",false]) == "OBJECT")  then{
            _aug = _veh getVariable "offAug_attached";
			//Display name
			_Cname = typeOf _aug;
			_Dname = getText (configFile >> "cfgVehicles" >> _Cname >> "displayName");
			_veh setUserActionText [ _add,format [ "<t color='#FFFF33'>"+localize "STR_dismount_out_vehicle"+"</t>",_Dname]];
			_EH_OUT = _aug getVariable 'EH_GETOUT';
			if(isNil '_EH_OUT') then {
			 [[ _aug,'GetOut',{(_this select 2) setPos ((_this select 0) modelToWorld [-3,-1.6,-2.3])},'EH_GETOUT'],"mpAddEventHand",true,true] call BIS_fnc_MP;
			 };
		}else{

			//Detection
			_NO = nearestObjects [[(_veh modelToWorld [0,-5,0]) select 0,(_veh modelToWorld [0,-5,0]) select 1,0],_MG + _L + _M + _LMG + _SPG + _ZU,4];
			//hint format [ "%1", _NO];

			if((count _NO)>=1)then{

			    _trailer = _veh getVariable "ICE_towing";
                if!(isNil "_trailer") then {_veh setUserActionText [_add,""] } else {
				//Display name
                _Aname = getText (configFile >> "cfgVehicles" >> (typeOf (_NO select 0)) >> "displayName");
				_Vname = getText (configFile >> "cfgVehicles" >> (typeOf _veh) >> "displayName");
				_veh setUserActionText [ _add,format [ "<t color='#FFFF33'>"+localize "STR_mount_in_vehicle"+"</t>",_Aname,_Vname] ];
				};
			}else{

				//Null
				_veh setUserActionText [_add,""];
			};
		};

	};
};






