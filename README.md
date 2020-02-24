# Webra1n As a Service
Installer for headless devices that will install Checkra1n and add Webra1n As a Service on the system.

## How to run
```bash
git clone https://github.com/jusdepatate/webra1n-as-a-service
cd webra1n-as-a-service
bash MAIN.sh
```

### Now what ?
- You can access Webra1n (port `80` by default, you can edit the port by editing the [`webra1n.service`](/webra1n.service) at line 13)
- You can access Checkra1n on SSH (port `22` by default, default user/password is `checkra1n`/`checkra1n` and is sudoer for all checkra1n-related executables)

### How to uninstall
`bash MAIN.sh uninstall`

## To be done
- [~~Checkra1n Downloader~~ ✅](/checkra1n-downloader/checkra1n-downloader.sh)
- [~~Webra1n Service file~~ ✅](/webra1n.service)
- Access point creator
- [~~user creator for using `checkra1n` over SSH instead of HTTP~~ ✅](/MAIN.sh)
- Raspberry Pi image

## Warning
- **There is only support for Systemd**
- I am absolutely not a pro, feel free to examinate code, open an issue or a PR if you have any type of idea.
