# Newcomer setup review

The home screen already links to a field setup guide with live connection,
contact discovery, and a test-chat status scoped to the guide session. Its
connection action previously opened Bluetooth directly. The new two-step
connection guide opens from both the home connection card and the field guide.
It explains the chosen transport before opening the existing device picker.
Closing the guide has no radio side effects. The field guide disables its
connection button while already connected.

Bluetooth is unavailable on web in this app. USB availability follows the
existing PlatformInfo capability gate (native Android/desktop or Chrome Web
Serial). These are app/platform gates, not proof that a particular radio or
firmware supports that transport. The guide explicitly asks users to verify
the exact board and installed companion build before changing firmware. It
never flashes, changes region/frequency, sends messages, or claims connectivity.

USB already has specific permission, missing-device, busy, and timeout messages;
those mappings are retained and tested. Unknown USB failures now offer cable,
permission, device-selection, and competing-app recovery steps instead of raw
exceptions. USB picker cancellation stays silent, but other requestPort failures
are no longer incorrectly treated as cancellation. Bluetooth scan failures previously only logged; they now display
recovery steps. Bluetooth connection failures also offer recovery guidance,
while retaining raw details in diagnostic logs and existing Linux retry handling.

Existing settings remain accessible, including region, radio parameters,
companion CLI, diagnostics, and time synchronization. The wizard does not hide
or change them.

Timestamp review found direct chat uses manual HH:mm formatting, while channel
chat uses locale-aware DateFormat.Hm/Md. Neither formatter explicitly converts
its input to local time. A separate follow-up should establish timestamp
provenance and shared display semantics before changing existing history.
No timestamp or chat rendering change is included here.

New copy uses English ARB entries with generated fallback strings for other
locales; translations need review. Tests cover explicit confirmation, both
transport choices, unsupported options, returning to transport selection,
cancellation, and USB error classification. No BLE protocol changes.
