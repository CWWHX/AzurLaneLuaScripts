slot0 = class("MonopolyGame")
slot1 = pg.activity_event_monopoly_map
slot2 = pg.activity_event_monopoly_event
slot3 = 501041
slot4 = 501041
slot5 = 6
slot6 = 5
slot7 = {
	stateGold = "dafuweng_gold",
	stateOil = "dafuweng_oil",
	stateEvent = "dafuweng_event",
	stateWalk = "dafuweng_walk",
	stateStand = "dafuweng_stand",
	stateJump = "dafuweng_jump",
	stateRun = "dafuweng_run",
	stateTouch = "dafuweng_touch"
}
slot8 = nil

slot8 = function()
	return {
		onActionUpdated = function (slot0, slot1)
		end,
		currState = nil,
		ChangeState = function (slot0, slot1, slot2)
			slot2 = slot2 or function ()
			end

			if slot0.currState == slot1 then
				slot2()
			end

			slot0.currState = slot1

			slot0.onActionUpdated(slot1, slot2)
		end,
		IsStandState = function (slot0)
			return slot0.currState == uv0.stateStand
		end
	}
end

slot9 = function(slot0)
	return {
		onMove = function (slot0, slot1)
		end,
		onJump = function (slot0, slot1)
		end,
		onUpdatePos = function (slot0)
		end,
		ship = Ship.New({
			configId = slot0,
			skin_id = uv0
		}),
		state = uv1(),
		Move = function (slot0, slot1, slot2, slot3)
			slot2 = slot2 or function ()
			end

			if #slot1 == 0 then
				slot2()

				return
			end

			slot4 = function(slot0)
				if slot0 then
					uv0.state:ChangeState(uv1.stateWalk)
				else
					uv0.state:ChangeState(uv1.stateRun)
				end

				uv0.onMove(uv2, function ()
					if uv0:GetAction(uv1[#uv1]) then
						slot1 = uv0.state

						slot1:ChangeState(slot0, function ()
							uv0.state:ChangeState(uv1.stateStand)
							uv2()
						end)
					else
						uv0.state:ChangeState(uv2.stateStand)
						uv3()
					end
				end)
			end

			if #slot1 <= 3 and not slot3 then
				slot0:Jump(slot1, slot2)
			else
				slot4(slot3)
			end
		end,
		Jump = function (slot0, slot1, slot2)
			slot2 = slot2 or function ()
			end

			if #slot1 == 0 then
				slot2()

				return
			end

			slot3 = {}

			for slot7, slot8 in pairs(slot1) do
				table.insert(slot3, function (slot0)
					slot1 = uv0.state

					slot1:ChangeState(uv1.stateJump)
					uv0.onJump(uv2, function ()
						uv0.state:ChangeState(uv1.stateStand)
						uv2()
					end)
				end)
			end

			seriesAsync(slot3, function ()
				if uv0:GetAction(uv1[#uv1]) then
					slot1 = uv0.state

					slot1:ChangeState(slot0, function ()
						uv0.state:ChangeState(uv1.stateStand)
						uv2()
					end)
				else
					uv0.state:ChangeState(uv2.stateStand)
					uv3()
				end
			end)
		end,
		Touch = function (slot0)
			if slot0.state:IsStandState() then
				slot1 = slot0.state

				slot1:ChangeState(uv0.stateTouch, function ()
					uv0.state:ChangeState(uv1.stateStand)
				end)
			end
		end,
		GetAction = function (slot0, slot1)
			if slot1.config.icon == "icon_1" then
				return uv0.stateEvent
			elseif slot2 == "icon_2" then
				return uv0.stateGold
			elseif slot2 == "icon_3" then
				-- Nothing
			elseif slot2 == "icon_4" then
				return uv0.stateEvent
			elseif slot2 == "icon_5" then
				return uv0.stateOil
			elseif slot2 == "icon_6" then
				return uv0.stateEvent
			end
		end,
		InitPos = function (slot0, slot1)
			slot0:ChangePos(slot1)
			slot0.state:ChangeState(uv0.stateStand)
		end,
		ChangePos = function (slot0, slot1)
			assert(slot1)
			slot0.onUpdatePos(slot1)
		end,
		Dispose = function (slot0)
			slot0.onMove = nil
			slot0.onUpdatePos = nil
		end
	}
end

slot10 = function(slot0)
	return {
		id = slot0,
		config = uv0[slot0],
		ExistStory = function (slot0)
			return slot0.config.story and slot0.config.story ~= "0"
		end,
		isEmpty = function (slot0)
			return slot0.config.story == "0" and slot0.config.drop == 0 and #slot0.config.effect == 0
		end,
		Dispose = function (slot0)
			slot0.config = nil
		end
	}
end

slot11 = function(slot0)
	slot1 = {
		column = slot0.pos[2],
		row = slot0.pos[1],
		index = slot0.index,
		id = slot0.id,
		flag = slot0.flag
	}

	assert(slot1.id)

	slot1.config = uv0[slot1.id]
	slot1.events = {}

	for slot5, slot6 in ipairs(uv1.all) do
		if not table.contains(slot1.events, slot6) then
			table.insert(slot1.events, uv2(slot6))
		end
	end

	slot1.GetEvent = function(slot0, slot1)
		for slot5, slot6 in ipairs(slot0.events) do
			if slot6.id == slot1 then
				return slot6
			end
		end
	end

	slot1.SetNext = function(slot0, slot1)
		slot0.next = slot1
	end

	slot1.Dispose = function(slot0)
		for slot4, slot5 in ipairs(slot0.events) do
			slot5:Dispose()
		end
	end

	return slot1
end

slot12 = function(slot0, slot1)
	return {
		ROW = uv0,
		COLUMN = uv1 - 2,
		cellIds = slot0,
		path = {},
		char = nil,
		index = slot1,
		onCreateCell = function (slot0)
		end,
		onCreateChar = function (slot0)
		end,
		Init = function (slot0)
			slot1 = 0

			for slot5 = 0, uv0.ROW - 1 do
				uv0:CeateCell({
					slot1,
					slot5
				}, 0)
			end

			slot1 = uv0.ROW - 1

			for slot5 = 1, uv0.COLUMN do
				uv0:CeateCell({
					slot5,
					slot1
				}, #slot0.path)
			end

			slot1 = uv0.COLUMN + 1

			for slot5 = uv0.ROW - 1, 0, -1 do
				uv0:CeateCell({
					slot1,
					slot5
				}, #slot0.path)
			end

			slot1 = 0
			slot2 = #slot0.path - 1

			for slot6 = uv0.COLUMN, 1, -1 do
				uv0:CeateCell({
					slot6,
					slot1
				}, slot2)
			end

			slot0:CreateChar(uv1)
		end,
		CreateChar = function (slot0, slot1)
			slot0.char = uv0(slot1)

			slot0.onCreateChar(slot0.char)
			slot0.char:InitPos(slot0:GetCell(slot0.index))
		end,
		CeateCell = function (slot0, slot1, slot2)
			slot3 = #slot0.path
			slot4 = uv0({
				pos = slot1,
				index = slot3 + 1,
				id = slot0.cellIds[slot3 + 1],
				flag = slot2
			})

			if slot3 == 0 then
				slot4:SetNext(slot4)
			else
				slot0.path[slot3]:SetNext(slot4)
				slot4:SetNext(slot0.path[1])
			end

			table.insert(slot0.path, slot4)
			slot0.onCreateCell(slot4)
		end,
		GetPath = function (slot0)
			return slot0.path
		end,
		GetChar = function (slot0)
			return slot0.char
		end,
		GetPathCell = function (slot0, slot1)
			return _.map(slot1, function (slot0)
				return uv0.path[slot0]
			end)
		end,
		UpdateCharPos = function (slot0, slot1, slot2, slot3)
			slot0.char:Move(slot0:GetPathCell(slot1), slot2, slot3)

			slot0.index = slot1[#slot1]
		end,
		GetCell = function (slot0, slot1)
			return slot0.path[slot1]
		end,
		GetPos = function (slot0)
			return slot0.index
		end,
		Dispose = function (slot0)
			for slot4, slot5 in ipairs(slot0.path) do
				slot5:Dispose()
			end

			slot0.char:Dispose()

			slot0.onCreateCell = nil
			slot0.onCreateChar = nil
		end
	}
end

slot13 = function(slot0, slot1)
	slot2 = {
		_tf = slot0,
		_img = slot0:GetComponent(typeof(Image)),
		cell = slot1,
		interval = Vector2(0, 0),
		startPos = Vector2(0, 0),
		offset = Vector2(slot0.rect.width * 0.5 + 2.5, slot0.rect.height * 0.5 - 2),
		GetGenPos = function (slot0)
			slot1 = slot0.cell.column
			slot2 = slot0.cell.row

			return Vector3(slot0.startPos.x + slot1 * slot0.offset.x + slot2 * slot0.offset.x, slot0.startPos.y + slot1 * slot0.offset.y + slot2 * -slot0.offset.y, 0)
		end,
		UpdateStyle = function (slot0)
			slot0._img.sprite = GetSpriteFromAtlas("ui/activityuipage/monopoly_atlas", slot0.cell.config.icon)

			slot0._img:SetNativeSize()
		end,
		Dispose = function (slot0)
		end
	}

	setAnchoredPosition(slot0, slot2:GetGenPos())
	slot2._tf:SetSiblingIndex(slot1.flag)

	return slot2
end

slot14 = function(slot0, slot1)
	slot3 = slot0:GetChild(0)
	tf(slot3).localScale = Vector3(0.5, 0.5, 0.5)
	slot4 = GameObject("mouseChild")
	slot5 = tf(slot4)

	slot5:SetParent(tf(slot3))

	tf(slot4).localPosition = Vector3.zero

	setParent(slot4, slot3)

	GetOrAddComponent(slot4, "Image").color = Color.New(0, 0, 0, 0)
	slot6 = slot4:GetComponent(typeof(RectTransform))
	slot6.sizeDelta = Vector2(3, 3)
	slot6.pivot = Vector2(0.5, 0)
	slot6.anchoredPosition = Vector2(0, 0)

	onButton(nil, slot4, function ()
		uv0.char:Touch()
	end)

	return {
		_tf = slot0,
		WalkSpeed = 1,
		RunSpeed = 0.5,
		jumpSpeed = 0.5,
		char = slot1,
		SpineAnimUI = slot3:GetComponent("SpineAnimUI"),
		Action = function (slot0, slot1, slot2, slot3)
			_.each(slot1, function (slot0)
				table.insert(uv0, function (slot0)
					uv0:UpdateScale(uv1)

					if uv0._tf.localPosition == uv1:GetGenPos() then
						slot0()
					else
						slot2 = LeanTween.moveLocal(go(uv0._tf), slot1, uv2)

						slot2:setOnComplete(System.Action(function ()
							uv0.preCellTF = uv1

							uv2()
						end))
					end
				end)
			end)
			seriesAsync({}, function ()
				if uv0 then
					uv0()
				end
			end)
		end,
		Move = function (slot0, slot1, slot2)
			if #slot1 > 3 then
				slot0:Action(slot1, slot2, slot0.RunSpeed)
			else
				slot0:Action(slot1, slot2, slot0.WalkSpeed)
			end
		end,
		Jump = function (slot0, slot1, slot2)
			slot0:Action({
				slot1
			}, function ()
				uv0()
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_STEP_MONOPOLY)
			end, slot0.jumpSpeed)
		end,
		UpdatePos = function (slot0, slot1)
			slot0.preCellTF = slot1
			slot0._tf.localPosition = slot1:GetGenPos()
		end,
		UpdateScale = function (slot0, slot1)
			slot2 = 1
			slot0.preCellTF = slot0.preCellTF or slot1

			if slot0.preCellTF.cell.row < slot1.cell.row or slot0.preCellTF.cell.column < slot1.cell.column then
				slot2 = 1
			elseif slot1.cell.row < slot0.preCellTF.cell.row or slot1.cell.column < slot0.preCellTF.cell.column then
				slot2 = -1
			end

			slot0._tf.localScale = Vector3(slot2, 1, 1)
		end,
		ChangeAction = function (slot0, slot1, slot2)
			slot3 = slot0.SpineAnimUI

			slot3:SetActionCallBack(nil)

			slot3 = slot0.SpineAnimUI

			slot3:SetAction(slot1, 0)

			slot3 = slot0.SpineAnimUI

			slot3:SetActionCallBack(function (slot0)
				if slot0 == "finish" then
					uv0.SpineAnimUI:SetActionCallBack(nil)
					uv1()
				end
			end)
		end,
		Dispose = function (slot0)
			slot0.SpineAnimUI:SetActionCallBack(nil)

			slot0.char.onMove = nil

			if slot0.timer then
				slot0.timer:Stop()

				slot0.timer = nil
			end
		end
	}
end

slot0.SetUp = function(slot0, slot1, slot2)
	slot0.viewComponent = slot1
	slot3 = slot0.viewComponent._tf

	pg.DelegateInfo.New(slot0)

	slot0._tf = slot3
	slot0._go = go(slot3)
	slot0.models = {}

	parallelAsync({
		function (slot0)
			slot1 = Ship.New({
				configId = uv0,
				skin_id = uv1
			})
			slot3 = PoolMgr.GetInstance()

			slot3:GetSpineChar(slot1:getPrefab(), true, function (slot0)
				uv0.models[uv1.configId] = slot0

				uv2()
			end)
		end,
		function (slot0)
			onNextTick(slot0)
		end
	}, function ()
		uv0:setActivity(uv1)
		uv0:init()
		uv0:didEnter()
	end)
end

slot0.setActivity = function(slot0, slot1)
	slot0.activity = slot1
	slot0.useCount = slot0.activity.data1_list[2]
	slot5 = slot0.activity.data2_list[1]
	slot0.pos = slot0.activity.data2
	slot0.step = slot0.activity.data3
	slot0.effectId = slot0.activity.data4
	slot0.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - slot0.activity.data1) / 86400) * slot0.activity:getDataConfig("daily_time") + slot0.activity.data1_list[1]
	slot0.leftCount = slot0.totalCnt - slot0.useCount
	slot9 = slot1:getDataConfig("reward_time")
	slot0.nextredPacketStep = slot9 - slot0.useCount % slot9
	slot0.advanceTotalCnt = #slot1:getDataConfig("reward")
	slot0.isAdvanceRp = slot0.advanceTotalCnt - slot0.activity.data2_list[2] > 0
	slot0.leftAwardCnt = slot5 - slot6
	slot0.advanceRpCount = math.max(0, math.min(slot5, slot0.advanceTotalCnt) - slot6)
	slot0.commonRpCount = math.max(0, slot5 - slot0.advanceTotalCnt) - math.max(0, slot6 - slot0.advanceTotalCnt)
	slot0.leftDropShipCnt = 10 - (slot0.activity.data1_list[3] - 1)
end

slot0.NetActivity = function(slot0, slot1)
	slot0:setActivity(slot1)
	slot0:updateLeftCount()
	slot0:updateNextRedPacketStep()
end

slot0.init = function(slot0)
	slot0:blockAllEvent(false)

	slot0.bg = slot0:findTF("AD")
	slot0.mapCellTpl = slot0:getTpl("mapCell", slot0.bg)
	slot0.mapContainer = slot0:findTF("mapContainer", slot0.bg)
	slot0.charTpl = slot0:getTpl("char", slot0.bg)
	slot0.startBtn = slot0:findTF("start", slot0.bg)
	slot0.valueImg = slot0:findTF("value", slot0.bg):GetComponent(typeof(Image))
	slot0.leftcountLabel = slot0:findTF("leftcount", slot0.bg):GetComponent(typeof(Text))
	slot0.leftCountTF = slot0:findTF("leftcount/Text", slot0.bg):GetComponent(typeof(Text))
	slot0.nextRedPacketStepTF = slot0:findTF("nextRpStep/Text", slot0.bg):GetComponent(typeof(Text))
	slot0.commonRp = slot0:findTF("rp", slot0.bg)
	slot0.commonAnim = slot0.commonRp:GetComponent(typeof(Animator))
	slot0.commonRpCnt = slot0:findTF("rp_text/Text", slot0.bg):GetComponent(typeof(Text))
	slot0.dropShipTxt = slot0:findTF("AD/drop_ship_text"):GetComponent(typeof(Text))
	slot0.helpBtn = slot0:findTF("AD/help")
	slot0.anim = slot0:findTF("AD/anim")

	setActive(slot0.anim, false)

	slot0.leftcountLabel.text = i18n("monopoly_left_count")
	slot0.advanceTag = slot0:findTF("AD/rp/sp")
	slot0.advanceLabel = slot0:findTF("AD/rp_text/sp")
	slot0.advancecLabel = slot0:findTF("AD/rp_text/label")
	slot0.advanceImage = slot0:findTF("AD/rp_text/sp_img")
	slot0.advanceTxt = slot0:findTF("AD/rp_text/sp_img/Text"):GetComponent(typeof(Text))
end

slot0.updateNextRedPacketStep = function(slot0)
	slot0.nextRedPacketStepTF.text = slot0.nextredPacketStep
end

slot0.updateLeftCount = function(slot0)
	slot0.leftCountTF.text = slot0.leftCount

	slot0.commonAnim:SetInteger("count", slot0.leftAwardCnt)

	slot0.commonRpCnt.text = slot0.commonRpCount
end

slot0.updateValue = function(slot0, slot1)
	if slot1 ~= 0 then
		slot0.valueImg.sprite = GetSpriteFromAtlas("ui/activityuipage/monopoly_atlas", slot1)

		slot0.valueImg:SetNativeSize()
	end

	setActive(go(slot0.valueImg), slot1 ~= 0)
end

slot0.didEnter = function(slot0)
	setActive(slot0.startBtn, slot0.leftCount > 0)
	slot0:updateLeftCount()
	slot0:updateValue(0)
	slot0:updateNextRedPacketStep()

	slot0.mapVO = uv0(slot0.activity:getDataConfig("map"), slot0.pos)

	slot0:createMap(slot0.mapVO)
	slot0.mapVO:Init()
	slot0:checkState()
	onButton(slot0, slot0.startBtn, function ()
		if uv0.block then
			return
		end

		if uv0.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		uv0:startAction()
	end, SFX_PANEL)
	onButton(slot0, slot0.commonRp, function ()
		if uv0.leftAwardCnt > 0 then
			uv0:emit(MonopolyPage.ON_AWARD)
		end
	end, SFX_PANEL)
	onButton(slot0, slot0.helpBtn, function ()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_chunjie_monopoly.tip
		})
	end, SFX_PANEL)
end

slot0.blockAllEvent = function(slot0, slot1)
	slot0:emit(ActivityMainScene.LOCK_ACT_MAIN, slot1)

	slot0.block = slot1
end

slot0.triggerEvent = function(slot0, slot1, slot2, slot3)
	slot4 = slot0.mapVO
	slot4 = slot4:GetCell(slot1)
	slot5 = slot4:GetEvent(slot2)

	slot6 = function(slot0, slot1)
		if slot0 and slot0:ExistStory() then
			pg.NewStoryMgr.GetInstance():Play(slot0.config.story, slot1, true, true)
		else
			slot1()
		end
	end

	seriesAsync({
		function (slot0)
			uv0(uv1, slot0)
		end,
		function (slot0)
			slot1 = nil

			(function ()
				if not uv0 or uv0:isEmpty() then
					uv1()

					return
				end

				slot0 = uv2

				slot0:emit(MonopolyPage.ON_TRIGGER, uv2.activity.id, function (slot0, slot1)
					if not slot0 or #slot0 == 0 then
						uv0()

						return
					end

					slot2 = uv1.mapVO

					slot2:UpdateCharPos(slot0, function ()
						uv2 = uv1.mapVO:GetCell(uv0[#uv0]):GetEvent(uv3)

						uv4(uv2, uv5)
					end, true)
				end)
			end)()
		end
	}, slot3)
end

slot0.checkState = function(slot0)
	slot1 = {}

	slot0:blockAllEvent(true)

	if slot0:getStrory() then
		table.insert(slot1, function (slot0)
			pg.NewStoryMgr.GetInstance():Play(uv0, slot0)
		end)
	end

	if slot0.effectId ~= 0 then
		table.insert(slot1, function (slot0)
			uv0:triggerEvent(uv0.mapVO:GetPos(), uv0.effectId, slot0)
		end)
	end

	if slot0.step ~= 0 then
		table.insert(slot1, function (slot0)
			slot1 = uv0

			slot1:emit(MonopolyPage.ON_MOVE, uv0.activity.id, function (slot0, slot1, slot2)
				if not slot1 or #slot1 == 0 then
					uv0()

					return
				end

				slot3 = uv1.mapVO

				slot3:UpdateCharPos(slot1, function ()
					uv1:triggerEvent(uv0[#uv0], uv2, uv3)
				end)
			end)
		end)
	end

	seriesAsync(slot1, function ()
		uv0:blockAllEvent(false)
	end)
end

slot0.startAction = function(slot0)
	slot1 = slot0.activity.id
	slot2 = 0

	slot3 = function(slot0)
		if uv0 == 0 then
			slot0()

			return
		end

		slot1 = uv1

		slot1:emit(MonopolyPage.ON_MOVE, uv2, function (slot0, slot1, slot2)
			if not slot1 or #slot1 == 0 then
				uv0()

				return
			end

			uv1 = slot0
			slot3 = uv2.mapVO

			slot3:UpdateCharPos(slot1, function ()
				uv1:triggerEvent(uv0[#uv0], uv2, uv3)
			end)
		end)
	end

	seriesAsync({
		function (slot0)
			setActive(uv0.startBtn, false)
			uv0:blockAllEvent(true)
			uv0:playerAnim(slot0)
		end,
		function (slot0)
			slot1 = uv0

			slot1:emit(MonopolyPage.ON_START, uv1, function (slot0)
				uv0 = slot0

				uv1:updateValue(slot0)
				uv2()
			end)
		end,
		function (slot0)
			uv0(slot0)
		end,
		function (slot0)
			uv0(slot0)
		end,
		function (slot0)
			if not uv0:getStrory() then
				slot0()

				return
			end

			pg.NewStoryMgr.GetInstance():Play(slot1, slot0)
		end
	}, function ()
		uv0:updateValue(0)
		uv0:blockAllEvent(false)
		setActive(uv0.startBtn, uv0.leftCount > 0)
	end)
end

slot0.getStrory = function(slot0)
	slot1 = slot0.useCount

	if _.detect(slot0.activity:getDataConfig("story") or {}, function (slot0)
		return slot0[1] == uv0
	end) then
		return slot4[2]
	end

	return nil
end

slot0.createMap = function(slot0, slot1)
	slot0.charCard = nil
	slot0.cellTFs = {}

	slot1.onCreateCell = function(slot0)
		slot2 = uv1(cloneTplTo(uv0.mapCellTpl, uv0.mapContainer), slot0)

		slot2:UpdateStyle()

		uv0.cellTFs[slot0.index] = slot2
	end

	slot1.onCreateChar = function(slot0)
		slot1 = cloneTplTo(uv0.charTpl, uv0.mapContainer)

		setParent(uv0.models[slot0.ship.configId], slot1)

		uv0.charCard = uv1(slot1, slot0)

		slot0.onMove = function(slot0, slot1)
			slot3 = uv0.charCard

			slot3:Move(_.map(slot0, function (slot0)
				return uv0.cellTFs[slot0.index]
			end), slot1)
		end

		slot0.onUpdatePos = function(slot0)
			uv0.charCard:UpdatePos(uv0.cellTFs[slot0.index])
		end

		slot0.state.onActionUpdated = function(slot0, slot1)
			uv0.charCard:ChangeAction(slot0, slot1)
		end

		slot0.onJump = function(slot0, slot1)
			uv0.charCard:Jump(uv0.cellTFs[slot0.index], slot1)
		end
	end
end

slot0.playerAnim = function(slot0, slot1)
	setActive(slot0.anim, true)

	if slot0.timer then
		slot0.timer:Stop()
	end

	slot0.timer = Timer.New(function ()
		uv0()
		setActive(uv1.anim, false)
	end, 1.5, 1)

	slot0.timer:Start()
end

slot0.findTF = function(slot0, slot1, slot2)
	assert(slot0._tf, "transform should exist")

	return findTF(slot2 or slot0._tf, slot1)
end

slot0.getTpl = function(slot0, slot1, slot2)
	slot3 = slot0:findTF(slot1, slot2)

	slot3:SetParent(slot0._tf, false)
	SetActive(slot3, false)

	return slot3
end

slot0.Destroy = function(slot0)
	for slot4, slot5 in pairs(slot0.cellTFs) do
		slot5:Dispose()
	end

	slot0.charCard:Dispose()
	slot0.mapVO:Dispose()

	slot0.cellTFs = nil
	slot0.charCard = nil
	slot0.mapVO = nil

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	pg.DelegateInfo.Dispose(slot0)
end

slot0.emit = function(slot0, slot1, slot2, slot3)
	slot0.viewComponent:emit(slot1, slot2, slot3)
end

return slot0
