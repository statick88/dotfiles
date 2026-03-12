# Delta for Connectivity Plugin (Exclusivity & State)

## ADDED Requirements

### Requirement: Exclusive Menu State
The system MUST maintain a persistent state indicating if the "Network Menu" is active.
While the Network Menu is active, periodic background updates MUST NOT modify the popup items.

#### Scenario: User opens network menu
- GIVEN the user is hovering and seeing IP/Speed
- WHEN the user clicks the WiFi icon
- THEN the system saves `menu_mode: true` to state
- AND the system hides IP/Router/Speed items
- AND the system shows the network list
- AND subsequent periodic updates (every 1s) IGNORE the popup items

#### Scenario: User exits the menu
- GIVEN the network menu is open
- WHEN the mouse leaves the WiFi item area (`mouse.exited`)
- THEN the system saves `menu_mode: false` to state
- AND the system closes the popup

### Requirement: Fast Network Listing
The system MUST use `networksetup -listpreferredwirelessnetworks` for the menu, as it is non-blocking and provides real names.

## MODIFIED Requirements

### Requirement: Hover Reset
The system MUST always reset the `menu_mode` to `false` when `mouse.entered` is triggered to ensure the user starts with the "Details View".
