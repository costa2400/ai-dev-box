# Tutorial

> You will need an [Akash Console](https://console.akash.network) account with some credit.

## 1. Deploy

Open the [template](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-ai-dev-box). Under **SSH key**, click **Generate**. You get `keypair.zip` with two files:

- `id_rsa` is your private key. It stays on your computer. Don't share it.
- `id_rsa.pub` is your public key. Console puts it on the box so it knows it's you.

Already use SSH keys? Paste the contents of `~/.ssh/id_ed25519.pub` instead and skip the zip.

Click **Deploy** and accept a bid.

## 2. Connect

On macOS or Linux:

```sh
mkdir -p ~/akash-key && unzip -o ~/Downloads/keypair.zip -d ~/akash-key
chmod 600 ~/akash-key/id_rsa
```

Then copy the SSH command from your deployment's details and run it. On Windows, unzip with Explorer and run the same `ssh` command in PowerShell.

You land in tmux. Close the window whenever you like; reconnect and you're back where you left off.

**Shortcut:** add this to `~/.ssh/config` and connect with `ssh devbox`. VS Code and Cursor Remote-SSH pick it up too.

```
Host devbox
  HostName <host>
  Port <port>
  User root
  IdentityFile ~/akash-key/id_rsa
```

The port changes if you redeploy, so update it then.

## 3. Log in to your agents

```sh
claude                      # follow the link, paste the code back
codex login --device-auth
opencode auth login
gemini
```

For GitHub, run `gh auth login`.

## 4. Build something

```sh
git clone https://github.com/you/your-app && cd your-app
claude
```

Disconnect any time. The agent keeps working.

## 5. Put it online

**Quick link:** `share 3000` prints a public HTTPS URL. It lasts until you press Ctrl+C.

**Deployment URL:** anything on port 3000 is served at the URL on your deployment page. Use `APP_PORT` to pick a different port. Keep it running with `pm2 start npm -- start`.

**Your own domain:**

1. In the Cloudflare dashboard, create a tunnel (Zero Trust → Networks → Tunnels).
2. Copy the token. It's the long string after `--token` in the install command Cloudflare shows.
3. In Console, add `CF_TUNNEL_TOKEN=<token>` to the env and update the deployment.
4. In the tunnel, add a public hostname, like `app.yourdomain.com`, pointing to `http://localhost:3000`.
