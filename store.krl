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
		select when explicit sung 
		pre {
			lastSong = { time:now() : event:attr("song") };
			songs = lastSong.put(ent:songs);
		}
		if(lastSong.match(re#.+#)) then {
			noop();
		}
		fired {
			set ent:songs songs;
		}

	}


	rule collect_hymns is active {
		select when explicit found_hymn 
		pre {
			newHymn = event:attr("hymn");
			hymns = newHymn.put(ent:hymns);
		}
		if (m.match(re#.+#)) then {
			noop();
		}
		fired {
			set ent:hymns hymns;
			raise explicit event sung
			with song = m;
		}

	}
}