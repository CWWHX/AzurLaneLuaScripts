return {
	id = "HAIDAOSUIJI10-1",
	mode = 2,
	scripts = {
		{
			side = 2,
			nameColor = "#A9F548FF",
			say = "You take out an apple you picked in the forest and give it to the little fox.",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			side = 2,
			nameColor = "#A9F548FF",
			say = "It promptly wolves down on it, and when it's finished, the fox looks up at you with eyes that seem to yearn for more.",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			},
			options = {
				{
					content = "Give it an apple.",
					flag = 1
				},
				{
					content = "Do nothing.",
					flag = 0
				}
			}
		}
	}
}
