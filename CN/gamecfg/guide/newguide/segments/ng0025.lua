slot0 = {
	"完成战术研习任务可以获得技能升级经验，部分任务可以重复完成",
	"一名角色只能同时进行一项技能的战术研习任务。多名角色之间彼此独立，同时进行",
	"一名角色每日最多获取<color=#ff5c5c>30000</color>点技能升级经验，其中前<color=#ff5c5c>60%</color>的技能升级经验拥有双倍累计速度"
}

return {
	id = "NG0025",
	events = {
		{
			alpha = 0.4,
			style = {
				mode = 2,
				dir = 1,
				posY = 0,
				posX = -125.9,
				text = slot0[1]
			}
		},
		{
			alpha = 0.4,
			style = {
				mode = 2,
				dir = 1,
				posY = 330.4,
				posX = 120.01,
				text = slot0[2],
				ui = {
					path = "OverlayCamera/Overlay/UIMain/MetaCharacterTacticsUI(Clone)/ExpPanel"
				}
			}
		},
		{
			alpha = 0.4,
			style = {
				mode = 2,
				dir = 1,
				posY = 330.4,
				posX = 120.01,
				text = slot0[3],
				ui = {
					path = "OverlayCamera/Overlay/UIMain/MetaCharacterTacticsUI(Clone)/ExpPanel"
				}
			}
		}
	}
}
