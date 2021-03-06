/*
	ACD - ACiDy Exile Addons
	acd_fnc_createTradingOffice.sqf
	by d4n1ch
	mailto: d.e@acd.su

	updated by second_coming to fix jerky trader animations and added aircraft traders plus lighting

	Usage:
	
	[
	_isSafe, 		// [boolean: true/false] - Turn ON/OFF safe zone trigger
	_pos, 			// [array: getPosATL _obj] - Building position
	_general_direction, 	// [number: getDir _obj] - Direction of building
	_Armory, 		// [boolean: true/false] - Turn ON/OFF Armory trader and props
	_Equipment, 		// [boolean: true/false] - Turn ON/OFF Equipment trader and props
	_Food, 			// [boolean: true/false] - Turn ON/OFF Food trader and props
	_Hardware, 		// [boolean: true/false] - Turn ON/OFF Hardware trader and props
	_Office, 		// [boolean: true/false] - Turn ON/OFF Office trader and props
	_SpecialOperations, 	// [boolean: true/false] - Turn ON/OFF Special Operations trader and props
	_Vehicle, 		// [boolean: true/false] - Turn ON/OFF Vehicle trader and props
	_VehicleCustoms, 		// [boolean: true/false] - Turn ON/OFF VehicleCustoms trader and props
	_WasteDump, 		// [boolean: true/false] - Turn ON/OFF Waste Dump trader and props
	_Aircraft, 		// [boolean: true/false] - Turn ON/OFF Aircraft trader and props
	_AircraftCustoms, 	// [boolean: true/false] - Turn ON/OFF AircraftCustoms trader and props
	_ID
	] call acd_fnc_createTradingOffice;
	
	Example:
	
	[true,[15137.3,16695.4,0.00143814],300,true,true,true,true,true,true,true,true,true,true,true,347] call fnc_makeTrader;

*/
/*#######################################################################################*/

private["_pos","_ID"];
_isSafe = _this select 0;
_pos = _this select 1;
_general_direction = _this select 2;
_Armory = _this select 3;
_Equipment = _this select 4;
_Food = _this select 5;
_Hardware = _this select 6;
_Office = _this select 7;
_SpecialOperations = _this select 8;
_Vehicle = _this select 9;
_VehicleCustoms = _this select 10;
_WasteDump = _this select 11;
_Aircraft = _this select 12;
_AircraftCustoms = _this select 13;
_ID = _this select 14;
/*#######################################################################################*/
_main_building_class = "Land_milOffices_V1_f";	  
_main_building = _main_building_class createVehicleLocal [0,0,0];	  
_main_building setPos _pos;
_main_building setDir _general_direction;

_Light_class = "Land_LampStreet_small_F";	  
_Light1 = _Light_class createVehicleLocal _pos;	  
_Light1 attachTo [_main_building, [20, 20, -1.6] ];
_Light1 allowDamage false;
_Light2 = _Light_class createVehicleLocal _pos;	  
_Light2 attachTo [_main_building, [20, -20, -1.6] ];
_Light2 allowDamage false;
_Light3 = _Light_class createVehicleLocal _pos;	  
_Light3 attachTo [_main_building, [-20, 20, -1.6] ];
_Light3 allowDamage false;
_Light4 = _Light_class createVehicleLocal _pos;	  
_Light4 attachTo [_main_building, [-20, -20, -1.6] ];
_Light4 allowDamage false;
/*#######################################################################################*/

if (_Armory) then
{
	_Armory_class = "Exile_Sign_Armory";  
	_Armory_direction = 180;  
	_Armory_sign = _Armory_class createVehicleLocal _pos;	  
	_Armory_sign attachTo [_main_building, [1.1, -5.9, -1.6] ];  
	_Armory_sign setDir _Armory_direction;
	if (!isServer) then
	{
		[
			"Exile_Trader_Armory",
			"Exile_Trader_Armory",
			"GreekHead_A3_04",
			["HubStanding_idle1"],
			(_main_building modelToWorld [1.8, -5, -2.87]),
			_general_direction
		] call ExileClient_object_trader_create;
	};
};

if (_Equipment) then
{
	_Equipment_class = "Exile_Sign_Equipment";  
	_Equipment_sign = _Equipment_class createVehicleLocal _pos;
	_Equipment_sign attachTo [_main_building, [-4.3, 11.5, -1.6] ];
	if (!isServer) then
	{
		[
			"Exile_Trader_Equipment",
			"Exile_Trader_Equipment",
			"WhiteHead_19",
			["InBaseMoves_HandsBehindBack1"],
			(_main_building modelToWorld [-4.3, 11, -2.87]),
			(_general_direction-180)
		]call ExileClient_object_trader_create;
	};
};

