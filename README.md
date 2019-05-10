# Docker Command: GIT Changelog Generator

Simply Git Changelog Generator writen in BASH

Its a part of the Docker Command series

## Usage

Execute the following within your repository folder:

- Using Bash: `./entrypoint.sh > CHANGELOG.md`
- Using Docker: `docker run --rm -v $(pwd):/workspace kairops/dc-git-changelog-generator > CHANGELOG.md`
- Using docker-command-launcher: `kd git-changelog-generator > CHANGELOG.md`

## Considerations

Make the commits on your repository following [Keep Changelog](https://keepachangelog.com/en/1.0.0/) rules and these keywords:

- Breaking - for a backwards-incompatible enhancement.
- New - implemented a new feature.
- Upgrade - for a dependency upgrade.
- Update - for a backwards-compatible enhancement.
- Fix - for a bug fix.
- Build - changes to build process only.
- Docs - changes to documentation only.
- Security - for security skills.
- Deprecated - for deprecated features.
