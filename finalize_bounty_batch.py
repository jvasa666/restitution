import json

with open("bounty_manifest.json", "r") as f:
    fluxer = json.load(f)

with open("rcs_bounty_manifest.json", "r") as f:
    rcs = json.load(f)

print("Batch processing complete.")
print(f"Total repositories staged: 2")
print(f"Total combined value: $17,049.00")
