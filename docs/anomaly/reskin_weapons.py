"""Reskin COTZ CW weapons with models from the Anomaly CW2.0 conversion.

Usage (from the repository root):
    python3 docs/anomaly/reskin_weapons.py [--dry-run] [CLASS ...]

Each mapped COTZ SWEP keeps its class, balance, ammunition and attachment slots. The script removes
fields tied to the old viewmodel and appends the Anomaly model, animations, fire and animation sounds,
ironsights, reload timings and viewmodel-recoil settings from `cw_anomaly_<id>` and its `_vmrecoil`
variant. Reloads play at the Anomaly speed, so animations and their sounds stay in sync. Matching items take
the Anomaly world model while preserving inventory camera tuning. See docs/anomaly-reskin.md.
"""

import argparse
import re
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "attachments"))

from apply_placements import mask, match_brace, item_files  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parents[2]
ANOMALY_WEAPONS = REPO_ROOT / "lua" / "weapons"

# COTZ class -> Anomaly id. Guns with integrated-scope render targets or custom world model drawing
# (L85, L115, VSSK, Mosin, TOZ-194) need manual conversion and are not listed. The 9A-91 already uses
# the Anomaly model with hand-placed attachments.
WEAPON_MAP = {
    "cw_aek971": "aek971", "cw_ak12": "ak12", "cw_ak74": "ak74", "cw_akm": "akm",
    "cw_aks74u": "ak74u", "cw_an94k": "abakan", "cw_asval": "val", "cw_aug": "aug_a1", "cw_barrettm98b": "m98b",
    "cw_beretta92": "beretta", "cw_brhp": "hpsa", "cw_cz52": "cz52", "cw_deagle": "desert_eagle",
    "cw_deagle44": "desert_eagle", "cw_dragunov": "svd", "cw_f2000": "fn2000", "cw_famas": "famas",
    "cw_fiveseven": "fn57", "cw_fnfal": "fal", "cw_fort12": "fort", "cw_g36c": "g36k", "cw_g3a3": "g3sg",
    "cw_glock17": "glock", "cw_glock18": "glock", "cw_hk416": "hk416", "cw_kiparis": "kiparis",
    "cw_lr300": "lr300", "cw_m14": "mk14", "cw_m1911": "colt1911", "cw_makarov": "pm",
    "cw_mossberg500": "mossberg590", "cw_mp153": "mp153", "cw_mp5": "mp5", "cw_p90": "p90", "cw_p99": "walter",
    "cw_pkm": "pkm", "cw_pp19": "bizon", "cw_pp1901_vityaz": "vityaz", "cw_pp2000": "pp2000",
    "cw_ppsh": "ppsh41", "cw_rem870ae": "remington870", "cw_rpk": "rpk", "cw_saiga12": "saiga",
    "cw_sg552": "sig552", "cw_skorpion": "vz61", "cw_sks": "sks", "cw_sr3m": "vihr", "cw_stechaps": "aps",
    "cw_striker": "protecta", "cw_sv98": "sv98", "cw_svt40": "svt", "cw_svu": "svu", "cw_tokarev": "tt33",
    "cw_toz34": "toz34", "cw_toz34short": "toz34_sawedoff", "cw_toz66": "bm16_full", "cw_toz66short": "bm16",
    "cw_trg42": "trg", "cw_ump45": "ump45", "cw_vss": "vintorez", "cw_ws_m16a4": "m16",
}

# Presentation copied from the Anomaly SWEP.
COPIED_FIELDS = (
    "ViewModel", "WorldModel", "ViewModelFOV", "AimViewModelFOV", "ViewModelFlip", "UseHands",
    "IronsightPos", "IronsightAng", "SprintPos", "SprintAng", "Animations", "Sounds",
    "ReloadSpeed", "ReloadTime", "ReloadTime_Empty", "ReloadHalt", "ReloadHalt_Empty", "ShotgunReload", "ReloadStartTime",
    "InsertShellTime", "ReloadFinishWait", "AlwaysPlayReloadEnd", "MuzzleAttachmentName", "MuzzleEffect",
    "AnomalyScopeZoom", "AnomalyReticle", "Shell", "WM", "DrawTraditionalWorldModel", "WMPos", "WMAng", "FireSound", "FireSoundSuppressed",
)

# World model pitch (SWEP.WMAng[1]) replacing the pack's -5, which aims low and clips the hands and face.
# More negative raises the muzzle around the right hand bone.
WM_PITCH = -10
WM_PITCH_PISTOL = -7

