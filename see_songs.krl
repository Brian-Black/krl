ruleset see_songs {
	meta {
		name "see_songs"
		description <<
			Doing a singing lab late
		>>
		author "Brian The Man Black"
		logging on
	}

	rule songs is active {
		select when explicit sung input "(.*)" setting(m) 
		if event:attr("msg_type").match("song") then {
			send_directive("sing") with
				song = m;
		}
	}	

	rule find_hymn is active {
		select when explicit sung 
		pre {
			song = event:attr("song");
		}
		if (song.match(re#.*god.*#)) then {
			noop();
		}
		fired {	
			raise explicit event hymn_found
			with hymn = song;
		}
	}
}


