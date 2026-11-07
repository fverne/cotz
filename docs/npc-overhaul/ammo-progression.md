# Ammunition progression from gun availability

Generated with `python3 docs/npc-overhaul/tools/ammo_progression.py --write`.

`PLUGIN.regularAmmoChain` contains every regular load, excluding AP, HP and special shotgun variants.
The five parallel gun chains are compared by position, then gun price, chain order and item ID.
The first default SWEP ammunition use determines each calibre's place. Unused calibres follow alphabetically.
This compares definition positions, not completion time through the shared contact prerequisites.
Regular ranks replace the previous price bands; regular, HP and AP stages are scaled to each seller's tree.
HP requires regular ammunition. AP additionally requires local HP when available, including equal-price variants.
Each vendor's ammunition stages require its preceding stage, so sibling story branches cannot bypass the order.
The approved plan has no starting sale supplies. No box prices, round counts or damage values are changed.

AP, HP and special shotgun variants are outside the regular chain and retain local counterpart prerequisites.
They share their regular load's rank, with later upgrade stages. Prices below are reference values only.
The legacy ID `45acp41` is .410 bore, a separate cartridge rather than a .45 ACP upgrade.

## Regular chain

762x25 → 9x19 → 45acp → 22lr → 545x39 → 12gauge → 45acp41 → 762x39 → 556x45 → 9x18 → 762x54 → 357magnum → 9x39 → 44magnum → 9x21 → 762x51 → 500magnum → 338lapua → 50ae → 57x28 → 127x55 → 145x114 → 700nitro → 93x64

| Regular load | First gun | Position |
| --- | --- | ---: |
| 762x25 | nagantrev | 1 |
| 9x19 | sten | 1 |
| 45acp | toz106 | 1 |
| 22lr | sako85varmint | 1 |
| 545x39 | aks74u | 1 |
| 12gauge | toz34short | 2 |
| 45acp41 | ij600 | 2 |
| 762x39 | sks | 2 |
| 556x45 | rugermini14 | 4 |
| 9x18 | makarov | 5 |
| 762x54 | w1895 | 6 |
| 357magnum | w9422357 | 7 |
| 9x39 | 9a91 | 13 |
| 44magnum | lax44 | 15 |
| 9x21 | gepardpdw | 16 |
| 762x51 | sako85 | 16 |
| 500magnum | g2contender500 | 18 |
| 338lapua | trg42 | 19 |
| 50ae | deagle | 24 |
| 57x28 | p90 | 26 |
| 127x55 | Unaccounted: appended | — |
| 145x114 | Unaccounted: appended | — |
| 700nitro | Unaccounted: appended | — |
| 93x64 | Unaccounted: appended | — |

## Seller allocations

