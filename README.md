# Call of the Zone

I cant provide support with this at the moment, but feel free to snatch plugins or try to set it up yourself if you want to, as long as you give credit to whoever owns the plugins. Code is spaghetti, will be cleaned up eventually.

Always start in p2p mode when developing alone even. Singleplayer can be buggy.

## Setup

### MYSQL Database
First setup a mysql database, and use the [mySQLOO](https://github.com/FredyH/MySQLOO) driver. Not all features will work with the default sqlite database that helix uses, especially if you want support for multiple servers.

## First Time Setup
by default, run the first time setup command (/FTSRunFirstTimeSetup) on rp_marsh_cs. It will populate the map with cyclic containers, npcs, and all the default spawn points.

## Multi-server configuration
If you are planing on running multiple servers, check out the simplecrossserver plugin. Here you are also able to change the default map, as well as server IP's.