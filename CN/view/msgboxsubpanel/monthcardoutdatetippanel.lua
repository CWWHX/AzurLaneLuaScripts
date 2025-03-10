slot0 = class("MonthCardOutDateTipPanel", import(".MsgboxSubPanel"))

slot0.SetMonthCardEndDateLocal = function()
	if not getProxy(PlayerProxy):getRawData() or not slot0.id then
		return
	end

	if not slot0:getCardById(VipCard.MONTH) or slot1.leftDate == 0 then
		return
	end

	PlayerPrefs.SetInt("MonthCardEndDate" .. slot0.id, slot1:getLeftDate())
	PlayerPrefs.Save()
end

slot0.GetMonthCardEndDate = function()
	if not getProxy(PlayerProxy):getRawData() or not slot0.id then
		return 0
	end

	return PlayerPrefs.GetInt("MonthCardEndDate" .. slot0.id, 0)
end

slot0.SetMonthCardTipDate = function(slot0)
	if not slot0 then
		return
	end

	if not getProxy(PlayerProxy):getRawData() or not slot1.id then
		return
	end

	PlayerPrefs.SetInt("MonthCardTipDate" .. slot1.id, slot0)
	PlayerPrefs.Save()
end

slot0.GetMonthCardTipDate = function()
	if not getProxy(PlayerProxy):getRawData() or not slot0.id then
		return 0
	end

	return PlayerPrefs.GetInt("MonthCardTipDate" .. slot0.id, 0)
end

slot0.SetMonthCardTagDate = function()
	if not getProxy(PlayerProxy):getRawData() or not slot0.id then
		return
	end

	PlayerPrefs.SetInt("MonthCardTagDate" .. slot0.id, pg.TimeMgr.GetInstance():GetNextTime(0, 0, 0))
	PlayerPrefs.Save()
end

slot0.GetShowMonthCardTag = function()
	if not getProxy(PlayerProxy):getRawData() or not slot0.id then
		return false
	end

	if not slot0:getCardById(VipCard.MONTH) or slot1.leftDate == 0 then
		return false
	end

	if pg.TimeMgr.GetInstance():GetServerTime() < slot1:getLeftDate() - 259200 or slot3 < slot2 then
		return false
	end

	return PlayerPrefs.GetInt("MonthCardTagDate" .. slot0.id, 0) < slot2
end

slot0.TryShowMonthCardTipPanel = function(slot0)
	slot1 = function()
		if uv0 then
			uv0()
		end
	end

	if uv0.GetMonthCardEndDate() == 0 then
		slot1()

		return
	end

	slot4 = uv0.GetMonthCardTipDate()

	if pg.TimeMgr.GetInstance():GetServerTime() >= slot2 - 259200 and slot4 < slot2 - 259200 then
		uv0.SetMonthCardTipDate(slot3)

		slot5 = pg.TimeMgr.GetInstance():STimeDescS(math.min(slot3, slot2), "*t")
		slot7 = pg.TimeMgr.GetInstance():STimeDescS(slot2, "*t")

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_MONTH_CARD_TIP,
			title = pg.MsgboxMgr.TITLE_INFORMATION,
			content = i18n(slot2 <= slot3 and "trade_card_tips2" or "trade_card_tips3", i18n("trade_card_tips4", slot7.year, slot7.month, slot7.day)),
			dateText = i18n("trade_card_tips4", slot5.year, slot5.month, slot5.day),
			yesText = i18n("trade_card_tips1"),
			weight = LayerWeightConst.TOP_LAYER,
			onClose = slot1,
			onYes = function ()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
					confirmMonthCard = true,
					wrap = ChargeScene.TYPE_DIAMOND
				})
			end
		})

		return
	end

	slot1()
end

slot0.getUIName = function(slot0)
	return "Msgbox4MonthCardTip"
end

slot0.Init = function(slot0)
	uv0.super.Init(slot0)
	setText(slot0._tf:Find("NameText"), pg.ship_data_statistics[312011].name)
end

slot0.UpdateView = function(slot0, slot1)
	slot0:PreRefresh(slot1)

	rtf(slot0.viewParent._window).sizeDelta = Vector2.New(960, 685)

	setText(slot0._tf:Find("Desc"), slot1.content)
	setText(slot0._tf:Find("Date"), slot1.dateText)
	slot0:PostRefresh(slot1)
end

return slot0
