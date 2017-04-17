#define __WEAPON_AA "rhs_weap_SidewinderLauncher"
#define __WEAPON_AT "rhs_weap_hellfirelauncher"

private ["_veh"];

_veh = (_this select 0);
_veh removeWeapon __WEAPON_AA;
_veh removeWeapon __WEAPON_AT;

