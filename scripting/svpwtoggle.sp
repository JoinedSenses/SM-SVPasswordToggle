#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>

#define PLUGIN_NAME "Server Password Toggle"
#define PLUGIN_AUTHOR "JoinedSenses"
#define PLUGIN_DESCRIPTION "Toggles Server Password - lasting through map changes"
#define PLUGIN_VERSION "0.1.0"
#define PLUGIN_URL "https://alliedmods.net"

char g_pw[32];
ConVar g_cvpw;

public Plugin myinfo = {
	name = PLUGIN_NAME,
	author = PLUGIN_AUTHOR,
	description = PLUGIN_DESCRIPTION,
	version = PLUGIN_VERSION,
	url = PLUGIN_URL
}

public void OnPluginStart() {
	CreateConVar(
		"sm_rconpasswordtoggle_version",
		PLUGIN_VERSION,
		PLUGIN_DESCRIPTION,
		FCVAR_SPONLY|FCVAR_NOTIFY|FCVAR_DONTRECORD
	).SetString(PLUGIN_VERSION);

	g_cvpw = FindConVar("sv_password");

	RegAdminCmd("sm_svpw", cmdSVPW, ADMFLAG_ROOT);
}

public Action cmdSVPW(int client, int args) {
	GetCmdArg(1, g_pw, sizeof(g_pw));

	g_cvpw.SetString(g_pw);

	return Plugin_Handled;
}

public void OnConfigsExecuted() {
	if (g_pw[0]) {
		g_cvpw.SetString(g_pw);
	}
}