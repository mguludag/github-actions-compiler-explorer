# Windows-run-compiler-explorer

Run compiler-explorer instance into github actions worker (windows vc2022)

### SECRET KEYS

You need set secrets on settings → (NGROK)

* `NGROK_AUTH_TOKEN`  Needed only for NGROK mode
* `PASSWORD`  windows user password
* `TG_CHAT_ID` (optional) Telegram user id for get login url
* `TG_TOKEN` (optional) Telegram bot token for get message from bot


## Usage

These steps should be useful for debugging broken builds directly on the build worker. Use this project as reference and toss the steps into your project after some failing part of the build for introspection.

### Option 1 (Easy way 🚘) 

1) Get the tunnel auth token at: https://dashboard.ngrok.com/auth .
2) Under the repository's settings, make a secrets called `NGROK_AUTH_TOKEN`, `PASSWORD`
3) If you want to send link via telegram bot make the secrets `TG_TOKEN` and `TG_CHAT_ID`
4) Trigger a `ngrok-windows-compiler-explorer` in actions page.
5) Wait until the last step which will hang forever as it connects to ngrok and sets up the reverse tunnel.
6) Wait for the message (`Open compiler-explorer from this address: http://...`) from last step in job page or from telegram bot to get url
7) Open URL and wait for ~10mins to compiler-explorer instance build and run then refresh the page to see page
9) Enjoy! ☕
10) When you're done introspecting, cancel the job.


## Useful Info

* Runners can run jobs for up to 6 hours. So you have about 6 hours minus the minute setup time to poke around in these runners.
* If using for introspection, add the [`continue-on-error`](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/workflow-syntax-for-github-actions) property to the failing step before these remote connection steps.

## Future

Maybe as a GitHub Action? Oh well, this is fairly simple anyway. Or using something more FOSS than ngrok like https://github.com/TimeToogo/tunshell ?

## Similar Projects

These projects also allow remote introspection of very temporary environments like in GitHub Actions or other environments. 

* Shell-Only (macOS, Linux, and also Windows)
  * https://tunshell.com
* macOS VNC
  * https://github.com/dakotaKat/fastmac-VNCgui
