// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rmapclick.sqf"
#include "..\x_setup.sqf"

disableSerialization;

private _pos = _this # 1;

__TRACE_1("","_this")

private _idx = -1;
private _min = 100000000;
private "_dist";
{
	private _dist = _x distance2D _pos;
	if (_dist < 200 && {_dist < _min}) then {
		_idx = _forEachIndex;
		_min = _dist;
	};
} forEach d_respawn_posis;

__TRACE_1("","_idx")

private _same = true;
if (_idx != -1) then {
	private _disp = [uiNamespace getVariable "XR_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (d_rmapclick_type == 0);
	private _ctrl = _disp displayCtrl 1500;

	if (lbCurSel _ctrl != _idx) then {
		private _midx = -1;
		private _curdata = _ctrl lbData (lbCurSel _ctrl);
		private _mrs = missionNamespace getVariable [_curdata, objNull];
		if (!isNull _mrs) then {
			if (_mrs distance2D _pos < 40) then {
				private _lbd = _ctrl lbData _idx;
				__TRACE_1("","_lbd")
				_midx = d_mob_respawns findIf {
					(_x # 0) == _lbd
				};
			};
		};
		__TRACE_1("","_midx")
		if (_midx == -1) then {
			_ctrl lbSetCurSel _idx;
			_same = false;
		};
	};
};

if (_same && {!isNil "d_cur_map_endpos" && {_pos inArea [d_cur_map_endpos, 40, 40, 0, false ]}}) then {
	__TRACE("Is in")
	if !(_this # 2) then {
		"d_exactpos_sel_mar" setMarkerPosLocal _pos;
		d_alt_map_pos = _pos;
	} else {
		"d_exactpos_sel_mar" setMarkerPosLocal d_cur_map_endpos;
		d_alt_map_pos = nil;
	};
};
