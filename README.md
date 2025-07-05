
# Residence Permit Script for ESX

This script allows players with specific jobs (customs office or police) to issue a **residence permit** item using an in-game command and a user-friendly input dialog.

---

## ✅ Features

* Custom command (`/residence`) to issue residence permits.
* Supports ESX jobs: `customsoffice` and `police`.
* Adds an item (`residence_permit`) with detailed metadata:

  * First Name
  * Last Name
  * Date of Birth
  * Validity Period (From - To)
* When used from inventory, the item shows its data in a styled notification.
* Anti-abuse: unauthorized job roles cannot use the command or issue items.

---

## 📦 Requirements

* [ESX Legacy](https://github.com/esx-framework/esx_core)
* [ox\_lib](https://overextended.dev/ox_lib/docs/) (for input UI)
* [ox\_inventory](https://overextended.dev/ox_inventory/) (for metadata support)

---

## ⚙️ Installation

1. Add the script to your server’s `resources` folder.

2. In your `server.cfg`, make sure dependencies are started before this script:

```cfg
ensure ox_lib
ensure es_extended
ensure ox_inventory
ensure residence_permit  # Replace with your script folder name
```

3. Add the `residence_permit` item to `ox_inventory/data/items.lua` (or your items config file):

```lua
['residence_permit'] = {
    label = 'Residence Permit',
    weight = 100,
    stack = false,
    close = true,
    description = true -- uses metadata.description
},
```

> 🔹 This ensures the item shows player-specific info such as name, birth date, and validity when hovered in the inventory.

---

## 🧾 Usage

### Command:

```bash
/residence
```

### Steps:

1. Player must have job `customsoffice` or `police`.
2. Command opens a form to fill in personal details.
3. The permit is created and added to the player's inventory.
4. When used from the inventory, the metadata is shown in a notification.

---

## 🛡️ Anti-Cheat Notice

* The script checks job role before allowing permit creation.
* Unauthorized attempts are logged to the server console.
* Optional: player can be kicked (`DropPlayer`) on violation.

---

## 🧠 Customization

* Change job names in the script if you're using different ones.
* Change the item name (`residence_permit`) if desired.
* Translate messages and prompts as needed.

---

## ❓ Support

Need help or want to expand the system (e.g. document viewer, database logging, or expiration check)?
Feel free to contact the script author or create an issue if hosted on GitHub.
