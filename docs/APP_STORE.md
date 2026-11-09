# App Store plan: NOTORYX Core Ham (iPhone)

**Status:** not submitted. The iPhone build compiles in CI but has never run on a real iPhone, and the signing job has never run.

Use NOTORYX Core Ham only after a great deal of coordination with your frequency coordinator and the other stations on your net.

## Before submitting

### Needs the owner

- [ ] Join the Apple Developer Program ($99 a year). A company also needs a D-U-N-S number.
- [ ] Register the bundle ID `com.bastionmesh.ham` and create the app in App Store Connect.
- [ ] Add a public support address or page, and publish the privacy policy at a public URL, then finish `docs/PRIVACY_POLICY.md`.
- [ ] Confirm the licences of everything the app is built from, and keep every required notice. Get advice if unsure.
- [ ] Decide whether GIF search stays. It sends search terms to GIPHY, needs an API key, and adds a third party to the privacy answers.
- [ ] Test on a real iPhone through TestFlight.
- [ ] Finish the on-air test and coordinator review, and resolve the §97.119 and §97.113(d) questions.
- [ ] Have someone check the encryption answers below.

### Set up the upload job

In App Store Connect, create a team API key with the **Admin** role, which automatic cloud signing needs. Add these GitHub Actions secrets to this repository, then run **iOS TestFlight** from the Actions tab:

| Secret | Value |
|---|---|
| `APPLE_TEAM_ID` | The 10-character team ID from your developer account |
| `ASC_KEY_ID` | The API key's ID |
| `ASC_ISSUER_ID` | The issuer ID on the API keys page |
| `ASC_KEY_P8` | The full text of the downloaded `.p8` file |

The job replaces the team ID stored in the project with yours for that build.

## App Store Connect answers

| Question | Suggested answer |
|---|---|
| Availability | United States only |
| Price | Decide before submitting |
| Encryption | `ITSAppUsesNonExemptEncryption` is **true**. The app includes on-device database encryption, encrypted backups and network TLS. Radio traffic is plain text. Answer the export questions for standard algorithms, and file any self-classification report Apple's questions call for |
| Tracking | None |
| Data collected by the developer | None. There is no developer server. Map tile, elevation, model download and GIF requests go directly to those third parties; review each against Apple's definitions, because GIF search terms may need declaring |

## Listing draft

**Name:** NOTORYX Core Ham

**Subtitle:** LoRa mesh for licensed hams

**Description:**

> NOTORYX Core Ham is a companion app for MeshCore LoRa radios running NOTORYX Ham firmware. It's for licensed US amateur radio operators.
>
> A valid amateur licence is required to transmit. Use this app only after a great deal of coordination with your frequency coordinator and the other stations in your area.
>
> • Plain-text messaging on the 70 cm and 33 cm bands, with your call sign on every transmission
> • Direct messages and channels over Bluetooth
> • Station log with ADIF and CSV export
> • Maps, line of sight and route tools
> • Field check-ins, SOS, and SALUTE and 9-Line report forms
> • Team settings by QR code or file
> • App lock and optional encrypted history on your phone
>
> Amateur radio traffic is not private: anyone listening can read it.
>
> This app is not an emergency service and does not replace 911 or other emergency services. Messages depend on radios in range and may not arrive. It is a compatible third-party app and needs separate radio hardware.

**Keywords:** ham radio,amateur radio,LoRa,mesh,MeshCore,call sign,ADIF

## Notes for the reviewer

> This app controls an external LoRa radio over Bluetooth and needs one to send messages. A demo video of the app connected to a radio is at: [ADD LINK]. Without a radio, you can open the Tools, Maps, Field guide, Settings, Licensed operator and App lock screens.
>
> Transmitting legally requires a US amateur radio licence, so the app asks the operator for a call sign. It doesn't verify licences. Radio traffic is plain text by law. Bluetooth background mode keeps the connection to the radio so incoming messages and safety alerts continue while the phone is locked.
>
> SOS and report features only send text to radios and stations the user has chosen. They don't contact emergency services, and the app says so.

## Likely review questions

- Reviewers have no radio, so the demo video matters.
- SOS and medical report wording must not suggest a guaranteed emergency service.
- Models for on-device translation are downloaded data. Be ready to explain this, or leave translation out of the iPhone build.
- The Mac App Store is a separate review. Its sandbox exception for USB serial may be refused.