if (_Food) then
{
	_Food_class = "Exile_Sign_Food";  
	_Food_sign_direction = 180;  
	_Food_sign = _Food_class createVehicleLocal _pos;	  
	_Food_sign attachTo [_main_building, [-3.5, -5.9, -1.6] ];  
	_Food_sign setDir _Food_sign_direction;

	_Food_cashDesk_class = "Land_CashDesk_F";
	_Food_cashDesk = _Food_cashDesk_class createVehicleLocal _pos;	  
	_Food_cashDesk attachTo [_main_building, [-3.5, -4, -3] ];  
	_Food_cashDesk setDir 180;

	_Food_microwave = "Land_Microwave_01_F" createVehicleLocal [0,0,0];
	_Food_cashDesk disableCollisionWith _Food_microwave;	
	_Food_microwave disableCollisionWith _Food_cashDesk;
	_Food_microwave attachTo [_Food_cashDesk, [-0.6, 0.2, 1.1]];

	_ketchup = "Land_Ketchup_01_F" createVehicleLocal [0,0,0];
	_Food_cashDesk disableCollisionWith _ketchup;	
	_ketchup disableCollisionWith _Food_cashDesk;
	_ketchup attachTo [_Food_cashDesk, [-0.6, 0, 1.1]];

	_mustard = "Land_Mustard_01_F" createVehicleLocal [0,0,0];
	_Food_cashDesk disableCollisionWith _mustard;	
	_mustard disableCollisionWith _Food_cashDesk;
	_mustard attachTo [_Food_cashDesk, [-0.5, -0.05, 1.1]];
	if (!isServer) then
	{
		[
			"Exile_Trader_Food",
			"Exile_Trader_Food",
			"GreekHead_A3_01",
			["InBaseMoves_table1"],
			(_Food_cashDesk modelToWorld [0, -0.8, 0.2]),
			_general_direction
		] call ExileClient_object_trader_create;
	};
};

if (_Hardware) then
{
	_Hardware_class = "Exile_Sign_Hardware";
	_Hardware_sign = _Hardware_class createVehicleLocal _pos;
	_Hardware_sign attachTo [_main_building, [3, 11.5, -1.6]];
	if (!isServer) then
	{
		[
			"Exile_Trader_Hardware",
			"Exile_Trader_Hardware",
			"WhiteHead_17",
			["InBaseMoves_HandsBehindBack1"],
			(_main_building modelToWorld [3, 11, -2.87]),
			(_general_direction-180)
		]call ExileClient_object_trader_create;
	};
};

if (_Office) then
{
	_Office_class = "Exile_Sign_Office";
	_Office_sign_direction = 90;
	_Office_sign = _Office_class createVehicleLocal _pos;
	_Office_sign attachTo [_main_building, [17.2, 8, -1.6]];
	_Office_sign setDir _Office_sign_direction;

	_Office_Table_class = "OfficeTable_01_new_f";
	_Office_Table_direction = 270;
	_Office_Table = _Office_Table_class createVehicleLocal _pos;
	_Office_Table attachTo [_main_building, [15, 8, -2.45]];
	_Office_Table setDir _Office_Table_direction;

	if (!isServer) then
	{
		[
			"Exile_Trader_Office",
			"Exile_Trader_Office",
			"GreekHead_A3_04",
			["InBaseMoves_table1"],
			(_Office_Table modelToWorld [0.5, -0.2, -0.4]),
			(_general_direction-90)
		] call ExileClient_object_trader_create;
	};
};

if (_SpecialOperations) then
{
	_SpecialOperations_class = "Exile_Sign_SpecialOperations";
	_SpecialOperations_sign = _SpecialOperations_class createVehicleLocal _pos;
	_SpecialOperations_sign attachTo [_main_building, [-9, 11.5, -1.6]];
	if (!isServer) then
	{
		[
			"Exile_Trader_SpecialOperations",
			"Exile_Trader_SpecialOperations",
			"GreekHead_A3_04",
			["HubStanding_idle1"],
			(_SpecialOperations_sign modelToWorld [0, -1, -1.2]),
			(_general_direction-180)
		] call ExileClient_object_trader_create;
	};
};

if (_Vehicle) then
{
	_Vehicle_addon_class = "Land_cargo_addon01_V2_F";
	_Vehicle_addon_direction = 90;
	_Vehicle_addon = _Vehicle_addon_class createVehicleLocal _pos;
	_Vehicle_addon attachTo [_main_building, [-18.9, 9.8, -1.7]];
	_Vehicle_addon setDir _Vehicle_addon_direction;

	_Vehicle_sign_class = "Exile_Sign_Vehicles";
	_Vehicle_sign_direction = 90;
	_Vehicle_sign = _Vehicle_sign_class createVehicleLocal _pos;
	_Vehicle_sign attachTo [_main_building, [-17.48, 10, -1.6]];
	_Vehicle_sign setDir _Vehicle_sign_direction;

	_Vehicle_chair_class = "Land_CampingChair_V2_F";
	_Vehicle_chair_direction = 90;
	_Vehicle_chair = _Vehicle_chair_class createVehicleLocal _pos;
	_Vehicle_chair attachTo [_main_building, [-18, 10, -2.85]];
	_Vehicle_chair setDir _Vehicle_chair_direction;
	if (!isServer) then
	{
		[
			"Exile_Trader_Vehicle",
			"Exile_Trader_Vehicle",
			"PersianHead_A3_02",
			["InBaseMoves_sitHighUp1"],
			(_Vehicle_chair modelToWorld [0, -0.15, -0.85]),
			(_general_direction-90)
		] call ExileClient_object_trader_create;
	};
};

