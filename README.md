# Linux Log Analyzer - DevOps Project

Prepared by: Aditya Khot

## Project Summary
Automates Linux server log analysis and publishes a periodic report using GitHub Actions. Useful as a demo project covering Linux commands, shell scripting, Git, CI/CD, and cloud automation.

## Files
- `analyze.sh` - Bash script that parses system logs and builds `report.txt`.
- `.github/workflows/report.yml` - GitHub Actions workflow (runs every 6 hours).
- `index.html` - Simple GitHub Pages site to download/view `report.txt`.
- `Dockerfile` - Optional container to serve site with nginx.
- `report.txt` - Example generated report (included).

## How to use
1. Create a new GitHub repository and push this project.
2. (Optional) Enable GitHub Pages from the repository settings (source: `gh-pages` branch or `main` if you deploy to main).
3. GitHub Actions will run on schedule and generate `report.txt`.
4. The workflow also uses `peaceiris/actions-gh-pages` to publish site content to GitHub Pages.

## Local testing
- Make script executable:
  ```
  chmod +x analyze.sh
  ./analyze.sh
  cat report.txt
  ```

## Notes for demo
- On GitHub Actions runners, system logs like `/var/log/syslog` may not exist; the script creates a sample report automatically for CI demo.
- To analyze real servers, provide access to log files or mount them into the runner/CI environment.

## Customize
- Change the cron schedule in `.github/workflows/report.yml`.
- Extend `analyze.sh` to parse `auth.log`, filter by services, or generate HTML reports.

## Contact
Prepared for INT331: Fundamentals of DevOps.
