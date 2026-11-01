# Quest item candidates

The 82 definitions in `gamemodes/ix_cotz/schema/items/quests/` are candidates for
one-time progression recoveries: numbered modules, specific records and marked media,
or distinctive experimental/recovery objects. Selection reflects their potential identity and
contents, not a runtime guarantee of uniqueness. Generic supplies, tools, empty containers,
mass-produced electronics and ordinary unmarked stationery remain outside this group.

The folder inherits `base_quests`, which forwards to `base_valuable`. Concrete definitions have
no base overrides. Filenames, item IDs, tuning and existing saved instances are preserved.

Quest IDs are excluded from ordinary random loot, NPC drops, hidden caches and shared job
hand-in pools. Future progression definitions must provide their acquisition and one-time
consumption rules. Existing saved inventories and accepted assignments are not rewritten.

| Item | Item ID | Reason for selection |
| --- | --- | --- |
| Numbered Data Module 0013 | `value_electroniccase_0013` | Numbered modules |
| Numbered Data Module 0022 | `value_electroniccase_0022` | Numbered modules |
| Numbered Data Module 0031 | `value_electroniccase_0031` | Numbered modules |
| Numbered Data Module 0048 | `value_electroniccase_0048` | Numbered modules |
| Numbered Data Module 0052 | `value_electroniccase_0052` | Numbered modules |
| Flight Log Folder | `value_air_journal` | Specific records and personal evidence |
| Laboratory Log Folder | `value_lab_journal` | Specific records and personal evidence |
| Clinical Records Folder I | `value_med_journal_1` | Specific records and personal evidence |
| Clinical Records Folder II | `value_med_journal_2` | Specific records and personal evidence |
| Military Records Folder I | `value_military_secret_documents_1` | Specific records and personal evidence |
| Military Records Folder II | `value_military_secret_documents_2` | Specific records and personal evidence |
| Military Records Folder III | `value_military_secret_documents_3` | Specific records and personal evidence |
| Warehouse Packing List A | `value_packinglist_goshan` | Specific records and personal evidence |
| Warehouse Packing List B | `value_packinglist_idea` | Specific records and personal evidence |
| Warehouse Packing List C | `value_packinglist_oli` | Specific records and personal evidence |
| Corporate Letter | `value_letter_tg` | Specific records and personal evidence |
| Blue Research Dossier | `value_info_tgdocs` | Specific records and personal evidence |
| Loose Intelligence Dossier | `value_intelligence` | Specific records and personal evidence |
| Scientist's Field Diary | `value_scientistdiary` | Specific records and personal evidence |
| Tied Leather Journal | `value_info_diary_friend_mechanic` | Specific records and personal evidence |
| Personnel File Folder | `value_note_folder_closed_cardboard_personal` | Specific records and personal evidence |
| Official File Folder | `value_note_folder_closed_cardboard_state` | Specific records and personal evidence |
| Corporate Records Folder | `value_note_folder_closed_terragroup` | Specific records and personal evidence |
| Old Photograph Album | `value_photograph_album` | Specific records and personal evidence |
| Marked Data Disc I | `value_info_cd_disk_i` | Marked media and access objects |
| Marked Data Disc II | `value_info_cd_disk_ii` | Marked media and access objects |
| Stained Video Cassette | `value_event_labyrinth_videocassette` | Marked media and access objects |
| Labelled Video Cassette | `value_info_videocassette_cyborg` | Marked media and access objects |
| Tape-Labelled Flash Drive | `value_flash_card_slider_kerman` | Marked media and access objects |
| Blue-Taped Flash Drive | `value_flash_card_slider_sanitar` | Marked media and access objects |
| Tagged Security Flash Drive | `value_spec_tgflashkey` | Marked media and access objects |
| Recovered Flight Recorder | `value_quest_flight_recorder` | Distinctive research and recovery objects |
| Spherical Flight Recorder | `value_spherical_recorder` | Distinctive research and recovery objects |
| Unidentified Instrument Assembly | `value_mysterious_device` | Distinctive research and recovery objects |
| Recovered Experimental Headset | `value_psi_helmet` | Distinctive research and recovery objects |
| Dark-Capped Research Tube | `value_tg_vi_24` | Distinctive research and recovery objects |
| Green-Capped Research Tube | `value_tg_vi_24_antivirus` | Distinctive research and recovery objects |
| Red-Trimmed Control Unit | `value_electr_controller_quest` | Distinctive research and recovery objects |
| Improvised Electronic Tool | `value_hacktool_mechanic` | Distinctive research and recovery objects |
| Bandit Insignia | `value_badge_bandit` | Additional user-selected quest asset |
| Clear Sky Insignia | `value_badge_csky` | Additional user-selected quest asset |
| Defiance Insignia | `value_badge_defiance` | Additional user-selected quest asset |
| Duty Insignia | `value_badge_dolg` | Additional user-selected quest asset |
| Ecologist Insignia | `value_badge_ecolog` | Additional user-selected quest asset |
| Freedom Insignia | `value_badge_freedom` | Additional user-selected quest asset |
| Sin Insignia | `value_badge_greh` | Additional user-selected quest asset |
| ISG Insignia | `value_badge_isg` | Additional user-selected quest asset |
| Mercenary Insignia | `value_badge_merc` | Additional user-selected quest asset |
| Military Insignia | `value_badge_military` | Additional user-selected quest asset |
| Monolith Insignia | `value_badge_monolith` | Additional user-selected quest asset |
| Renegade Insignia | `value_badge_renegade` | Additional user-selected quest asset |
| Blue Decorated Transit Box | `value_container_arena_battlepass_s1` | Additional user-selected quest asset |
| Red Decorated Transit Box | `value_container_arena_battlepass_s2` | Additional user-selected quest asset |
| Orange Evidence Case | `value_container_case_kompromat` | Additional user-selected quest asset |
| Marked Research Case | `value_container_cultic_kappa` | Additional user-selected quest asset |
| Striped Equipment Case | `value_container_gamma` | Additional user-selected quest asset |
| Worn Striped Equipment Case | `value_container_gamma_damaged` | Additional user-selected quest asset |
| Brown Reinforced Case | `value_container_gamma_prestige` | Additional user-selected quest asset |
| Pale Reinforced Case | `value_container_gamma_tue` | Additional user-selected quest asset |
| Grey Ordnance Case | `value_container_grenadebox` | Additional user-selected quest asset |
| Large Ribbed Transit Case | `value_container_items_thicc` | Additional user-selected quest asset |
| Textured Key Case | `value_container_keys_case` | Additional user-selected quest asset |
| Medical Transport Case | `value_container_meds` | Additional user-selected quest asset |
| Stickered Tool Case | `value_container_moderator_toolbox` | Additional user-selected quest asset |
| Cash Transit Case | `value_container_money` | Additional user-selected quest asset |
| Small Padded Equipment Case | `value_container_pistolcase` | Additional user-selected quest asset |
| Armour Plate Transit Case | `value_container_plates_case` | Additional user-selected quest asset |
| Small Yellow Transit Case | `value_container_secured_alpha` | Additional user-selected quest asset |
| Flat Yellow Transit Case | `value_container_secured_beta` | Additional user-selected quest asset |
| Long Yellow Transit Case | `value_container_secured_epsilon` | Additional user-selected quest asset |
| Black-and-Orange Transit Case | `value_container_secured_kappa` | Additional user-selected quest asset |
| Strapped Transit Case | `value_container_secured_theta` | Additional user-selected quest asset |
| Blue-Label Audio Cassette | `value_recorder_tape_02` | Additional user-selected quest asset |
| Yellow-Label Audio Cassette | `value_recorder_tape_03` | Additional user-selected quest asset |
| White Audio Cassette | `value_recorder_tape_04` | Additional user-selected quest asset |
| Red Audio Cassette | `value_recorder_tape_05` | Additional user-selected quest asset |
| Handwritten Audio Cassette | `value_recorder_tape_06` | Additional user-selected quest asset |
| Black Audio Cassette | `value_recorder_tape_08` | Additional user-selected quest asset |
| Dark Labelled Audio Cassette | `value_recorder_tape_09` | Additional user-selected quest asset |
| Blue-Strip Audio Cassette | `value_recorder_tape_10` | Additional user-selected quest asset |
| Red Labelled Audio Cassette | `value_recorder_tape_11` | Additional user-selected quest asset |
| Green Audio Cassette | `value_recorder_tape_12` | Additional user-selected quest asset |
