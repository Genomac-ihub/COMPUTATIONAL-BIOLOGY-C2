# Setting Up SSH for GitHub

A beginner-friendly guide to configuring SSH authentication for GitHub.

## What is SSH?

SSH (Secure Shell) allows you to connect to GitHub without entering your username and password every time you interact with your repositories. It's more secure and convenient than HTTPS authentication.

---

## Step 1: Check for Existing SSH Keys

Before generating a new key, check if you already have one:

```bash
ls -al ~/.ssh
```

Look for files named `id_rsa.pub`, `id_ed25519.pub`, or similar. If you see these, you can skip to [Step 4](#step-4-add-the-ssh-key-to-github).

---

## Step 2: Generate a New SSH Key

Create a new SSH key using your GitHub email address:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

> **Note:** If your system doesn't support Ed25519, use RSA instead:
> ```bash
> ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
> ```

When prompted:
- **File location**: Press `Enter` to accept the default location (`~/.ssh/id_ed25519`)
- **Passphrase**: Enter a secure passphrase (optional but recommended for added security)

---

## Step 3: Add Your SSH Key to the ssh-agent

Start the ssh-agent in the background:

```bash
eval "$(ssh-agent -s)"
```

Add your private key to the ssh-agent:

```bash
ssh-add ~/.ssh/id_ed25519
```

> **Note:** If you used RSA, replace `id_ed25519` with `id_rsa`

---

## Step 4: Add the SSH Key to GitHub

### Copy Your Public Key

Display and copy your public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Select and copy the entire output (it starts with `ssh-ed25519` or `ssh-rsa`).

### Add to GitHub

1. Go to [GitHub.com](https://github.com) and sign in
2. Click your profile photo in the top-right corner
3. Click **Settings**
4. In the sidebar, click **SSH and GPG keys**
5. Click **New SSH key** or **Add SSH key**
6. In the "Title" field, add a descriptive label (e.g., "My Laptop" or "Work Computer")
7. Paste your key into the "Key" field
8. Click **Add SSH key**
9. If prompted, confirm your GitHub password

---

## Step 5: Test Your Connection

Verify that everything is set up correctly:

```bash
ssh -T git@github.com
```

You should see a message like:

```
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

If you see this, you're all set! 🎉

---

## Step 6: Using SSH with GitHub

### Cloning Repositories

When cloning a repository, use the SSH URL:

```bash
git clone git@github.com:username/repository.git
```

### Switching Existing Repos from HTTPS to SSH

If you already have a repository cloned with HTTPS, switch it to SSH:

```bash
cd /path/to/your/repo
git remote set-url origin git@github.com:username/repository.git
```

Verify the change:

```bash
git remote -v
```

---

## Troubleshooting

### Permission Denied (publickey)

If you get a "Permission denied" error:
- Make sure you added the correct public key to GitHub
- Verify the ssh-agent is running: `eval "$(ssh-agent -s)"`
- Ensure your key is added: `ssh-add -l`

### Wrong Key Being Used

If you have multiple SSH keys:
```bash
ssh-add -D  # Remove all keys
ssh-add ~/.ssh/id_ed25519  # Add the correct key
```

---

## Additional Resources

- [GitHub SSH Documentation](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

---

## License

Feel free to use and share this guide!