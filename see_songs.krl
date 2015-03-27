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
		if event:attr("msg_type").match("song") then {
			send_directive("sing") with
				song = "song";
		}
	}	
}