if (_VehicleCustoms) then
{
	_VehicleCustoms_addon_class = "Land_cargo_addon01_V2_F";
	_VehicleCustoms_addon_direction = 90;
	_VehicleCustoms_addon = _VehicleCustoms_addon_class createVehicleLocal _pos;
	_VehicleCustoms_addon attachTo [_main_building, [-18.87,5.59,-1.7]];
	_VehicleCustoms_addon setDir _VehicleCustoms_addon_direction;

	_VehicleCustoms_sign_class = "Exile_Sign_VehicleCustoms";
	_VehicleCustoms_sign_direction = 90;
	_VehicleCustoms_sign = _VehicleCustoms_sign_class createVehicleLocal _pos;
	_VehicleCustoms_sign attachTo [_main_building, [-17.48,5.89,-1.6]];
	_VehicleCustoms_sign setDir _VehicleCustoms_sign_direction;

	_VehicleCustoms_chair_class = "Land_CampingChair_V2_F";
	_VehicleCustoms_chair_direction = 90;
	_VehicleCustoms_chair = _VehicleCustoms_chair_class createVehicleLocal _pos;
	_VehicleCustoms_chair attachTo [_main_building, [-17.9,5.89,-2.85]];
	_VehicleCustoms_chair setDir _VehicleCustoms_chair_direction;
	if (!isServer) then
	{
		[
			"Exile_Trader_VehicleCustoms",
			"Exile_Trader_VehicleCustoms",
			"PersianHead_A3_02",
			["InBaseMoves_sitHighUp1"],
			(_VehicleCustoms_chair modelToWorld [0, -0.15, -0.85]),
			(_general_direction-90)
		] call ExileClient_object_trader_create;
	};
};

if (_WasteDump) then
{   
	_WasteDump_sign_class = "Exile_Sign_WasteDump";
	_WasteDump_sign_direction = 0;
	_WasteDump_sign = _WasteDump_sign_class createVehicleLocal _pos;
	_WasteDump_sign attachTo [_main_building, [-15, -6.2, -1.6]];
	_WasteDump_sign setDir _WasteDump_sign_direction;
	   
	_WasteDump_prop1_class = "Land_GarbageContainer_closed_f";
	_WasteDump_prop1_direction = 0;
	_WasteDump_prop1 = _WasteDump_prop1_class createVehicleLocal _pos;
	_WasteDump_prop1 attachTo [_main_building, [-15, -7, -2.6]];
	_WasteDump_prop1 setDir _WasteDump_prop1_direction;

	_WasteDump_prop2_class = "Land_GarbageContainer_open_f";
	_WasteDump_prop2 = _WasteDump_prop2_class createVehicleLocal _pos;
	_WasteDump_prop2 attachTo [_main_building, [-13, -7, -2.6]];
	if (!isServer) then
	{
		[
			"Exile_Trader_WasteDump",
			"Exile_Trader_WasteDump",
			"GreekHead_A3_02",
			["InBaseMoves_sitHighUp1"],
			(_WasteDump_prop1 modelToWorld [0, -0.34, -0.18]),
			(_general_direction-180)
		] call ExileClient_object_trader_create;
	};
};

if (_Aircraft) then
{
	_Aircraft_class = "Exile_Sign_Aircraft";
	_Aircraft_sign = _Aircraft_class createVehicleLocal _pos;
	_Aircraft_sign attachTo [_main_building, [-9, -10, -2]];
	_Aircraft_sign setDir 0;
	detach _Aircraft_sign;
	_Aircraft_sign setPos (getpos _Aircraft_sign);

	if (!isServer) then
	{
		[
			"Exile_Trader_Aircraft",
			"Exile_Trader_Aircraft",
			"WhiteHead_17",
			["HubStandingUA_idle2"],
			(_Aircraft_sign modelToWorldVisual  [0, -1, -1.4]),
			(_general_direction+180)
		] call ExileClient_object_trader_create;
	};
};

if (_AircraftCustoms) then
{
	_AircraftCustoms_class = "Exile_Sign_AircraftCustoms";
	_AircraftCustoms_sign = _AircraftCustoms_class createVehicleLocal _pos;
	_AircraftCustoms_sign attachTo [_main_building, [-3.5, -10, -2]];
	_AircraftCustoms_sign setDir 0;
	detach _AircraftCustoms_sign;
	_AircraftCustoms_sign setPos (getpos _AircraftCustoms_sign);

	if (!isServer) then
	{
		[
			"Exile_Trader_AircraftCustoms",
			"Exile_Trader_AircraftCustoms",
			"GreekHead_A3_07",
			["HubStandingUC_idle1"],
			(_AircraftCustoms_sign modelToWorldVisual  [0, -1, -1.4]),
			(_general_direction+180)
		] call ExileClient_object_trader_create;
	};
};