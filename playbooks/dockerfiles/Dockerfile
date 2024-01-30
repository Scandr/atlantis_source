FROM ghcr.io/runatlantis/atlantis:latest

USER atlantis

COPY --chown=atlantis:atlantis --chmod=600 ./creds/.aws /home/atlantis/.aws
COPY --chown=atlantis:atlantis --chmod=664 ./creds/.terraformrc /home/atlantis/
COPY --chown=atlantis:atlantis --chmod=664 ./creds/key.json /opt/yandex_cloud/key.json
COPY --chown=atlantis:atlantis --chmod=664 ./creds/id_rsa.pub /opt/yandex_cloud/id_rsa.pub