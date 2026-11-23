"""Write the offline placement spec for the Anomaly reskins.

Usage (from the repository root):
    python3 docs/anomaly/attachment_spec.py WORK_DIR [--base REV]

Exports the pre-reskin weapon files from REV (default HEAD) into WORK_DIR/old as donors, then writes
WORK_DIR/anomaly_spec.lua for `docs/attachments/offline_placement.lua anomaly|suppressors`.
See docs/anomaly-reskin.md.
"""

import argparse
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "attachments"))

import reskin_weapons as reskin  # noqa: E402
from apply_placements import item_files  # noqa: E402

REPO_ROOT = reskin.REPO_ROOT

# Pack sights present on the Anomaly model decide the anchor method.
DOVETAIL = {"aek971", "ak74", "akm", "aks74u", "an94k", "asval", "dragunov", "pp19", "saiga12", "sr3m", "svu", "vss"}
RAIL = {"ak12", "famas", "fnfal", "g3a3", "hk416", "lr300", "m14", "mp5", "p90", "pp1901_vityaz", "pp2000", "sg552",
    "ump45", "ws_m16a4", "rem870ae"}
# No pack sights: the old gun's hand-tuned sight height from the ironsights carries over.
IRONSIGHTS = {"beretta92", "brhp", "deagle", "deagle44", "fiveseven", "fort12", "glock17", "glock18", "m1911", "p99",
    "skorpion", "toz34", "toz34short", "pkm", "rpk"}

DOVETAIL_DONORS = ["cw_9a91", "old_cw_ak74", "old_cw_saigasport", "old_cw_dragunov", "old_cw_sks"]
RAIL_DONORS = ["old_cw_ws_m16a4", "old_cw_g36c", "old_cw_ump45", "old_cw_famas", "old_cw_ar159mm", "old_cw_sv98",
    "old_cw_remmsr", "old_cw_lr300", "old_cw_fnfal"]
PISTOL_DONORS = ["old_cw_p99", "old_cw_m1911", "old_cw_fiveseven", "old_cw_deagle", "old_cw_brhp"]


def lua(value):
    if isinstance(value, str):
        return '"%s"' % value
    if isinstance(value, (int, float)):
        return repr(value)
    return "{" + ", ".join(lua(item) for item in value) + "}"


def category(weapon_class):
    for path in item_files(REPO_ROOT, weapon_class):
        match = re.search(r'weaponCategory\s*=\s*"(\w+)"', path.read_text(encoding="utf-8"))
        if match:
            return match.group(1)
    return "primary"


PISTOL_RAIL = "models/cw2/attachments/pistolrail.mdl"


def mount_element(anomaly_id):
    """The pack's own rail mount element for a gun (a claw mount or rail adapter), if it has one."""
    text = (reskin.ANOMALY_WEAPONS / ("cw_anomaly_%s.lua" % anomaly_id)).read_text(encoding="utf-8")
    elements = text[text.find('["VElements"]'):]
    match = re.search(r'\["([a-z0-9_]+)"\] = \{\s*\["model"\] = "[^"]*/(?:wpn_[a-z0-9]+_mount[a-z_]*|wpn_addon_rail)\.mdl"',
        elements)
    return match.group(1) if match else None


def entry(weapon_class, anomaly_id, flipped):
    short = weapon_class[3:]
    spec = {"class": weapon_class, "category": category(weapon_class), "anomaly": "cw_anomaly_" + anomaly_id}
    if short in DOVETAIL:
        spec.update(method="translate", anchor="md_kobra", sight="Kobra", reference="cw_9a91",
            referenceAnomaly="cw_anomaly_9a91", mount="dovetail", donors=DOVETAIL_DONORS)
    elif short in RAIL:
        spec.update(method="element", anchor="md_eotech", element="sight_anomaly_eotech", geometryFrom="old_cw_ws_m16a4",
            mount="rail", donors=RAIL_DONORS)
        mount = mount_element(anomaly_id)
        if mount:
            spec.update(mountElement=mount)
    elif short in IRONSIGHTS:
        anchor = "md_kobra" if short == "rpk" else "md_microt1"
        if spec["category"] == "secondary":
            donors, geometry = PISTOL_DONORS, "old_cw_p99"
            # Pistol slides have no rail of their own.
            # Its lower clamp (below model height 10) hangs under the frame; only the top rail rests on the slide.
            spec.update(railModel=PISTOL_RAIL, railSize=0.17, railTop=10)
        elif anchor == "md_kobra":
            donors, geometry = DOVETAIL_DONORS, "old_cw_ak74"
        elif short.startswith("toz34"):
            donors, geometry = ["old_cw_toz34"], "old_cw_toz34"
        else:
            donors, geometry = RAIL_DONORS, "old_cw_ws_m16a4"
        donors = [donor for donor in donors if donor[4:] not in flipped and donor != "old_" + weapon_class]
        if weapon_class not in flipped:
            donors = ["old_" + weapon_class] + donors
        spec.update(method="ironsights", anchor=anchor, old="old_" + weapon_class, geometryFrom=geometry, donors=donors,
            alongBore=0.1)
        if anchor == "md_kobra":
            spec.update(mount="dovetail", scopeFrom="cw_9a91")
    else:
        spec.update(method="none")
    return spec


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("work_dir", type=Path)
    parser.add_argument("--base", default="HEAD")
    args = parser.parse_args(argv)

    old_dir = args.work_dir / "old"
    old_dir.mkdir(parents=True, exist_ok=True)
    for weapon in sorted((REPO_ROOT / "lua/weapons").glob("cw_*/shared.lua")):
        if weapon.parent.name == "cw_base":
            continue
        result = subprocess.run(["git", "show", "%s:%s" % (args.base, weapon.relative_to(REPO_ROOT).as_posix())],
            cwd=REPO_ROOT, capture_output=True, text=True)
        if result.returncode == 0:
            (old_dir / (weapon.parent.name + ".lua")).write_text(result.stdout, encoding="utf-8")

    flipped = {path.stem for path in old_dir.glob("*.lua")
        if re.search(r"ViewModelFlip\s*=\s*true", path.read_text(encoding="utf-8"))}
    paths = {"old_" + path.stem: str(path) for path in sorted(old_dir.glob("*.lua"))}
    for anomaly_id in set(reskin.WEAPON_MAP.values()) | {"9a91"}:
        paths["cw_anomaly_" + anomaly_id] = str(reskin.ANOMALY_WEAPONS / ("cw_anomaly_%s.lua" % anomaly_id))

    lines = ["return {", "\tpaths = {"]
    lines += ['\t\t["%s"] = "%s",' % item for item in sorted(paths.items())]
    lines += ["\t},", "\ttargets = {"]
    for weapon_class, anomaly_id in sorted(reskin.WEAPON_MAP.items()):
        spec = entry(weapon_class, anomaly_id, flipped)
        lines.append("\t\t{" + ", ".join("%s = %s" % (key, lua(value)) for key, value in spec.items()) + "},")
    lines += ["\t},", "}"]
    (args.work_dir / "anomaly_spec.lua").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("wrote %s (%d donors)" % (args.work_dir / "anomaly_spec.lua", len(paths)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
