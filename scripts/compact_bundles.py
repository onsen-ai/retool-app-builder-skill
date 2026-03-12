#!/usr/bin/env python3
"""Compact Retool bundles: strip positions/metadata, truncate large inline data."""
import re, sys, os, glob

SKIP_FILES = {'.positions.json', '.mobile_positions.json', '.defaults.json', 'metadata.json'}
MAX_ATTR_VALUE_LEN = 300  # Truncate attribute values longer than this
MAX_LINE_LEN = 500  # Truncate any line longer than this

def truncate_long_values(line):
    """Truncate absurdly long attribute values (e.g., sample data arrays)."""
    if len(line) <= MAX_LINE_LEN:
        return line
    
    # Try to truncate attribute values like: attrName={" ... huge JSON ... "}
    def truncate_attr(m):
        name = m.group(1)
        val = m.group(2)
        if len(val) > MAX_ATTR_VALUE_LEN:
            return f'{name}={{"{val[:150]}... [TRUNCATED {len(val)} chars]"}}'
        return m.group(0)
    
    result = re.sub(r'(\w+)=\{"([^}]{300,})"\}', truncate_attr, line)
    if len(result) <= MAX_LINE_LEN:
        return result
    
    # Also handle simple quoted attrs: attr="huge value"
    def truncate_quoted(m):
        name = m.group(1)
        val = m.group(2)
        if len(val) > MAX_ATTR_VALUE_LEN:
            return f'{name}="{val[:150]}... [TRUNCATED {len(val)} chars]"'
        return m.group(0)
    
    result = re.sub(r'(\w+)="([^"]{300,})"', truncate_quoted, result)
    if len(result) > MAX_LINE_LEN:
        # Nuclear option - just truncate the line
        return result[:MAX_LINE_LEN] + f'  ... [LINE TRUNCATED from {len(line)} chars]\n'
    return result

def compact_bundle(path):
    with open(path) as f:
        content = f.read()
    
    sections = re.split(r'(# ──+\n# FILE: .+\n# ──+\n)', content)
    
    header_match = re.search(r'# RETOOL APP BUNDLE: (.+)', sections[0])
    bundle_name = header_match.group(1) if header_match else os.path.basename(path)
    
    output = [f"# === BUNDLE: {bundle_name} ===\n"]
    
    i = 1
    while i < len(sections):
        if i + 1 < len(sections):
            file_header = sections[i]
            file_content = sections[i + 1]
            
            fname_match = re.search(r'# FILE: (.+)', file_header)
            fname = fname_match.group(1).strip() if fname_match else ""
            
            base = os.path.basename(fname)
            if base in SKIP_FILES or 'positions' in base.lower():
                i += 2
                continue
            
            # Truncate long lines in RSX/code files
            lines = file_content.split('\n')
            compacted_lines = [truncate_long_values(l) for l in lines]
            compacted_content = '\n'.join(compacted_lines)
            
            output.append(f"\n# FILE: {fname}\n")
            output.append(compacted_content.rstrip() + "\n")
        i += 2
    
    return ''.join(output)

bundles = sorted(glob.glob('/tmp/retool-bundles/*.toolscript-bundle'))
total_orig = 0
total_compact = 0
all_compacted = []

for b in bundles:
    orig_size = os.path.getsize(b)
    compacted = compact_bundle(b)
    compact_size = len(compacted.encode())
    total_orig += orig_size
    total_compact += compact_size
    ratio = compact_size / orig_size * 100
    print(f"{os.path.basename(b):50s}  {orig_size:6d} -> {compact_size:6d}  ({ratio:.0f}%)")
    all_compacted.append(compacted)

print(f"\n{'TOTAL':50s}  {total_orig:6d} -> {total_compact:6d}  ({total_compact/total_orig*100:.0f}%)")
est_tokens = total_compact // 4
print(f"Estimated tokens: ~{est_tokens:,}")
print(f"Lines: {sum(c.count(chr(10)) for c in all_compacted)}")

# Write combined output
with open('/tmp/retool-bundles-compacted.txt', 'w') as f:
    f.write('\n\n'.join(all_compacted))
print(f"\nWrote combined output to /tmp/retool-bundles-compacted.txt")
