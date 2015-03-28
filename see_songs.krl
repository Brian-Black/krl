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
			s = event:attr("song");
		}
		if (s.match(re#i.*god.*#)) then {
			noop();
		}
		fired {	
			raise explicit event found_hymn
			with hymn = s;
		}
	}
}


