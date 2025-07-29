/*
*	A slightly unusual melee class that focuses on stacking INT for secondary combat mechanics. Based on Freifechters.
*/

/datum/advclass/lethal_warrior/duelist
	name = "Duelist"
	tutorial = ""
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/lethal_warrior/duelist
	traits_applied = list(TRAIT_STEELHEARTED, TRAIT_OUTLANDER)
	category_tags = list(CTAG_LETHALWARRIOR)

/datum/outfit/job/roguetown/lethal_warrior/duelist/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	ADD_TRAIT(H, TRAIT_DECEIVING_MEEKNESS, TRAIT_GENERIC)
	H.set_blindness(0)
	H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander2.ogg'
	var/weapons = list("Etruscan Longsword", "Kriegsmesser", "Common Longsword")
	var/weapon_choice = input("Choose your weapon, duelist", "TAKE UP LETHAL ARMS") as anything in weapons
	switch(weapon_choice)
		if("Etruscan Longsword")
			r_hand = /obj/item/rogueweapon/sword/long/etruscan
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
		if("Kriegsmesser")
			r_hand = /obj/item/rogueweapon/sword/long/kriegmesser
			H.adjust_skillrank_up_to(/datum/skill/combat/swords, 4, TRUE)
	H.change_stat("intelligence", 2)
	H.change_stat("perception", 1) //spared a negative in spite of the +3 because it doesnt get one of the stronger stats
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy/freifechter
	pants = /obj/item/clothing/under/roguetown/trou/leathertights
	shoes = /obj/item/clothing/shoes/roguetown/boots
	gloves = /obj/item/clothing/gloves/roguetown/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/sash
	backpack_contents = list(
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/recipe_book/survival = 1,
		)
