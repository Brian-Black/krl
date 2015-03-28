ruleset song_store {
	meta {
		name "store"
		description <<
			Do you play Hearthstone? I CAN'T STOP TALKING ABOUT IT!
		>>
		author "Brian The Man Black"
		logging on
	}

	rule collect_songs is active {
		select when explicit sung input "(.*)" setting(m) 
		pre {
			songs = ent:played_songs || [];
			new_array = songs.union(m)
		}
		always {
			set ent:played_songs new_array if (not music.has(m))
		}

	}

}