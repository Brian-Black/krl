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
			m = event:attr("song");
			songs = ent:played_songs || [];
			new_array = songs.union(m).klog("value after song: ").head();
		}
		always {
			set ent:played_songs new_array if (not music.has(m))
		}

	}


	rule collect_hymns is active {
		select when explicit found_hymn 
		pre {
			m = event:attr("hymn");
			hymns = ent:played_hymns || [];
			new_array = hymns.union(m);
		}
		if (m.match(re#.+#)) then {
			noop();
		}
		fired {
			set ent:played_hymns new_array if (not music.has(m));
			raise explicit event sung
			with song = m;
		}

	}
}