DEFAULT_SIGHT_MODELS = {
    "cw_anomaly_m16": "wpn_m16_ironsight_hud",
    "cw_anomaly_p90": "wpn_p90_sight_hud",
    "cw_anomaly_lr300": "wpn_lr300_ironsight_hud",
    "cw_anomaly_remington870": "wpn_remington870_ironsight_hud",
    "cw_anomaly_hk416": "wpn_hk416_hud_sights",
}

# Fields tied to the old viewmodel, removed before the Anomaly presentation is appended.
REMOVED_FIELDS = set(COPIED_FIELDS) | {
    "AlternativePos", "AlternativeAng", "CustomizePos", "CustomizeAng", "CompactPos", "CompactAng",
    "FrontRearPos", "FrontRearAng", "FoldSightPos", "FoldSightAng", "PBIronsightsPos", "PBIronsightsAng",
    "SightBackUpPos", "SightBackUpAng", "BackupSights", "ReloadSpeed", "MuzzleAttachment", "MuzzlePosOffset",
    "MuzzlePosMod", "PosBasedMuz", "ShellScale", "ShellOffsetMul", "ShellPosOffset", "ShellDelay",
    "InvertShellEjectAngle", "WorldShellEjectionAttachmentID", "WElements", "AttachmentModelsVM",
    "AttachmentModelsWM", "DefaultSightModel", "AttachmentPosDependency", "ForeGripOffsetCycle_Draw", "ForeGripOffsetCycle_Reload",
    "ForeGripOffsetCycle_Reload_Empty", "ForeGripHoldPos", "SnapToGrip", "M203HoldPos",
    "M203OffsetCycle_Reload", "M203OffsetCycle_Reload_Empty", "M203OffsetCycle_Draw", "M203CameraRotation",
    "BoltBone", "BoltShootOffset", "BoltBonePositionRecoverySpeed", "OffsetBoltOnBipodShoot",
    "HoldBoltWhileEmpty", "BoltReloadOffset", "ReloadBoltBonePositionRecoverySpeed",
    "ReloadBoltBonePositionMoveSpeed", "StopReloadBoneOffset", "OffsetBoltDuringNonEmptyReload",
    "DontMoveBoltOnHipFire", "EmptyBoltHoldAnimExclusion", "LuaViewmodelRecoil", "LuaViewmodelRecoilOverride",
    "SightWithRail", "HasDovetailMount", "ADSFireAnim", "BipodFireAnim", "BaseArm", "BaseArmBoneOffset",
    "ViewModelBoneMods", "LaserPosAdjust", "LaserAngAdjust", "LaserAngAdjustAim", "WS_PistolLaserPosAdjust",
    "WS_PistolLaserAngAdjust", "SelectIcon",
}
# Sight aim positions (including ones for attachments outside lua/cw), bodygroups and scope alignment.
REMOVED_PATTERNS = (
    re.compile(r"\w+BGs$"), re.compile(r"\w+(Pos|Ang)$"), re.compile(r"\w*AxisAlign$"), re.compile(r"NXSAlign$|RTAlign$"),
)
REMOVED_FUNCTIONS = ("fireAnimFunc", "postPrimaryAttack")
# Variant-file fields that only identify the comparison SWEP.
VARIANT_SKIPPED = {"Base", "PrintName", "Category", "Spawnable", "AdminOnly"}


class ReskinError(Exception):
    pass


def attachment_aim_fields(root):
    """Aim position and angle field names used by every CW attachment."""
    names = set()
    for path in sorted((root / "lua/cw/shared/attachments").glob("*.lua")):
        match = re.search(r'att\.aimPos\s*=\s*{\s*"(\w+)"\s*,\s*"(\w+)"', path.read_text(encoding="utf-8", errors="replace"))
        if match:
            names.update(match.groups())
    return names


def statements(text):
    """Yield (name, start, end) for each `SWEP.Name = value` statement, including multi-line tables."""
    code = mask(text)
    for match in re.finditer(r"^[ \t]*SWEP\.(\w+)[ \t]*=[ \t]*", code, re.M):
        end = code.find("\n", match.end())
        end = len(code) if end < 0 else end
        brace = code.find("{", match.end(), end)
        if brace >= 0 and code.count("{", match.end(), end) > code.count("}", match.end(), end):
            close = match_brace(text, brace)
            end = code.find("\n", close)
            end = len(code) if end < 0 else end
        yield match.group(1), match.start(), end


