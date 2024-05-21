# Windows-run-compiler-explorer

Run compiler-explorer instance into github actions worker (windows vc2022)

### SECRET KEYS

You need set secrets on settings → (NGROK)

* `NGROK_AUTH_TOKEN`  Needed only for NGROK mode
* `TG_CHAT_ID` (optional) Telegram user id for get login url
* `TG_TOKEN` (optional) Telegram bot token for get message from bot


## Usage

These steps should be useful for debugging broken builds directly on the build worker. Use this project as reference and toss the steps into your project after some failing part of the build for introspection.

### Option 1 (NGROK)

1) Get the tunnel auth token at: https://dashboard.ngrok.com/auth .
2) Under the repository's settings, make a secret called `NGROK_AUTH_TOKEN`
3) If you want to send link via telegram bot make the secrets `TG_TOKEN` and `TG_CHAT_ID`
4) Trigger a `ngrok-windows-compiler-explorer` in actions page.
5) Wait until the last step which will hang forever as it connects to ngrok and sets up the reverse tunnel.
6) Wait for the message (`Open compiler-explorer from this address: http://...`) from last step in job page or from telegram bot to get url
7) Open URL and wait for ~10mins to compiler-explorer instance build and run then refresh the page to see page
9) Enjoy! ☕
10) When you're done introspecting, cancel the job.

### Option 2 (localtunnel) 

1) If you want to send link via telegram bot make the secrets `TG_TOKEN` and `TG_CHAT_ID`
2) Trigger a `compiler-explorer-win-msvc-lt` in actions page.
3) Wait for the message (`your url is: https://...`) from last step in job page (~10 min)
4) Open URL and Enjoy! ☕
5) When you're done introspecting, cancel the job.

### Option 3 (cloudflared) 

1) If you want to send link via telegram bot make the secrets `TG_TOKEN` and `TG_CHAT_ID`
2) Trigger a `compiler-explorer-win-msvc-cf` in actions page.
3) Wait for the message (`Your quick Tunnel has been created! Visit it at (it may take some time to be reachable):`) from last step in job page (~10 min)
4) Open URL below this line and Enjoy! ☕
5) When you're done introspecting, cancel the job.

