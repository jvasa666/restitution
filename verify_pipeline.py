import json

manifests = ["bounty_manifest.json", "rcs_bounty_manifest.json"]
total = 0

for m in manifests:
    with open(m, "r") as f:
        data = json.load(f)
        reward = data.get("reward", 0)
        if "modules" in data:
            reward = sum(mod.get("reward", 0) for mod in data["modules"])
        total += reward
        print(f"Loaded {data.get('repository')} - {data.get('title', 'Modules')} : ${reward:,.2f}")

print(f"Total Staged Bounty Value: ${total:,.2f}")
