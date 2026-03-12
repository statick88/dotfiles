# Delta for Battery Plugin

## ADDED Requirements

### Requirement: Battery Hover Information
The system MUST display the "Time Remaining" (or "Charged") when the mouse enters the battery item.
The system MUST restore the percentage display when the mouse exits.

#### Scenario: User hovers over battery
- GIVEN the battery item is displaying "85%"
- WHEN the user moves the mouse over the battery item
- THEN the label changes to "2:30" (time remaining)
- AND the icon color changes to White for better contrast

#### Scenario: User moves mouse away from battery
- GIVEN the battery item is displaying "2:30" (hover state)
- WHEN the user moves the mouse away from the item
- THEN the label restores to "85%"
- AND the icon color restores to its original state (e.g., Green)

### Requirement: Correct System Settings Redirection
The system MUST open the Battery section of System Settings when clicked.

#### Scenario: User clicks on battery
- GIVEN the battery item is visible
- WHEN the user clicks the item
- THEN the system executes `open 'x-apple.systempreferences:com.apple.Battery-Settings.extension'`

## MODIFIED Requirements

### Requirement: Robust Data Parsing
The system SHALL use exact word matching for charging status to avoid false positives with "discharging".
(Previously: Used simple substring matching which caused "discharging" to be detected as "charging").
