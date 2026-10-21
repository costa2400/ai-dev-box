# AI Dev Box

A cloud dev box on Akash with Claude Code, Codex, OpenCode and Gemini CLI ready to go.

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-ai-dev-box)

## What's inside

- Claude Code, Codex, OpenCode, Gemini CLI
- Node LTS (mise), Python 3.13 (uv), pip, pm2
- git, gh, tmux, ripgrep, fd, jq, sqlite, build tools
- Caddy and cloudflared for putting apps online

## Quick start

1. Click **Deploy on Akash**, deploy and accept a bid.
2. In your deployment, open the **Shell** tab and add your SSH key:

```sh
addkey ssh-ed25519 AAAA...        # paste your public key
addkey your-github-username       # or use the keys on your GitHub account
```

3. Connect using the host and port forwarded to port 22 in your deployment's details:

```sh
ssh -p <port> root@<host>
```

First boot takes a bit longer while the box sets itself up. New to this? Read the [tutorial](TUTORIAL.md).

## Log in to your agents

```sh
claude
codex login --device-auth
opencode auth login
gemini
```

## Put your app online

- **Port 3000** is live at your deployment's URL. Nothing to set up.
- **`share 5173`** gives any port a public HTTPS link. No account needed.
- **Your own domain:** set `CF_TUNNEL_TOKEN`. See the [tutorial](TUTORIAL.md#7-put-it-online).

## Settings

| Env var | |
|---|---|
| `APP_PORT` | Port served at the deployment URL. Default `3000`. |
| `CF_TUNNEL_TOKEN` | Cloudflare Tunnel token for a custom domain. Optional. |
| `SSH_PUBKEY` | Public key to authorize at boot, instead of `addkey`. Optional. |

Any other env var you add, like `ANTHROPIC_API_KEY`, shows up in your SSH sessions.

## Good to know

- Only `/root` is kept across restarts. Closing the deployment, or letting it run out of funds, deletes everything. Push your work.
- The provider can see inside your container. Use API keys you can revoke.
- It's a container, so there's no Docker, systemd or ufw. Open ports are set in the SDL.
- `apt install` works but resets on restart. Anything installed with npm, pip, uv or mise stays.
- Runs as root. `claude --dangerously-skip-permissions` works. Codex runs without its own sandbox, which can't work in a container. Puppeteer needs `--no-sandbox`.
- Logins open in tmux, so agents keep running when you disconnect. Turn it off with `touch ~/.notmux`.
- SSH says the host key changed after a redeploy? Run `ssh-keygen -R "[host]:port"`.

## Build it yourself

```sh
docker build -t ai-dev-box .
```

## License

MIT
