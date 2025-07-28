/*
*	A typical spellcasting class.
*/

/datum/advclass/lethal_mage/sorcerer
	name = "Sorcerer"
	tutorial = ""
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/lethal_mage/sorcerer
	category_tags = list(CTAG_LETHALMAGE)
	traits_applied = list(TRAIT_OUTLANDER)

/datum/outfit/job/roguetown/lethal_mage/sorcerer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood/mage
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/mage
	belt = /obj/item/storage/belt/rogue/leather
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/huntingknife
	backl = /obj/item/storage/backpack/rogue/satchel
	backr = /obj/item/rogueweapon/woodstaff
	backpack_contents = list(
		/obj/item/flashlight/flare/torch/lantern/decrepit = 1,
		/obj/item/spellbook_unfinished/pre_arcyne = 1,
		/obj/item/recipe_book/survival = 1,
		/obj/item/rogueweapon/scabbard/sheath = 1,
		/obj/item/recipe_book/magic = 1,
		/obj/item/chalk = 1
		)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.mind?.adjust_spellpoints(3)
	H.change_stat("intelligence", 2)
	H.mind?.adjust_spellpoints(9)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	ADD_TRAIT(H, TRAIT_MAGEARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ARCYNE_T3, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/combat_outlander4.ogg'
	switch(H.patron?.type)
		if(/datum/patron/inhumen/zizo)
			H.cmode_music = 'sound/music/combat_heretic.ogg'
