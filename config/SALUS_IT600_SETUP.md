# Salus iT600 Integration Setup

## Two integrations available

### 1. Salus iT600 Cloud (recommended for UG800)

- **Path:** `config/custom_components/salus_it600_cloud/`
- **Setup:** Uses your **Salus Smart Home app email and password** (no gateway IP or EUID).
- **Works with:** UG800 and other gateways; uses Salus Cloud API and AWS IoT MQTT.
- **Add integration:** Settings → Devices & Services → Add Integration → search **Salus iT600 Cloud** → enter email and password.

### 2. Salus iT600 (local gateway)

- **Path:** `config/custom_components/salus/`
- **Setup:** Gateway IP + 16-character EUID; local communication (pyit600).
- **Note:** Decryption often fails with UG800; use Cloud integration instead.

## Add the integration in Home Assistant

1. Restart Home Assistant (so it loads the custom component).
2. Go to **Settings** → **Devices & Services**.
3. Click **+ Add Integration**.
4. Search for **Salus iT600**.
5. Enter:
   - **Host:** IP address of your UGE600 gateway (e.g. `192.168.1.xxx`).
   - **Token:** The 16-character EUID from the label on the bottom of the gateway (e.g. `001E5E0D32906128`).
   - **Name:** Optional friendly name (e.g. "Salus Gateway").
6. Submit the form. Your Salus devices should appear under **Devices & Services** and as entities.

## If you see "Unknown error" or decryption fails

The logs showed: **decryption failed** (response length not a multiple of block length). That usually means the EUID does not match what the gateway expects for decryption, or your gateway model/firmware uses a different protocol.

1. **Try EUID exactly:** **0000000000000000** (16 zeros). Many gateways accept this when the printed EUID fails.
2. **Then try your Coordinator EUID:** From the Salus app (Gateway info screen): **Coordinator EUID** — use exactly those 16 characters (e.g. `001E5E0902AFC82E`), no spaces.
3. **Recheck your EUID:** Exactly 16 characters, no spaces. If the label has more than 16 characters, use only the **first 16**.
4. **Enable Local WiFi Mode** in the Salus Smart Home app (see below).

### If decryption still fails (e.g. with UG800)

The **pyit600** library and integration are documented for **UG600** gateways. If you have a **UG800** (newer model), the gateway may use a different response format or encryption, which can cause decryption to fail even with the correct EUID and Local WiFi Mode enabled.

- **Report it to the integration maintainers** so they can add UG800 support or fix the protocol:
  - Open an issue at: https://github.com/epoplavskis/homeassistant_salus/issues
  - Include: **Model** (e.g. UG800), **Coordinator EUID** (from app), **Software Version** and **Coordinator Version** (from Gateway info in app), and that you get "Gateway response could not be decrypted" with both your EUID and `0000000000000000`.
- You can also open an issue on the library: https://github.com/epoplavskis/pyit600/issues

## If connection fails

- Try EUID **0000000000000000** if the printed EUID does not work.
- Enable **Local WiFi Mode** in the Salus Smart Home app:
  - Open the app and sign in.
  - Double-tap the Gateway → open info screen.
  - Tap the gear icon.
  - Set **Disable Local WiFi Mode** to **No**.
  - Save and restart the gateway (unplug/replug USB).

## Fix file ownership (if integration does not load)

If Home Assistant cannot load the integration, fix ownership of the custom component (run from the project root):

```bash
sudo chown -R $(whoami):$(whoami) config/custom_components/salus
```

Then restart Home Assistant.
