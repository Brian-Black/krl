ruleset echo {
	meta {
		name "echo"
		description <<
			Doing a lab late
		>>
		author "Brian The Man Black"
		logging on
	}

	rule hello is active {
		select when echo hello
		send_directive("say") with 
			something = "Hello World";
	}

	rule message is active {x
		select when echo message input "(.*)" setting(m)
		send_directive("say") with
			something = m;
	}
}