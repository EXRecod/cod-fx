///  Developed thecheeseman, rework & update by LAROCCA
///  Original Harbor and Logging Mill maps fix For Call Of Duty 1 all patches
///  FOR CODAM 
///    in the codam\modlist.gsc file
///    [[ register ]]( "Harbor Map Fix", codam\_map_fix::main); 

///  In another mod. Add in gametype(dm,sd,...etc.) main funtion before last } 
/// thread maps\mp\gametypes\_map_fix.gsc::main();   

 
main()
{
c_scan = 0;	
if ( getCvar( "mapname" ) == "mp_harbor" )
{
        thread harbor_fixes2();
	    thread harbor_fixes();
      //thread harbor_fire();			
}

		
if ( getCvar( "mapname" ) == "mp_logging_mill" )
{
        
		thread logging_fixes();	
}		


if ( getCvar( "mapname" ) == "^5abbey" )
        thread abbey_fixes();

		
	mapname = toLower( getCvar( "mapname" ) );
	switch ( mapname )
	{
		case "mp_harbor":
			thread scanner( -115 );	
			break;
		case "quarantine":
			thread scanner( -127 );
			break;
		case "alcatraz":
			thread scanner( -207 );
			break;
		case "mp_logging_mill":
			thread scannerteleport( -100 );
			break;	
		   	
	}
}

scanner( z )
{
	level endon( "intermission" );
	
	if (self.sessionstate != "playing")
		return;
		
	while ( 1 )
	{
		players = getEntArray( "player", "classname" );
		for ( i = 0; i < players.size; i++ )
		{
			//if ( players[ i ].sessionstate == "playing" )
			//	continue;
				
			myorg = players[ i ] getOrigin();
			if ( myorg[ 2 ] <= z )
			{
				players[ i ] suicide();
				iPrintLn( players[ i ].name + "^7 Was killed for being a shark." );
			}
		}
		
		wait 0.05;
	}
}



