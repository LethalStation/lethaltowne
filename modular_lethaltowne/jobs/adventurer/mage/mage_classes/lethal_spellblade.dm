/*
*	A mage that trades some of its arcyne abilities for adding swords to its kit.
*/

/datum/advclass/lethal_mage/spellblade
	name = "Spellblade"
	tutorial = ""
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/lethal_mage/spellblade
	category_tags = list(CTAG_LETHALMAGE)
	traits_applied = list(TRAIT_OUTLANDER)

/datum/outfit/job/roguetown/lethal_mage/spellblade/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/bucklehat
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backpack_contents = list(
		/obj/item/flashlight/flare/torch/lantern/decrepit = 1,
		/obj/item/recipe_book/survival = 1,
		)
	if(H.mind)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/airblade)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/enchant_weapon)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/conjure_weapon)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.change_stat("strength", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 1)
	H?.mind.adjust_spellpoints(6)
	H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander3.ogg'
	ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCYNE_T2, TRAIT_GENERIC)
	var/weapons = list("Bastard Sword", "Falchion & Wooden Shield", "Messer & Wooden Shield", "Foreign Straight Sword") // Much smaller selection with only three swords. You will probably want to upgrade.
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Bastard Sword")
			beltr = /obj/item/rogueweapon/scabbard/sword
			r_hand = /obj/item/rogueweapon/sword/long
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
		if("Falchion & Wooden Shield")
			beltr = /obj/item/rogueweapon/scabbard/sword
			backr = /obj/item/rogueweapon/shield/wood
			r_hand = /obj/item/rogueweapon/sword/falchion
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
			H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		if("Messer & Wooden Shield")
			beltr = /obj/item/rogueweapon/scabbard/sword
			backr = /obj/item/rogueweapon/shield/wood
			r_hand = /obj/item/rogueweapon/sword/iron/messer
			armor = /obj/item/clothing/suit/roguetown/armor/leather/heavy/coat
			H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		if("Foreign Straight Sword")
			r_hand = /obj/item/rogueweapon/sword/sabre/mulyeog // Meant to not have the special foreign scabbards.
			beltr = /obj/item/rogueweapon/scabbard/sword
			armor = /obj/item/clothing/suit/roguetown/armor/basiceast
	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/combat_heretic.ogg'
