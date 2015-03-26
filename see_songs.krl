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
		select when echo message input "(song)" setting(m)
		send_directive("sing") with
			song = m;
	}	
}


