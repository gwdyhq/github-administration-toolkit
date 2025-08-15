##################################################################################################################################################################################################################################

##################################################################################################################################################################################################################################

Author: Yash Gawde

##################################################################################################################################################################################################################################

##################################################################################################################################################################################################################################



# GitHub Administration Toolkit



A collection of hands-on projects demonstrating advanced GitHub administration tasks,  

including migrating large files to GitHub using \*\*Git Large File Storage (LFS)\*\* and  

removing sensitive data from Git commit history.  



These projects are based on real-world scenarios I have handled as part of my DevOps and  

infrastructure engineering role, ensuring repository performance, security, and compliance.



---



\## 👤 My Role in These Tasks

As a \*\*Senior DevOps \& Infrastructure Engineer\*\*, I have:

\- Planned and executed repository migrations for projects with large binary assets.

\- Implemented \*\*Git LFS\*\* to optimize storage and improve clone/pull performance.

\- Conducted sensitive data cleanup from Git commit history to ensure security compliance.

\- Coordinated with development teams to handle branch protection, re-cloning procedures, and communication during disruptive operations.

\- Automated repetitive admin workflows with scripts to ensure repeatability and reduce human error.



---



\## 📂 Table of Contents



| Project: Bitbucket Server to GitHub Cloud migration | Description: Migrate all repositories for client from Bitbucket (on-premise installation) to GitHub (Cloud) |

| \[lfs-migration](lfs-migration/README.md) | Guide \& scripts for migrating large files into GitHub using Git LFS, including detection, conversion, and best practices. |



| Project: Remove sensitive credentials from GitHub repos | Description: Scan GitHub repos to find sensitive data, upload them into AWS secret manager or parameter store and delete them from repos. |

| \[history-cleanup](history-cleanup/README.md) | Workflow \& automation scripts to remove sensitive data from Git commit history using `git filter-repo` and `BFG Repo-Cleaner`. |



---



\## 🛠 Technologies \& Tools Used

\- \*\*Git\*\* – Version control

\- \*\*GitHub\*\* – Remote repository hosting \& administration

\- \*\*Git Large File Storage (LFS)\*\* – For handling large binary assets

\- \*\*git filter-repo\*\* – History rewrite for file/string removal

\- \*\*PowerShell Scripting\*\* – Automation of repetitive admin workflows

\- \*\*Windows\*\* – Execution environment for scripts

---



\## 📌 Admin Best Practices Summary



\### 1. Repository Size Management

\- While doing migration from Bitbucket to GitHub, there were repos identified with large files > 100 MB, which were not accepted on GitHub Cloud. 

\- GitHub LFS was used to upload the large files onto GitHub LFS Server (backend storage on S3) and the objects are referenced using pointers in the actual GitHub repo

\- This also keeps the repository size small to improve clone and CI/CD performance.





\### 2. Security \& Secret Hygiene

\- Secrets like credentials/private keys shouldn't be commited directly into a repository.

\- Use `.gitignore` to prevent accidental commits of sensitive files.

\- Enable GitHub secret scanning to detect exposed credentials.

\- Immediately rotate any leaked credentials, even after history cleanup.



\### 3. Safe History Rewrites

\- Always work from a fresh clone before rewriting history.

\- Coordinate with team members; pause merges during rewrite operations.

\- Force-push only after disabling branch protection temporarily.

\- Document and share re-clone/reset steps with the team.



\### 4. Automation for Consistency

\- Use scripts for scanning, migration, and cleanup to avoid manual errors.

\- Maintain version-controlled runbooks/playbooks for admin tasks.

\- Test scripts on a staging/forked repo before running on production repos.



\##################################################################################################################################################################################################################################

\##################################################################################################################################################################################################################################

