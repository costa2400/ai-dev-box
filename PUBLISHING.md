# Publishing

## Image

1. Replace `YOUR_GITHUB_USER` in `template/deploy.yaml` and `template/README.md`.
2. Push this repo to GitHub as a public repo named `ai-dev-box`.
3. Docker Hub: create an access token. In the GitHub repo settings, add variable `DOCKERHUB_USERNAME` and secret `DOCKERHUB_TOKEN`.
4. `git tag v1.0.0 && git push --tags`. CI pushes `:1`, `:1.0.0` and `:latest` to GHCR and Docker Hub.
5. On GitHub, open the package settings and set visibility to **public**. New GHCR packages start private and Akash can't pull them.

## Test deploy

Upload `template/deploy.yaml` in Console and check:

- [ ] Generated key and Console's SSH command both work
- [ ] `claude --dangerously-skip-permissions` starts
- [ ] Codex can run shell commands
- [ ] Port 3000 is served at the deployment URL
- [ ] `share 3000` prints a working link
- [ ] Files in `/root` survive a restart

Note the cost and add it to the README.

## awesome-akash

1. Fork [akash-network/awesome-akash](https://github.com/akash-network/awesome-akash).
2. Copy `template/` to `ai-dev-box/`.
3. In the main README, add `- [AI Dev Box](ai-dev-box)` under **Tools**, in alphabetical order.
4. Open a PR titled `Add AI Dev Box to Tools`.

The Deploy button works once the PR is merged.