def function_span(text, name):
    """Return (start, end) of `function SWEP:name(...) ... end`, or None."""
    code = mask(text, ("comment", "string"))
    match = re.search(r"^[ \t]*function SWEP[:.]%s\b" % re.escape(name), code, re.M)
    if not match:
        return None
    depth = 0
    for token in re.finditer(r"\b(function|if|do|repeat|end|until)\b", code[match.start():]):
        word = token.group(1)
        if word in ("function", "if", "do", "repeat"):
            depth += 1
        else:
            depth -= 1
            if depth == 0:
                end = match.start() + token.end()
                newline = code.find("\n", end)
                return match.start(), len(code) if newline < 0 else newline
    raise ReskinError("unterminated function %s" % name)


def remove_spans(text, spans):
    for start, end in sorted(spans, reverse=True):
        line_start = text.rfind("\n", 0, start) + 1
        # Comment lines directly above a removed statement describe it, so they go too.
        while line_start > 0:
            previous = text.rfind("\n", 0, line_start - 1) + 1
            line = text[previous:line_start - 1].strip()
            if not line.startswith("--") or line.startswith("--[") or "SWEP." in line:
                break
            line_start = start = previous
        stop = end + 1 if text[end:end + 1] == "\n" else end
        prefix = text[line_start:start]
        if prefix.strip():
            text = text[:start] + text[end:]
        else:
            text = text[:line_start] + text[stop:]
    return text


def strip_bodygroups(text):
    """Remove old-model bodygroup calls from IndividualInitialize, dropping the function if it empties."""
    span = function_span(text, "IndividualInitialize")
    if not span:
        return text
    body = text[span[0]:span[1]]
    cleaned = re.sub(r"^[ \t]*self:setBodygroup\([^)]*\)[ \t]*\n", "", body, flags=re.M)
    inner = re.sub(r"^[ \t]*function SWEP[:.]IndividualInitialize\(\)\s*|\s*end\s*$", "", cleaned)
    if not inner.strip():
        return remove_spans(text, [span])
    return text[:span[0]] + cleaned + text[span[1]:]


def is_removed(name, aim_fields):
    return name in REMOVED_FIELDS or name in aim_fields or any(p.match(name) for p in REMOVED_PATTERNS)


def anomaly_values(text, shared_only=False):
    """Map field name -> source text of each SWEP assignment in an Anomaly SWEP file."""
    values = {}
    client = re.search(r"^if CLIENT then\n.*?^end\b", mask(text), re.M | re.S) if shared_only else None
    for name, start, end in statements(text):
        if client and client.start() <= start < client.end():
            continue
        statement = text[start:end].strip()
        values[name] = statement[statement.index("=") + 1:].strip()
    return values


def client_block(text):
    """Return the body of the first `if CLIENT then ... end` block."""
    code = mask(text, ("comment", "string"))
    match = re.search(r"^if CLIENT then\n", code, re.M)
    if not match:
        return ""
    end = re.search(r"^end\b", code[match.end():], re.M)
    return text[match.end():match.end() + end.start()]


def world_model_angle(text, value):
    """Raise the pack's world model pitch so the gun follows the player's aim instead of sagging into the hands."""
    pistol = re.search(r'^[ \t]*SWEP\.(?:Normal)?HoldType[ \t]*=[ \t]*"pistol"', text, re.M)
    pitch = WM_PITCH_PISTOL if pistol else WM_PITCH
    return re.sub(r"^Vector\(\s*-?[\d.]+\s*,", "Vector(%d," % pitch, value)


def reskin_weapon(text, anomaly_text, variant_text, anomaly_class, aim_fields):
    anomaly = anomaly_values(anomaly_text)
    variant = anomaly_values(variant_text, shared_only=True)

    spans = [(start, end) for name, start, end in statements(text) if is_removed(name, aim_fields)]
    for name in REMOVED_FUNCTIONS:
        span = function_span(text, name)
        if span:
            spans.append(span)
    text = strip_bodygroups(remove_spans(text, spans))
    text = re.sub(r"[ \t]+\n", "\n", text)
    text = re.sub(r"\n{3,}", "\n\n", text).rstrip() + "\n"

    if "WMAng" in anomaly:
        anomaly["WMAng"] = world_model_angle(text, anomaly["WMAng"])
    shared = ["SWEP.%s = %s" % (name, anomaly[name]) for name in COPIED_FIELDS if name in anomaly]
    shared += ["SWEP.%s = %s" % (name, value) for name, value in variant.items() if name not in VARIANT_SKIPPED]

    variant_client = re.sub(r"killicon\.\w+\((?:[^()]|\([^()]*\))*\)", "", client_block(variant_text), flags=re.S)
    client = [line.strip() for line in variant_client.splitlines() if line.strip()]
    icon = re.search(r"SWEP\.SelectIcon = [^\n]+", client_block(anomaly_text))
    if icon:
        client.insert(0, icon.group(0))
    default_sight = DEFAULT_SIGHT_MODELS.get(anomaly_class)
    if default_sight:
        client.append('SWEP.DefaultSightModel = "models/flaymi/anomaly/weapons/attachments/v_models/%s.mdl"' % default_sight)

    block = ["", "-- Anomaly CW2.0 model, animations and viewmodel recoil from %s." % anomaly_class, ""]
    block += shared
    if client:
        block += ["", "if CLIENT then"] + ["\t" + line for line in client] + ["end"]
    span = function_span(variant_text, "fireAnimFunc")
    if span:
        block += ["", variant_text[span[0]:span[1]].strip()]
    return text + "\n".join(block) + "\n"