| Item | Box price | Rounds | Price per round | Regular counterpart | Seller: milestone |
| --- | ---: | ---: | ---: | --- | --- |
| 762x25 | 500 | 60 | 8.3333 | 762x25 | beanstalk: BN01; brass: BR01; haggler: HG01 |
| 762x25ap | 500 | 60 | 8.3333 | 762x25 | beanstalk: BN03; brass: BR03 |
| 762x25hp | 500 | 60 | 8.3333 | 762x25 | beanstalk: BN02; brass: BR02 |
| 9x19 | 750 | 60 | 12.5000 | 9x19 | beanstalk: BN01; brass: BR01; haggler: HG02 |
| 9x19ap | 750 | 60 | 12.5000 | 9x19 | beanstalk: BN03; brass: BR03 |
| 9x19hp | 750 | 60 | 12.5000 | 9x19 | beanstalk: BN02; brass: BR02 |
| 45acp | 950 | 60 | 15.8333 | 45acp | beanstalk: BN02; brass: BR02; haggler: HG03 |
| 45acpap | 950 | 60 | 15.8333 | 45acp | beanstalk: BN04; brass: BR04 |
| 45acphp | 950 | 60 | 15.8333 | 45acp | beanstalk: BN03; brass: BR03 |
| 22lr | 450 | 60 | 7.5000 | 22lr | beanstalk: BN03; haggler: HG04 |
| 22lrap | 450 | 60 | 7.5000 | 22lr | beanstalk: BN05 |
| 22lrhp | 450 | 60 | 7.5000 | 22lr | beanstalk: BN04 |
| 545x39 | 1500 | 60 | 25.0000 | 545x39 | beanstalk: BN04; brass: BR04; intern: IN01; quartermaster: QM01 |
| 545x39ap | 1500 | 60 | 25.0000 | 545x39 | beanstalk: BN06; brass: BR06; intern: IN03 |
| 545x39hp | 1500 | 60 | 25.0000 | 545x39 | beanstalk: BN05; brass: BR05; intern: IN02 |
| 12gaugedt | 600 | 30 | 20.0000 | 12gauge | spoor: SP02 |
| 12gaugesg | 700 | 30 | 23.3333 | 12gauge | spoor: SP02 |
| 12gaugemg | 750 | 30 | 25.0000 | 12gauge | spoor: SP02 |
| 12gaugetr | 750 | 30 | 25.0000 | 12gauge | spoor: SP02 |
| 12gauge | 800 | 30 | 26.6667 | 12gauge | spoor: SP01 |
| 45acp41 | 600 | 20 | 30.0000 | 45acp41 | haggler: HG07; spoor: SP01 |
| 762x39 | 1700 | 60 | 28.3333 | 762x39 | beanstalk: BN07; brass: BR07; haggler: HG08; intern: IN03; quartermaster: QM03 |
| 762x39ap | 1700 | 60 | 28.3333 | 762x39 | beanstalk: BN09; brass: BR09; intern: IN05 |
| 762x39hp | 1700 | 60 | 28.3333 | 762x39 | beanstalk: BN08; brass: BR08; intern: IN04 |
| 556x45 | 1650 | 60 | 27.5000 | 556x45 | beanstalk: BN08; haggler: HG09; intern: IN04; quartermaster: QM04 |
| 556x45ap | 1650 | 60 | 27.5000 | 556x45 | beanstalk: BN10; intern: IN06 |
| 556x45hp | 1650 | 60 | 27.5000 | 556x45 | beanstalk: BN09; intern: IN05 |
| 9x18 | 600 | 60 | 10.0000 | 9x18 | beanstalk: BN09; brass: BR09; haggler: HG10 |
| 9x18ap | 600 | 60 | 10.0000 | 9x18 | beanstalk: BN11; brass: BR11 |
| 9x18hp | 600 | 60 | 10.0000 | 9x18 | beanstalk: BN10; brass: BR10 |
| 762x54 | 2100 | 60 | 35.0000 | 762x54 | beanstalk: BN10; brass: BR10; haggler: HG11; intern: IN06; quartermaster: QM06 |
| 762x54ap | 2100 | 60 | 35.0000 | 762x54 | beanstalk: BN12; brass: BR12; intern: IN08 |
| 762x54hp | 2100 | 60 | 35.0000 | 762x54 | beanstalk: BN11; brass: BR11; intern: IN07 |
| 357magnum | 1000 | 60 | 16.6667 | 357magnum | beanstalk: BN11; haggler: HG12 |
| 357magnumap | 1000 | 60 | 16.6667 | 357magnum | beanstalk: BN13 |
| 357magnumhp | 1000 | 60 | 16.6667 | 357magnum | beanstalk: BN12 |
| 9x39 | 1900 | 60 | 31.6667 | 9x39 | beanstalk: BN12; intern: IN08; quartermaster: QM08 |
| 9x39ap | 1900 | 60 | 31.6667 | 9x39 | beanstalk: BN14; intern: IN10 |
| 9x39hp | 1900 | 60 | 31.6667 | 9x39 | beanstalk: BN13; intern: IN09 |
| 44magnum | 1000 | 60 | 16.6667 | 44magnum | beanstalk: BN13; brass: BR13; haggler: HG14 |
| 44magnumap | 1000 | 60 | 16.6667 | 44magnum | beanstalk: BN15; brass: BR15 |
| 44magnumhp | 1000 | 60 | 16.6667 | 44magnum | beanstalk: BN14; brass: BR14 |
| 9x21 | 750 | 60 | 12.5000 | 9x21 | beanstalk: BN14; brass: BR14 |
| 9x21ap | 750 | 60 | 12.5000 | 9x21 | beanstalk: BN16; brass: BR16 |
| 9x21hp | 750 | 60 | 12.5000 | 9x21 | beanstalk: BN15; brass: BR15 |
| 762x51 | 1950 | 60 | 32.5000 | 762x51 | beanstalk: BN15; haggler: HG16; intern: IN11; quartermaster: QM11 |
| 762x51ap | 1950 | 60 | 32.5000 | 762x51 | beanstalk: BN17; intern: IN13 |
| 762x51hp | 1950 | 60 | 32.5000 | 762x51 | beanstalk: BN16; intern: IN12 |
| 500magnum | 1000 | 30 | 33.3333 | 500magnum | beanstalk: BN16; haggler: HG17 |
| 500magnumap | 1000 | 30 | 33.3333 | 500magnum | beanstalk: BN18 |
| 500magnumhp | 1000 | 30 | 33.3333 | 500magnum | beanstalk: BN17 |
| 338lapua | 3500 | 60 | 58.3333 | 338lapua | beanstalk: BN17; intern: IN13; quartermaster: QM13 |
| 338lapuaap | 3500 | 60 | 58.3333 | 338lapua | beanstalk: BN19; intern: IN15 |
| 338lapuahp | 3500 | 60 | 58.3333 | 338lapua | beanstalk: BN18; intern: IN14 |
| 50ae | 1750 | 60 | 29.1667 | 50ae | beanstalk: BN18; brass: BR18 |
| 50aeap | 1750 | 60 | 29.1667 | 50ae | beanstalk: BN20; brass: BR20 |
| 50aehp | 1750 | 60 | 29.1667 | 50ae | beanstalk: BN19; brass: BR19 |
| 57x28 | 850 | 60 | 14.1667 | 57x28 | beanstalk: BN19; brass: BR19 |
| 57x28ap | 850 | 60 | 14.1667 | 57x28 | beanstalk: BN21; brass: BR21 |
| 57x28hp | 850 | 60 | 14.1667 | 57x28 | beanstalk: BN20; brass: BR20 |
| 127x55 | 3500 | 30 | 116.6667 | 127x55 | beanstalk: BN20 |
| 145x114ap | 8000 | 60 | 133.3333 | 145x114 |  |
| 145x114hp | 8000 | 60 | 133.3333 | 145x114 |  |
| 145x114 | 8000 | 30 | 266.6667 | 145x114 |  |
| 700nitro | 3500 | 16 | 218.7500 | 700nitro |  |
| 93x64 | 3500 | 30 | 116.6667 | 93x64 | beanstalk: BN22 |
