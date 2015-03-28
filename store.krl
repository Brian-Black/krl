ruleset song_store {
	meta {
		name "see_songs"
		description <<
			Do you play Hearthstone? I CAN'T STOP TALKING ABOUT IT!
		>>
		author "Brian The Man Black"
		logging on
	}

	rule collect_songs is active {
		select when explicit sung "(.*)" setting (song)
		pre {
			songs = ent:played_songs || [];
			new_array = songs.union(song)
		}
		always {
			set ent:played_songs new_array if (not music.has(song))
		}

	}

}