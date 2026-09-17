# Managing Secrets in Dotfiles

Storing secrets (API keys, SSH keys, configuration files containing credentials like `.npmrc`, `.rclone.conf`, etc.) directly in your git repository is extremely dangerous, even if the repository is private.

Here are the best, industry-standard options for managing your secrets across multiple machines seamlessly.

## 1. 1Password CLI (Recommended for UI/UX & Easiest)
If you already use 1Password as your password manager, the [1Password CLI (op)](https://developer.1password.com/docs/cli/) is arguably the easiest approach.

**How it works:**
1. You store your secrets/config files as entries in your 1Password vault.
2. In your dotfiles repo, you create template files referencing the 1Password items.
3. You use the `op inject` command to build the config files dynamically on the local machine without checking the cleartext into git.

**Example Setup:**
```bash
# Add a secret environment variable to 1Password
op item create --category Login --title "My API Key" credential="your_secret_key"

# In your .zshrc or .bash_profile:
export MY_API_KEY=$(op item get "My API Key" --fields credential)
```

For full config files (like `.rclone.conf`), 1Password allows you to attach a Document and pull it locally via CLI.

## 2. SOPS (Secrets OPerationS) by Mozilla (Recommended for GitOps/Power Users)
[SOPS](https://github.com/getsops/sops) is an editor of encrypted files that supports YAML, JSON, ENV, INI, and BINARY formats and encrypts with AWS KMS, GCP KMS, Azure Key Vault, age, and PGP.

**How it works:**
1. You generate an `age` key on your local machine (e.g., `age-keygen -o ~/.config/sops/age/keys.txt`).
2. You place the *public* key into a `.sops.yaml` configuration file inside your dotfiles repo.
3. You run `sops config.yaml`, which opens the file in your `$EDITOR`. You add your secrets in plain text.
4. When you save and quit, SOPS encrypts the values but leaves the keys clear. You can safely commit this file to git!
5. On your new machine, you transfer the *private* `age` key securely, and run `sops -d config.yaml > decoded.yaml`.

This allows your secrets to live **inside** your git repo safely encrypted.

## 3. Local Environment Variables (The Old School Way)
If you just have a few API keys for local scripts, you can keep them out of git completely:

1. Add `~/.secrets.sh` to your global `~/.gitignore` (or your repo's `.gitignore`).
2. Source it in your `zshrc` or `fish` configs:
```bash
if [ -f ~/.secrets.sh ]; then
    source ~/.secrets.sh
fi
```
3. You manually populate `.secrets.sh` on each new machine you set up.

## The choice
- Use **1Password CLI** if you want ultimate convenience across OSes and already pay for a password manager.
- Use **SOPS** with `age` if you want a fully open-source, GitOps-style solution that tracks the encrypted state inside your git repo.