#!/usr/bin/env python3
"""Migrate permissions from project local settings to global ~/.claude/settings.json."""

import json
import os
import sys

PERMISSION_TYPES = ["allow", "deny", "ask"]


def load_json(path):
    """Load JSON file, returning empty dict if file doesn't exist."""
    if not os.path.exists(path):
        return None
    with open(path) as f:
        return json.load(f)


def save_json(path, data):
    """Write JSON with 2-space indent."""
    with open(path, "w") as f:
        json.dump(data, f, indent=2)
        f.write("\n")


def get_permissions(settings):
    """Extract permissions dict from settings, defaulting to empty lists."""
    perms = settings.get("permissions", {})
    return {ptype: list(perms.get(ptype, [])) for ptype in PERMISSION_TYPES}


def collect_local_permissions(local_files):
    """
    Collect all permissions from local files.
    Returns list of (ptype, rule, source_filename) tuples, preserving order.
    """
    items = []
    seen = set()  # (ptype, rule) to deduplicate across files
    for path, filename in local_files:
        data = load_json(path)
        if data is None:
            continue
        perms = get_permissions(data)
        for ptype in PERMISSION_TYPES:
            for rule in perms[ptype]:
                key = (ptype, rule)
                if key not in seen:
                    seen.add(key)
                    items.append((ptype, rule, filename))
    return items


def is_in_global(rule, ptype, global_perms):
    return rule in global_perms[ptype]


def parse_selection(selection_str, max_index):
    """
    Parse a selection string like '1,3', '1-3', or 'all'.
    Returns a set of 0-based indices, or None on invalid input.
    """
    selection_str = selection_str.strip().lower()
    if selection_str == "all":
        return set(range(max_index))

    indices = set()
    parts = selection_str.split(",")
    for part in parts:
        part = part.strip()
        if "-" in part:
            bounds = part.split("-", 1)
            try:
                start = int(bounds[0].strip())
                end = int(bounds[1].strip())
            except ValueError:
                return None
            if start < 1 or end > max_index or start > end:
                return None
            indices.update(range(start - 1, end))
        else:
            try:
                n = int(part)
            except ValueError:
                return None
            if n < 1 or n > max_index:
                return None
            indices.add(n - 1)
    return indices


def main():
    cwd = os.getcwd()
    local_settings_path = os.path.join(cwd, ".claude", "settings.json")
    local_settings_local_path = os.path.join(cwd, ".claude", "settings.local.json")
    global_settings_path = os.path.expanduser("~/.claude/settings.json")

    local_files = [
        (local_settings_path, "settings.json"),
        (local_settings_local_path, "settings.local.json"),
    ]

    # Check that at least one local file exists
    existing_local = [(p, f) for p, f in local_files if os.path.exists(p)]
    if not existing_local:
        print("Error: No local settings files found.")
        print(f"  Looked for: {local_settings_path}")
        print(f"              {local_settings_local_path}")
        sys.exit(1)

    print("Scanning project permissions in .claude/settings.json and .claude/settings.local.json...\n")

    # Load global settings (create if missing)
    global_data = load_json(global_settings_path)
    if global_data is None:
        global_data = {}
    global_perms = get_permissions(global_data)

    # Collect all local permissions
    all_local = collect_local_permissions(local_files)

    if not all_local:
        print("No permissions found in local settings files.")
        sys.exit(0)

    # Partition into migratable and already-in-global
    to_migrate = []  # (ptype, rule, source_filename)
    already_global = []  # (ptype, rule)

    for ptype, rule, source in all_local:
        if is_in_global(rule, ptype, global_perms):
            already_global.append((ptype, rule))
        else:
            to_migrate.append((ptype, rule, source))

    # Display permissions not yet in global
    if to_migrate:
        print("Permissions not yet in global (~/.claude/settings.json):\n")

        # Group by ptype then source for display
        for ptype in PERMISSION_TYPES:
            by_source = {}
            for p, rule, source in to_migrate:
                if p == ptype:
                    by_source.setdefault(source, []).append(rule)
            for source, rules in by_source.items():
                if rules:
                    print(f"  {ptype.upper():<6} ({source}):")
                    for rule in rules:
                        idx = next(
                            i for i, (p, r, s) in enumerate(to_migrate)
                            if p == ptype and r == rule and s == source
                        )
                        print(f"    [{idx + 1}] {rule}")
        print()
    else:
        print("All local permissions are already in global settings.")

    if already_global:
        print("Already in global (skipped):")
        for ptype, rule in already_global:
            print(f"    {rule}")
        print()

    if not to_migrate:
        sys.exit(0)

    # Selection prompt
    while True:
        raw = input("Select permissions to migrate (e.g. 1,3 or 1-3 or all or q to quit): ").strip()
        if raw.lower() == "q":
            print("Aborted.")
            sys.exit(0)
        if not raw:
            continue
        indices = parse_selection(raw, len(to_migrate))
        if indices is None:
            print(f"  Invalid selection. Enter numbers 1-{len(to_migrate)}, ranges, 'all', or 'q'.")
            continue
        if not indices:
            print("  No items selected.")
            continue
        break

    selected = [to_migrate[i] for i in sorted(indices)]

    # Confirmation summary
    print()
    print("The following will be added to ~/.claude/settings.json")
    print("and removed from their source files:\n")

    for ptype in PERMISSION_TYPES:
        items = [(rule, source) for p, rule, source in selected if p == ptype]
        if items:
            parts = ", ".join(f"{rule} [from {source}]" for rule, source in items)
            print(f"  {ptype.upper():<5}: {parts}")

    print()
    confirm = input("Confirm? [y/N]: ").strip().lower()
    if confirm != "y":
        print("Aborted.")
        sys.exit(0)

    # Apply changes
    # 1. Add to global
    for ptype, rule, _ in selected:
        if rule not in global_perms[ptype]:
            global_perms[ptype].append(rule)

    if "permissions" not in global_data:
        global_data["permissions"] = {}
    for ptype in PERMISSION_TYPES:
        if global_perms[ptype]:
            global_data["permissions"][ptype] = global_perms[ptype]
        elif ptype in global_data["permissions"]:
            del global_data["permissions"][ptype]

    save_json(global_settings_path, global_data)

    # 2. Remove from source local files
    # Group selected rules by source file
    by_source = {}
    for ptype, rule, source in selected:
        by_source.setdefault(source, []).append((ptype, rule))

    for path, filename in local_files:
        if filename not in by_source:
            continue
        data = load_json(path)
        if data is None:
            continue
        perms = data.get("permissions", {})
        for ptype, rule in by_source[filename]:
            lst = perms.get(ptype, [])
            if rule in lst:
                lst.remove(rule)
            if lst:
                perms[ptype] = lst
            elif ptype in perms:
                del perms[ptype]
        if perms:
            data["permissions"] = perms
        elif "permissions" in data:
            del data["permissions"]
        save_json(path, data)

    print()
    print(f"Done. {len(selected)} permission(s) migrated to ~/.claude/settings.json.")


if __name__ == "__main__":
    main()
