\##################################################################################################################################################################################################################################



\##################################################################################################################################################################################################################################



Author: Yash Gawde



\##################################################################################################################################################################################################################################



\##################################################################################################################################################################################################################################

## Tooling Options

- **git filter-repo** (recommended)
  - Modern, fast, flexible. Replaces `filter-branch`/BFG in most workflows.
  - Install (Python-based):
    ```bash
    pipx install git-filter-repo  # or: pip install git-filter-repo
    ```
- **BFG Repo-Cleaner** (simple, opinionated)
  - Great for removing whole files or replacing common secret patterns quickly.
  - Requires Java.

Use whichever fits your scenario (examples below include both).

---

## Golden Rules Before You Start

1. **Back up** the repo (or clone a fresh copy) before history rewrite.
2. **Pause merges** and coordinate with collaborators.
3. **Rotate credentials** as if they’re already compromised.
4. **Plan a communication**: post-clean instructions for your team.

---

## Step 1: Identify Sensitive Content

### A) Quick & dirty grep (adjust patterns)
```bash
# filenames that might contain secrets
git ls-files | grep -Ei '(secret|password|key|token|creds|config)'

# naive string scans in history (expensive on big repos)
git rev-list --all | while read rev; do
  git grep -I -n -e 'password=' -e 'aws_secret_access_key' -e 'api_key' $rev
done




\##########################################################################################################################################################################################################################################

1. Remove files containing sensitive data

# Run from a fresh clone to avoid local junk
git filter-repo --path config/creds.yml --invert-paths

\##########################################################################################################################################################################################################################################

2\. Replace sensitive data within files

# Replace a literal value with SAFE_PLACEHOLDER
git filter-repo --replace-text "$tmpFile"

\##########################################################################################################################################################################################################################################

3\. Push Rewritten History

# Push all branches & tags
git push origin --force --all
git push origin --force --tags

\##########################################################################################################################################################################################################################################

# Note: Remove branch protection to push the rewritten history back to remote.
#       A PR won't work in this case as it will only apply fresh changes to current commit, however not rewrite history for old commits.


\##########################################################################################################################################################################################################################################
\##########################################################################################################################################################################################################################################