scannerteleport( z )
{
	level endon( "intermission" );
	
	if (self.sessionstate != "playing")
		return;
		
	while ( 1 )
	{
		players = getEntArray( "player", "classname" );
		for ( i = 0; i < players.size; i++ )
		{
			//if ( players[ i ].sessionstate == "playing" )
			//	continue;
				
			myorg = players[ i ] getOrigin();
			if ( myorg[ 2 ] <= z )
			{
				
				players[ i ] teleportx();
				
				iPrintLn( players[ i ].name + "^7 Out of glitching." );
			}
		}
		
		wait 0.05;
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


teleportx()
{
   	if (self.sessionstate != "playing")
		return;
	  wait 0.1;
	spawnpointname = "mp_deathmatch_spawn";
	spawnpoints = getentarray( spawnpointname, "classname");
	num = randomInt( spawnpoints.size );
	self.teleportermodel = spawn( "script_model", self.origin );
	self.god = true;
	self setOrigin( spawnpoints[num].origin );
	self.teleportermodel delete();
	  wait 0.1;
	self.god = false;	
}

harbor_fire()
{
	locs = [];
    locs[ 0 ] = ( -9211, -7895, 226 );
    locs[ 1 ] = ( -7236, -9126, 0 );
    
    for ( i = 0; i < locs.size; i++ )
        thread spawn_tl_trigger( locs[ i ], 56, 512 );		
}

firer()
{


if( c_scan == 0)
        {
    self tlrt();
   c_scan = 1;	    
		}		
}

tlrt()
{
   	
	
	if (self.sessionstate != "playing")
		return;
	
	self.burnedout = false;
	self thread burn_gg();
	while(self.burnedout == false)
	{			
		playfx(level.rrs_admin_burnedfx, self.origin);
		wait .1;	
	}
		
	return;	
}


burn_gg()
{
	self playsound("smallfire");
	wait 5;
	self playsound("smallfire");
	wait 10;
	self suicide();
	self.burnedout = true;
	return;
}

spawn_tl_trigger( origin, maxdist, height )
{
    level endon( "intermission" );
    
    while ( 1 )
    {
        players = getEntArray( "player", "classname" );
        for ( i = 0; i < players.size; i++ )
        {
            
			//if ( players[ i ].sessionstate != "playing" )
			//	return;
			
			plyorg = ( players[ i ].origin[ 0 ], players[ i ].origin[ 1 ], 0 );
            org = ( origin[ 0 ], origin[ 1 ], 0 );
            dist = distance( plyorg, org );
            
            if ( dist < maxdist )
            {
                plyht = players[ i ].origin[ 2 ];
                orght = origin[ 2 ];
                
                if ( plyht >= orght && ( plyht <= orght + height ) )
                    players[ i ] firer();
            }
            wait 0.05;
        }
        
        wait 0.1;
    }
}
///////////////////////////////////////////////////////////////////////////////////
kill_for_glitching()
{
if( c_scan == 0)
        {
		
	if (self.sessionstate != "playing")
		return;		
		
    self iPrintLnBold( "Glitching is ^1NOT^7 allowed!" );
    iPrintLn( self.name + "^7 Was killed for glitching!" );
    self suicide();
   c_scan = 1;	    
		}		
}




kill_for_glitching1()
{
if( c_scan == 0)
        {
 
	 stance = self aweGetStance(true);
	 if(self aweGetStance(true) != "2")
		 return;
		 
	 if (self.sessionstate != "playing")
		return;			

	   self blackbox();

	   c_scan = 1;	    
		}		
}


blackbox()
{

	self notify( "blackbox" );
	self endon( "blackbox" );
	self endon( "disconnect" );	
	self.boxxx destroy();

    self iprintlnbold("^1Glitch Detected ^2(^3(c) ^1recod.ru)");	
	
    self.boxxx = newClientHudElem( self );
	self.boxxx.x = 0;
	self.boxxx.y = 0;
    self.boxxx setShader( "black", 640, 480 );   
	self.boxxx.fontscale = 2;
	self.boxxx.alpha = 1;
	self.boxxx.archived = false;			
	self.boxxx fadeOverTime(1);
	
	wait 1.5;
	
	if(isdefined(self.boxxx))
	self.boxxx destroy();

}


harbor_fixes()
{
	locs = [];
    locs[ 0 ] = ( -10064, -8613, 160 );
    locs[ 1 ] = ( -11821, -7503, 160 );
    locs[ 2 ] = ( -11853, -7976, 160 );
    
    for ( i = 0; i < locs.size; i++ )
        thread spawn_kill_trigger( locs[ i ], 56, 512 );
}



harbor_fixes2()
{
    
	
	lox = [];
    lox[ 0 ] = ( -8742, -8498, 204 );
    lox[ 1 ] = ( -8760, -8499, 198 );
    lox[ 2 ] = ( -8720, -8495, 204 );
    lox[ 3 ] = ( -8700, -8497, 204 );
	lox[ 4 ] = ( -8710, -8497, 198 );
	lox[ 5 ] = ( -9262, -8178, 200 );
    lox[ 6 ] = ( -9234, -8177, 200 );

	for ( i = 0; i < lox.size; i++ )
	thread spawn_kill_trigger1( lox[ i ], 56, 512 );
	
}

logging_fixes()
{
    locs = [];
    locs[ 0 ] = ( 1208, -385, 134 );
    locs[ 1 ] = ( -119, 568, 144 );
    locs[ 2 ] = ( -90, -546, 128 );
    locs[ 3 ] = ( 2763, -327, 0 );
	locs[ 4 ] = ( 2794, -188, 0 );
	locs[ 5 ] = ( 2055, -688, 0 );
	locs[ 6 ] = ( 2371, -736, 0 );
	locs[ 7 ] = ( 2626, -699, 0 );
	
    for ( i = 0; i < locs.size; i++ )
        thread spawn_kill_trigger( locs[ i ], 56, 512 );
}

abbey_fixes()
{
    locs = [];
    locs[ 0 ] = ( 1634, -8804, 183 );
    locs[ 1 ] = ( -2322, -6553, 21 );
    locs[ 2 ] = ( -2273, -6817, 22 );
	locs[ 3 ] = ( 1787, -9084, 135 );
	locs[ 4 ] = ( 1832, -9080, 136 );
	locs[ 5 ] = ( 1766, -8995, 136 );
	locs[ 6 ] = ( 1748, -8871, 208 );
	
    for ( i = 0; i < locs.size; i++ )
        thread spawn_kill_trigger( locs[ i ], 56, 512 );
}

spawn_kill_trigger( origin, maxdist, height )
{
    level endon( "intermission" );
   


///////self iprintlnbold("You found a healthpack.");

   
    while ( 1 )
    {
        players = getEntArray( "player", "classname" );
        for ( i = 0; i < players.size; i++ )
        {
           
     //if ( players[ i ].sessionstate != "playing" )
	//			return;
				
		   plyorg = ( players[ i ].origin[ 0 ], players[ i ].origin[ 1 ], 0 );
            org = ( origin[ 0 ], origin[ 1 ], 0 );
            dist = distance( plyorg, org );
            
            if ( dist < maxdist )
            {
                plyht = players[ i ].origin[ 2 ];
                orght = origin[ 2 ];
                
                if ( plyht >= orght && ( plyht <= orght + height ) )
                    players[ i ] kill_for_glitching();
            }
            wait 0.05;
        }
        
        wait 0.1;
    }
}





spawn_kill_trigger1( origin, maxdist, height )
{
    level endon( "intermission" );
   
    while ( 1 )
    {
        players = getEntArray( "player", "classname" );
        for ( i = 0; i < players.size; i++ )
        {
           
     //if ( players[ i ].sessionstate != "playing" )
	//			return;
				
		   plyorg = ( players[ i ].origin[ 0 ], players[ i ].origin[ 1 ], 0 );
            org = ( origin[ 0 ], origin[ 1 ], 0 );
            dist = distance( plyorg, org );
            
            if ( dist < maxdist )
            {
                plyht = players[ i ].origin[ 2 ];
                orght = origin[ 2 ];
                
                if ( plyht >= orght && ( plyht <= orght + height ) )
                    players[ i ] kill_for_glitching1();
            }
            wait 0.05;
        }
        
        wait 0.1;
    }
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


add_block( modelName, origin, clipAmount, clipAdd )
{
	model = spawn( "script_model", origin );
	model setModel( modelName );
	model setContents( 1 );
	model hide();
	
	cur = clipAdd;
	
	for ( i = 0; i < clipAmount; i++ )
	{
		clip = spawn( "script_model", origin );
		clip.origin += ( 0, 0, cur );
		cur += clipAdd;
		clip setModel( modelName );
		clip setContents( 1 );
		clip hide();
	}
}




toLower( str )
{
	return ( mapChar( str, "U-L" ) );
}

toUpper( str )
{
	return ( mapChar( str, "L-U" ) );
}

mapChar( str, conv )
{
	if ( !isdefined( str ) || ( str == "" ) )
		return ( "" );

	switch ( conv )
	{
	  case "U-L":	case "U-l":	case "u-L":	case "u-l":
		from = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		to   = "abcdefghijklmnopqrstuvwxyz";
		break;
	  case "L-U":	case "L-u":	case "l-U":	case "l-u":
		from = "abcdefghijklmnopqrstuvwxyz";
		to   = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		break;
	  default:
	  	return ( str );
	}

	s = "";
	for ( i = 0; i < str.size; i++ )
	{
		ch = str[ i ];

		for ( j = 0; j < from.size; j++ )
			if ( ch == from[ j ] )
			{
				ch = to[ j ];
				break;
			}

		s += ch;
	}

	return ( s );
}

monotone( str )
{
	if ( !isdefined( str ) || ( str == "" ) )
		return ( "" );

	_s = "";

	_colorCheck = false;
	for ( i = 0; i < str.size; i++ )
	{
		ch = str[ i ];
		if ( _colorCheck )
		{
			_colorCheck = false;

			switch ( ch )
			{
			  case "0":
			  case "1":
			  case "2":
			  case "3":
			  case "4":
			  case "5":
			  case "6":
			  case "7":
			  	break;
			  default:
			  	_s += ( "^" + ch );
			  	break;
			}
		}
		else
		if ( ch == "^" )
			_colorCheck = true;
		else
			_s += ch;
	}

	return ( _s );
}

cleanString( str, ignorespaces )
{
	if ( !isDefined( str ) || str == "" )
		return "";
		
	newstr = "";
	
	for ( i = 0; i < str.size; i++ )
	{
		ch = str[ i ];
		
		if ( isDefined( ignorespaces ) && ignorespaces && ch == " " )
			continue;
			
		if ( !isDigit( ch ) && !isChar( ch ) && !isSymbol( ch ) && ch != " " )
			continue;
			
		newstr += ch;
	}

	return newstr;
}
isChar( cChar )
{
	bIsChar = false;
	
	switch ( toLower( cChar ) )
	{
		case "a":	case "b":	case "c":
		case "d":	case "e":	case "f":
		case "g":	case "h":	case "i":
		case "j":	case "k":	case "l":
		case "m":	case "n":	case "o":
		case "p":	case "q":	case "r":
		case "s":	case "t":	case "u":
		case "v":	case "w":	case "x":
		case "y":	case "z":
			bIsChar = true;
			break;
		default:
			break;
	}
	
	return bIsChar;
}

isDigit( cDigit )
{
	bIsDigit = false;
	switch ( cDigit )
	{
		case "0":	case "1":	case "2":
		case "3":	case "4": 	case "5":
		case "6": 	case "7": 	case "8":
		case "9":
			bIsDigit = true;
			break;
		default:
			break;
	}
	
	return bIsDigit;
}

isSymbol( cChar )
{
	bIsSymbol = false;
	switch ( cChar )
	{
		case "-":	case ">":	case "<":
		case "(":	case ")":	case "!":
		case "@":	case "#":	case "$":
		case "%":	case "&":	case "*":
		case "[":	case "]":	case "{":
		case "}":	case ":":	case ".":
		case "?":	case "^":	case "+":
		case "/":	case "~":	case "`":
		case ";":	
			bIsSymbol = true;
			break;
		default:
			break;
	}
	
	return bIsSymbol;
}

explode( s, delimiter )
{
	j = 0;
	temparr[ j ] = "";	

	for ( i = 0; i < s.size; i++ )
	{
		if ( s[ i ] == delimiter )
		{
			j++;
			temparr[ j ] = "";
		}
		else
			temparr[ j ] += s[i];
	}
	return temparr;
}

getNumberedName( str, ignorespaces )
{/*
	if ( !isDefined( sString ) || sString == "" )
		return "";
		
	iNumber = 0;
	iColors = 0;
	iSymbols = 0;
	iSpaces = 0;
	
	for ( i = 0; i < sString.size; i++ )
	{
		cChar = sString[ i ];
			
		if ( !isDigit( cChar ) && !isChar( cChar ) && !isSymbol( cChar ) && cChar != " " )
			continue;
			
		if ( cChar == "^" )
			iColors++;
			
		if ( isSymbol( cChar ) && cChar != "^" )
			iSymbols++;
			
		if ( cChar == " " )
			iSpaces++;
			
		iNumber += charToDigit( cChar );
	}
	
	if ( sString.size % 2 == 0 )
		iNumber += sString.size;
	else
		iNumber -= sString.size;
		
	iNumber += ( iColors * 7 );
	iNumber += ( iSymbols * 29 );
	iNumber += ( iSpaces * 42 );
	
	return iNumber;*/
	if ( !isDefined( str ) || str == "" )
		return "";
		
	int = 0;
	colors = 0;
	symbols = 0;
	
	for ( i = 0; i < str.size; i++ )
	{
		ch = str[ i ];
		
		if ( isDefined( ignorespaces ) && ignorespaces && ch == " " )
			continue;
			
		if ( !isDigit( ch ) && !isChar( ch ) && !isSymbol( ch ) )
			continue;
			
		if ( ch == "^" )
			colors++;
			
		if ( isSymbol( ch ) && ch != "^" )
			symbols++;
			
		int += charToDigit( ch );
	}
	
	if ( str.size % 2 == 0 )
		int += str.size;
	else
		int -= str.size;
		
	int += ( colors * 10 );
	int += ( symbols * 30 );
	
	return int;
}

charToDigit( ch )
{/*
	switch ( cChar )
	{
		case "0":	return 26; break;	case "1":	return 27; break;
		case "2":	return 28; break;	case "3":	return 29; break;
		case "4":	return 30; break;	case "5":	return 31; break;
		case "6":	return 32; break;	case "7":	return 33; break;
		case "8":	return 34; break;	case "9":	return 35; break;
		case "a":	return 100; break;	case "b":	return 101; break;
		case "c":	return 102; break;	case "d":	return 103; break;
		case "e":	return 104; break;	case "f":	return 105; break;
		case "g":	return 106; break;	case "h":	return 107; break;
		case "i":	return 108; break;	case "j":	return 109; break;
		case "k":	return 110; break;	case "l":	return 111; break;
		case "m":	return 112; break;	case "n":	return 113; break;
		case "o":	return 114; break;	case "p":	return 115; break;
		case "q":	return 116; break;	case "r":	return 117; break;
		case "s":	return 118; break;	case "t":	return 119; break;
		case "u":	return 120; break;	case "v":	return 121; break;
		case "w":	return 122; break;	case "x":	return 123; break;
		case "y":	return 124; break;	case "z":	return 125; break;
		case "A":	return 256; break;	case "B":	return 256; break;
		case "C":	return 257; break;	case "D":	return 258; break;
		case "E":	return 259; break;	case "F": 	return 260; break;
		case "G":	return 261; break;	case "H":	return 262; break;
		case "I":	return 263; break;	case "J":	return 264; break;
		case "K":	return 265; break;	case "L":	return 266; break;
		case "M":	return 267; break;	case "N":	return 268; break;
		case "O":	return 269; break;	case "P":	return 270; break;
		case "Q":	return 271; break;	case "R":	return 272; break;
		case "S":	return 273; break;	case "T":	return 274; break;
		case "U":	return 275; break;	case "V":	return 276; break;
		case "W":	return 277; break;	case "X":	return 278; break;
		case "Y":	return 279; break;	case "Z":	return 280; break;
		case "/":	return 281; break; 	case "+":	return 282; break;
		case "~":	return 282; break;	case "`":	return 283; break;
		case "-":	return 336; break; 	case ">":	return 337; break;
		case "<":	return 338; break; 	case "(":	return 339; break; 	
		case ")":	return 340; break; 	case "!":	return 341; break; 	
		case "@":	return 342; break; 	case "#":	return 343; break; 	
		case "$":	return 344; break; 	case "%":	return 345; break; 	
		case "&":	return 346; break; 	case "*":	return 347; break; 	
		case "[":	return 348; break; 	case "]":	return 349; break; 	
		case "{":	return 350; break; 	case "}":	return 351; break; 	
		case ":":	return 352; break; 	case ".":	return 353; break; 	
		case "?":	return 354; break; 	case "^":	return 355; break;
	}*/
	switch ( ch )
	{
		case "a":	return 100; break;	case "b":	return 101; break;
		case "c":	return 102; break;	case "d":	return 103; break;
		case "e":	return 104; break;	case "f":	return 105; break;
		case "g":	return 106; break;	case "h":	return 107; break;
		case "i":	return 108; break;	case "j":	return 109; break;
		case "k":	return 110; break;	case "l":	return 111; break;
		case "m":	return 112; break;	case "n":	return 113; break;
		case "o":	return 114; break;	case "p":	return 115; break;
		case "q":	return 116; break;	case "r":	return 117; break;
		case "s":	return 118; break;	case "t":	return 119; break;
		case "u":	return 120; break;	case "v":	return 121; break;
		case "w":	return 122; break;	case "x":	return 123; break;
		case "y":	return 124; break;	case "z":	return 125; break;
		case "0":	return 126; break;	case "1":	return 127; break;
		case "2":	return 128; break;	case "3":	return 129; break;
		case "4":	return 130; break;	case "5":	return 131; break;
		case "6":	return 132; break;	case "7":	return 133; break;
		case "8":	return 134; break;	case "9":	return 135; break;
		case "-":	return 136; break; 	case ">":	return 137; break;
		case "<":	return 138; break; 	case "(":	return 139; break; 	
		case ")":	return 140; break; 	case "!":	return 141; break; 	
		case "@":	return 142; break; 	case "#":	return 143; break; 	
		case "$":	return 144; break; 	case "%":	return 145; break; 	
		case "&":	return 146; break; 	case "*":	return 147; break; 	
		case "[":	return 148; break; 	case "]":	return 149; break; 	
		case "{":	return 150; break; 	case "}":	return 151; break; 	
		case ":":	return 152; break; 	case ".":	return 153; break; 	
		case "?":	return 154; break; 	case "^":	return 155; break;
		case "A":	return 156; break;	case "B":	return 156; break;
		case "C":	return 157; break;	case "D":	return 158; break;
		case "E":	return 159; break;	case "F": 	return 160; break;
		case "G":	return 161; break;	case "H":	return 162; break;
		case "I":	return 163; break;	case "J":	return 164; break;
		case "K":	return 165; break;	case "L":	return 166; break;
		case "M":	return 167; break;	case "N":	return 168; break;
		case "O":	return 169; break;	case "P":	return 170; break;
		case "Q":	return 171; break;	case "R":	return 172; break;
		case "S":	return 173; break;	case "T":	return 174; break;
		case "U":	return 175; break;	case "V":	return 176; break;
		case "W":	return 177; break;	case "X":	return 178; break;
		case "Y":	return 179; break;	case "Z":	return 180; break;
		case "/":	return 181; break; 	case "+":	return 182; break;
		case "~":	return 182; break;	case "`":	return 183; break;
	}
}

playSoundInSpace( sAlias, vOrigin, iTime )
{
	oOrg = spawn( "script_model", vOrigin );
	wait 0.05;
	oOrg playSound( sAlias );
	
	wait ( iTime );
	
	oOrg delete();
}







//Method to determine a player's current stance
aweGetStance(checkjump)
{
	if( checkjump && !self isOnGround() ) 
		return 3;

	if(isdefined(self.awe_spinemarker))
	{
		distance = self.awe_spinemarker.origin[2] - self.origin[2];
		if(distance<18)
			return 2;
		else if(distance<39)
			return 1;
		else
			return 0;
	}
	else
	{
		trace = bulletTrace( self.origin, self.origin + ( 0, 0, 80 ), false, undefined );
		top = trace["position"] + ( 0, 0, -1);//find the ceiling, if it's lower than 80

		bottom = self.origin + ( 0, 0, -12 );
		forwardangle = maps\mp\_utility::vectorScale( anglesToForward( self.angles ), 12 );

		leftangle = ( -1 * forwardangle[1], forwardangle[0], 0 );//a lateral vector

		//now do traces at different sample points
		//there are 9 sample points, forming a 3x3 grid centered on player's origin
		//and oriented with the player's facing
		trace = bulletTrace( top + forwardangle,bottom + forwardangle, true, undefined );
		height1 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top - forwardangle, bottom - forwardangle, true, undefined );
		height2 = trace["position"][2] - self.origin[2];
	
		trace = bulletTrace( top + leftangle, bottom + leftangle, true, undefined );
		height3 = trace["position"][2] - self.origin[2];
	
		trace = bulletTrace( top - leftangle, bottom - leftangle, true, undefined );
		height4 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top + leftangle + forwardangle, bottom + leftangle + forwardangle, true, undefined );
		height5 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top - leftangle + forwardangle, bottom - leftangle + forwardangle, true, undefined );
		height6 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top + leftangle - forwardangle, bottom + leftangle - forwardangle, true, undefined );
		height7 = trace["position"][2] - self.origin[2];	

		trace = bulletTrace( top - leftangle - forwardangle, bottom - leftangle - forwardangle, true, undefined );
		height8 = trace["position"][2] - self.origin[2];

		trace = bulletTrace( top, bottom, true, undefined );
		height9 = trace["position"][2] - self.origin[2];	

		//find the maximum of the height samples
		heighta = getMax( height1, height2, height3, height4 );
		heightb = getMax( height5, height6, height7, height8 );
		maxheight = getMax( heighta, heightb, height9, 0 );

		//categorize stance based on height
		if( maxheight < 25 )
			stance = 2;
		else if( maxheight < 52 )
			stance = 1;
		else
			stance = 0;

		//self iprintln("Height: "+maxheight+" Stance: "+stance);
		return stance;
	}
}

//Method that returns the maximum of a, b, c, and d
getMax( a, b, c, d )
{
	if( a > b )
		ab = a;
	else
		ab = b;
	if( c > d )
		cd = c;
	else
		cd = d;
	if( ab > cd )
		m = ab;
	else
		m = cd;
	return m;
}