# Tutorial

> You will need an [Akash Console](https://console.akash.network) account with some credit.

## 1. Get an SSH key

Already have one? Check with `ls ~/.ssh/*.pub` and skip ahead.

Otherwise run this in Terminal (macOS, Linux) or PowerShell (Windows) and press Enter at each prompt:

```sh
ssh-keygen -t ed25519
```

It creates two files in `~/.ssh`:

- `id_ed25519` is your private key. It stays on your computer. Don't share it.
- `id_ed25519.pub` is your public key. You give this to the box so it knows it's you.

## 2. Deploy

Open the [template](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-ai-dev-box), click **Deploy** and accept a bid. No edits needed.

## 3. Add your key

Copy your public key:

```sh
pbcopy < ~/.ssh/id_ed25519.pub                       # macOS
Get-Content ~/.ssh/id_ed25519.pub | Set-Clipboard    # Windows
cat ~/.ssh/id_ed25519.pub                            # Linux, then copy it
```

In your deployment, open the **Shell** tab, type `addkey `, paste, and press Enter.

Your key is already on GitHub? `addkey your-github-username` does the same.

## 4. Connect

In your deployment's details, find the host and port forwarded to port 22. Then:

```sh
ssh -p <port> root@<host>
```

You land in tmux. Close the window whenever you like; reconnect and you're back where you left off.

**Shortcut:** add this to `~/.ssh/config` and connect with `ssh devbox`. VS Code and Cursor Remote-SSH pick it up too.

```
Host devbox
  HostName <host>
  Port <port>
  User root
```

The port changes if you redeploy, so update it then.

## 5. Log in to your agents

```sh
claude                      # follow the link, paste the code back
codex login --device-auth
opencode auth login
gemini
```

For GitHub, run `gh auth login`.

## 6. Build something

```sh
git clone https://github.com/you/your-app && cd your-app
claude
```

Disconnect any time. The agent keeps working.

## 7. Put it online

**Quick link:** `share 3000` prints a public HTTPS URL. It lasts until you press Ctrl+C.

**Deployment URL:** anything on port 3000 is served at the URL on your deployment page. Use `APP_PORT` to pick a different port. Keep it running with `pm2 start npm -- start`.

**Your own domain:**

1. In the Cloudflare dashboard, create a tunnel (Zero Trust → Networks → Tunnels).
2. Copy the token. It's the long string after `--token` in the install command Cloudflare shows.
3. In Console, add `CF_TUNNEL_TOKEN=<token>` to the env and update the deployment.
4. In the tunnel, add a public hostname, like `app.yourdomain.com`, pointing to `http://localhost:3000`.
