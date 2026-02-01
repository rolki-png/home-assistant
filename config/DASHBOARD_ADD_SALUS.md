# Add Salus thermostats to your Home dashboard

Your **Home** dashboard is stored in the UI (storage), not in the YAML file we edited. So the Salus section does not appear until you add it there.

## Add Salus via the UI (recommended)

1. Open **Home Assistant** and go to the **Home** dashboard (sidebar → Home).
2. Click the **three dots** (top right) → **Edit dashboard**.
3. Click **Add card** (bottom right).
4. Choose **Mushroom climate card** (or **Climate** if you don’t see Mushroom).
5. Configure:
   - **Entity:** `climate.home_konyha`
   - **Name:** `Bedroom (ground floor)`
   - **Icon:** `mdi:thermometer`
   - Enable **Show temperature control** and **Collapsible controls** if available.
6. Click **Save**.
7. Click **Add card** again and add the second thermostat:
   - **Entity:** `climate.home_konyha_emelet`
   - **Name:** `Kitchen (first floor)`
   - **Icon:** `mdi:thermometer`
8. Click **Save**, then **Done** (or **Save** on the dashboard).

Place the new cards where you want (e.g. at the top, after the weather chips). Drag the cards to reorder.

If your thermostats are the other way round (e.g. `home_konyha` is kitchen and `home_konyha_emelet` is bedroom), swap the entities or names in the two cards.

## Optional: Use the YAML dashboard instead

The file `config/dashboards/main-dashboard.yaml` already contains the Salus section with the correct labels. To use it:

1. In **Settings** → **Dashboards**, add a new dashboard.
2. Set **Dashboard type** to **YAML** and set the filename to `dashboards/main-dashboard.yaml` (if your HA is configured to load from that path).
3. Or copy the full content of `main-dashboard.yaml` into the **Raw configuration** of your Home dashboard (this replaces the current dashboard with the YAML version).

If you use the YAML dashboard, the Salus section will show **Bedroom (ground floor)** and **Kitchen (first floor)**.
