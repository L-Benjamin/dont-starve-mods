PrefabFiles = {
	"palace_prefabs",
	"pig_palace",
}

-- Very strange, STRINGS.CITY_PIG_TALK_ATTEMPT_TRADE is present twice. The used one misses a lot of strings.
-- Possible future fix, in data/strings.lua.
-- Also STRINGS.CITY_PIG_TALK_LOOKATROYALTY_TRADER is wrong: one of the strings "NEED'ST THOU %s?" should be "HAST THOU %s?"

AddPrefabPostInit("pigman_queen", function(inst)
    inst.daily_gift = math.huge

	if GLOBAL.GetPlayer():HasTag("pigroyalty") then
		GLOBAL.STRINGS.CITY_PIG_TALK_LOOKATROYALTY_TRADER.pigman_queen = {"GREETINGS MINE LITTLE PRINCESS", "WILBA, HAV'TH THOU FOUNDETH MINE ROYAL BELONGINGS?", "COMETH BACK FOR SUPPER, SWEETIE", "HOW WAS THINE DAY HONEY?", "CAREFUL OUTSIDE, WILBA", "FINDETH THEE MINE ROYAL BELONGINGS, PRECIOUS DAUGHTER?", "CLEAN THINE ROOM BEFORE THOU LEAVETH, SWEET"}
		GLOBAL.STRINGS.CITY_PIG_TALK_ATTEMPT_TRADE.pigman_queen = {"WHAT HATH THEE FOR ME THIS TIME?", "THOU HAST SOMETHING FOR MAMA?", "FINDEST THEE MINE ROYAL BELONGINGS?"}
		GLOBAL.STRINGS.CITY_PIG_TALK_GIVE_REWARD.pigman_queen = {"GOOD JOB, HONEY. MAMA IS HAPPY", "THOU MAKEST ME PROUD", "WELL DONE MINE SMALL PRINCESS"}
	end
end)