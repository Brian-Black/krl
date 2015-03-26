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
		select when echo message 
		if (msg_type:song) then {
			send_directive("sing") with
				song = "song";
		}
	}	
}


