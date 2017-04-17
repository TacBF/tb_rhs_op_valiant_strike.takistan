private ["_veh","_pos_point","_pos"];

_veh = _this select 0;
_pos_point = _this select 1;
_pos = (getPosATL _pos_point);
_veh setPosATL _pos;

sleep 1;

_veh setDammage 0;
['cs',{ _this setDammage 0 },_veh] call ICE_fnc_broadcast;


