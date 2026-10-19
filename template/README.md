# AI Dev Box

A cloud dev box with Claude Code, Codex, OpenCode and Gemini CLI ready to go.

[![Deploy on Akash](https://raw.githubusercontent.com/akash-network/console/refs/heads/main/apps/deploy-web/public/images/deploy-with-akash-btn.svg)](https://console.akash.network/new-deployment?step=edit-deployment&templateId=akash-network-awesome-akash-ai-dev-box)

## Inside

- Claude Code, Codex, OpenCode, Gemini CLI
- Node LTS, Python 3.13, uv, pm2, git, gh, tmux
- Caddy and cloudflared for putting apps online

## Use it

1. Under SSH key, click **Generate** (or paste your own public key), then deploy.
2. Connect with the SSH command from your deployment's details.
3. Run `claude` and log in.
4. Serve your app on port 3000 and it's live at the deployment URL, or run `share <port>` for a quick HTTPS link.

Only `/root` is saved, and closing the lease deletes it. Push your work.

Source, full docs and tutorial: https://github.com/YOUR_GITHUB_USER/ai-dev-box
