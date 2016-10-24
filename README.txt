# cod-fx

Plugins and scripts for call of duty 1 servers glitch fix.

---------------------------------------------------------------------------
### _map_fix.pk3
 Original Harbor and Logging Mill maps fix For Call Of Duty 1 all patches
 put _map_fix.pk3 in main folder
 
 FOR CODAM 
 in the codam\modlist.gsc file
 [[ register ]]( "Harbor Map Fix", codam\_map_fix::main); 
 
 In another mod. Add in gametype(dm,sd,...etc.) main function before last } 
  thread codam\_map_fix.gsc::main();
---------------------------------------------------------------------------

Support: 
skype -> larooca2012
email -> la.rocca@yandex.com