def lua_value(text, name):
    match = re.search(r"^ITEM\.%s\s*=\s*" % re.escape(name), mask(text), re.M)
    if not match:
        return None, None
    end = text.find("\n", match.end())
    brace = text.find("{", match.end(), end)
    if brace >= 0:
        end = text.find("\n", match_brace(text, brace))
    return match, len(text) if end < 0 else end


def reskin_item(text, world_model, current_text):
    """Use the pack world model and reuse a camera already tuned for it."""
    match, end = lua_value(text, "model")
    old_model = None
    if match:
        old_model = re.search(r'"([^"]+)"', text[match.end():end])
        text = text[:match.start()] + 'ITEM.model = "%s"' % world_model + text[end:]
    if old_model:
        # The back-slot PAC part shows the same world model.
        text = text.replace('"%s"' % old_model.group(1), '"%s"' % world_model)

    current_model = re.search(r'^ITEM\.model\s*=\s*"([^"]+)"', current_text, re.M)
    camera, camera_end = lua_value(current_text, "iconCam")
    if current_model and current_model.group(1) == world_model and camera:
        icon = current_text[camera.start():camera_end]
        match, end = lua_value(text, "iconCam")
        if match:
            text = text[:match.start()] + icon + text[end:]
        else:
            text = text.rstrip() + "\n\n" + icon + "\n"
    return text


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("classes", nargs="*")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--base", metavar="REV", help="read the COTZ files from this git revision")
    args = parser.parse_args(argv)

    def source(path):
        if not args.base:
            return path.read_text(encoding="utf-8")
        relative = path.resolve().relative_to(REPO_ROOT).as_posix()
        return subprocess.run(["git", "show", "%s:%s" % (args.base, relative)], cwd=REPO_ROOT, check=True,
            capture_output=True, text=True).stdout

    aim_fields = attachment_aim_fields(REPO_ROOT)
    classes = args.classes or sorted(WEAPON_MAP)
    status = 0
    for weapon_class in classes:
        anomaly_id = WEAPON_MAP.get(weapon_class)
        if not anomaly_id:
            print("SKIP %s: no Anomaly counterpart" % weapon_class)
            continue
        try:
            weapon_path = REPO_ROOT / "lua/weapons" / weapon_class / "shared.lua"
            anomaly_text = (ANOMALY_WEAPONS / ("cw_anomaly_%s.lua" % anomaly_id)).read_text(encoding="utf-8")
            variant_text = (ANOMALY_WEAPONS / ("cw_anomaly_%s_vmrecoil.lua" % anomaly_id)).read_text(encoding="utf-8")
            text = source(weapon_path)
            if "Anomaly CW2.0 model" in text:
                print("SKIP %s: already reskinned" % weapon_class)
                continue
            updated = {weapon_path: reskin_weapon(text, anomaly_text, variant_text, "cw_anomaly_" + anomaly_id,
                aim_fields)}
            world_model = anomaly_values(anomaly_text)["WorldModel"].strip('"')
            for path in item_files(REPO_ROOT, weapon_class):
                updated[path] = reskin_item(source(path), world_model, path.read_text(encoding="utf-8"))
        except (OSError, ReskinError, AttributeError, KeyError, subprocess.CalledProcessError) as error:
            print("FAIL %s: %s" % (weapon_class, error))
            status = 1
            continue
        if not args.dry_run:
            for path, content in updated.items():
                path.write_text(content, encoding="utf-8")
        print("%s %s <- %s (%d files)" % ("WOULD" if args.dry_run else "OK", weapon_class, anomaly_id, len(updated)))
    return status


if __name__ == "__main__":
    sys.exit(main())
