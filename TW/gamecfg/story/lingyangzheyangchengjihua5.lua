return {
	defaultTb = 2001,
	mode = 2,
	fadeOut = 1.5,
	id = "LINGYANGZHEYANGCHENGJIHUA5",
	placeholder = {
		"tb"
	},
	scripts = {
		{
			expression = 7,
			side = 2,
			nameColor = "#A9F548FF",
			bgName = "bg_project_oceana_room1",
			bgm = "qe-ova-2",
			tbActor = true,
			actor = 2001,
			actorName = "娜比娅",
			hidePaintObj = true,
			say = "哦~原来如此，想让我用{tb}这个称呼叫你啊。",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			},
			flashout = {
				dur = 1,
				black = true,
				alpha = {
					0,
					1
				}
			},
			flashin = {
				dur = 1,
				black = true,
				delay = 1,
				alpha = {
					1,
					0
				}
			}
		},
		{
			expression = 8,
			side = 2,
			bgName = "bg_project_oceana_room1",
			nameColor = "#A9F548FF",
			tbActor = true,
			actor = 2001,
			actorName = "娜比娅",
			hidePaintObj = true,
			say = "那就这样咯，{tb}~",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		},
		{
			side = 2,
			nameColor = "#A9F548FF",
			bgName = "bg_project_oceana_room1",
			hidePaintObj = true,
			say = "就这样，和她相处的生活正式拉开了帷幕——",
			typewriter = {
				speed = 0.05,
				speedUp = 0.01
			}
		}
	}
}
