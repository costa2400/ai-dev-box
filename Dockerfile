FROM ubuntu:24.04
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive LANG=C.UTF-8 \
    MISE_DATA_DIR=/root/.local/share/mise \
    PATH=/root/.local/share/mise/shims:/root/.local/bin:$PATH \
    IS_SANDBOX=1 NO_BROWSER=true APP_PORT=3000

# System packages, cloudflared. Shipped host keys are removed; each box generates its own.
RUN apt-get update && apt-get install -y --no-install-recommends \
      openssh-server sudo tini ca-certificates curl wget git gh tmux ripgrep fd-find jq htop \
      nano vim less unzip zip build-essential sqlite3 caddy ncurses-term iproute2 dnsutils \
 && ln -s /usr/bin/fdfind /usr/local/bin/fd \
 && curl -fsSLo /tmp/cf.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb \
 && dpkg -i /tmp/cf.deb && rm -rf /tmp/cf.deb /var/lib/apt/lists/* /etc/ssh/ssh_host_*

COPY --from=jdxcode/mise:latest /usr/local/bin/mise /usr/local/bin/mise

# Runtimes and agents install into /root so they persist on the volume.
# /root is moved to /opt/seed in the same layer; the entrypoint copies it onto a fresh volume.
RUN curl -fsSL https://github.com/astral-sh/uv/releases/latest/download/uv-x86_64-unknown-linux-gnu.tar.gz \
      | tar xz --strip-components=1 -C /usr/local/bin \
 && mise use -g node@lts && uv python install 3.13 --default \
 && py=$(python3 -c 'import sys; print(sys.prefix)') && rm -f $py/lib/python3.13/EXTERNALLY-MANAGED \
 && ln -s $py/bin/pip3 /root/.local/bin/pip && ln -s $py/bin/pip3 /root/.local/bin/pip3 \
 && npm i -g @anthropic-ai/claude-code @openai/codex opencode-ai @google/gemini-cli pm2 \
 && npm cache clean --force && rm -rf /root/.cache \
 && touch /root/.seeded && mv /root /opt/seed && mkdir -m 700 /root

COPY rootfs/ /
EXPOSE 22 80
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint"]
