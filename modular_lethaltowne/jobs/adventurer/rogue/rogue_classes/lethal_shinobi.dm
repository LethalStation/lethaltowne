/*
*	A rogue subclass focused using knives or swords.
*/

/datum/advclass/lethal_rogue/shinobi
	name = "Shinobi"
	tutorial = ""
	outfit = /datum/outfit/job/roguetown/lethal_rogue/confessor
	category_tags = list(CTAG_LETHALROGUE)
	cmode_music = ''

/datum/outfit/job/roguetown/lethal_rogue/thief/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/mentorhat
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/kazengun
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/trou/leather/eastern
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
	cloak = /obj/item/clothing/cloak/thief_cloak
	backpack_contents = list(
		/obj/item/flashlight/flare/torch/lantern/decrepit = 1,
		/obj/item/rogueweapon/huntingknife/idagger/steel/kazengun = 1,
		/obj/item/lockpickring/mundane = 1,
		/obj/item/recipe_book/survival = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1
		)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/maces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 4, TRUE)
	H.change_stat("strength", -1)
	H.change_stat("speed", 3)
	H.grant_language(/datum/language/thievescant)
