ruleset song_store {
	meta {
		name "store"
		description <<
			Do you play Hearthstone? I CAN'T STOP TALKING ABOUT IT!
		>>
		author "Brian The Man Black"
		logging on
		sharing on
		provides songs, hymns, secular_music
	}

	global {
		songs = function() {
			ent:playedSongs;
		};

		hymns = function() {
			ent:playedHymns;
		};

		secular_music = function() {
			ent:playedSongs.difference(ent:playedHymns);
		};
	}

	rule collect_songs is active {
		select when explicit sung 
		pre {
			lastSong = {time:now() : event:attr("song")};
			playedSongs = lastSong.put(ent:playedSongs);
		}
		if(lastSong.match(re#.+#)) then {
			noop();
		}
		fired {
			set ent:playedSongs playedSongs;
		}

	}


	rule collect_hymns is active {
		select when explicit found_hymn 
		pre {
			newHymn = event:attr("hymn");
			playedHymns = newHymn.put(ent:playedHymns);
		}
		if (m.match(re#.+#)) then {
			noop();
		}
		fired {
			set ent:playedHymns playedHymns;
			raise explicit event sung
			with song = m;
		}

	}

	rule clear_songs is active {
		select when song reset
		always {
			clear ent:hymns;
			clear ent:playedSongs;
		}
	}
}