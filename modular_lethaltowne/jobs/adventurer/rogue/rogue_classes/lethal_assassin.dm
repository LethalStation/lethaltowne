/*
*	A rogue subclass focused on using knives or swords.
*/

/datum/advclass/lethal_rogue/assassin
	name = "Assassin"
	tutorial = ""
	outfit = /datum/outfit/job/roguetown/lethal_rogue/assassin
	category_tags = list(CTAG_LETHALROGUE)
//	cmode_music = ''

/datum/outfit/job/roguetown/lethal_rogue/assassin/pre_equip(mob/living/carbon/human/H)
	..()
	has_loadout = TRUE
	head = /obj/item/clothing/head/roguetown/mentorhat
	backl = /obj/item/storage/backpack/rogue/satchel/black
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/knifebelt/black/kazengun
	gloves = /obj/item/clothing/gloves/roguetown/eastgloves1
	pants = /obj/item/clothing/under/roguetown/trou/leather/eastern
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/eastshirt1
	cloak = /obj/item/clothing/cloak/thief_cloak
	backpack_contents = list(
		/obj/item/flashlight/flare/torch/lantern/decrepit = 1,
		/obj/item/lockpickring/mundane = 1,
		/obj/item/recipe_book/survival = 1,
		)
	H.adjust_skillrank(/datum/skill/misc/tracking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.change_stat("strength", -1)
	H.change_stat("speed", 3)
	H.grant_language(/datum/language/thievescant)
	H.grant_language(/datum/language/kazengunese)
	var/weapons = list("Daggers", "Sword")
	var/weapon_choice = input(H,"Choose your weapon, assassin.", "TAKE UP LETHAL ARMS") as anything in weapons
	switch(weapon_choice)
		if("Daggers")
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/kazengun(H), TRUE)
			H.put_in_hands(new /obj/item/rogueweapon/huntingknife/idagger/steel/kazengun(H), TRUE)
			beltr = /obj/item/rogueweapon/scabbard/sheath
			beltl = /obj/item/rogueweapon/scabbard/sheath
			H.adjust_skillrank_up_to(/datum/skill/combat/knives, 3, TRUE)
		if("Sword")
			H.put_in_hands(new /obj/item/rogueweapon/sword/sabre/mulyeog(H), TRUE)
			beltl = /obj/item/rogueweapon/scabbard/kazengun
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 3, TRUE)
			H.adjust_skillrank_up_to(/datum/skill/combat/shields, 2, TRUE)
