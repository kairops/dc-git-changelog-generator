# Docker Command: GIT Changelog Generator

Simply Git Changelog Generator writen in BASH

Its a part of the Docker Command series

## Usage

Execute the following within your repository folder:

- Using Bash: `cd [git-repository-dir]; ./entrypoint.sh > CHANGELOG.md`
- Using Docker: `cd [git-repository-dir]; docker run --rm -v $(pwd):/workspace kairops/dc-git-changelog-generator > CHANGELOG.md`
- Using docker-command-launcher: `kd git-changelog-generator [git-repository-dir] > CHANGELOG.md`

If you use a repository tag as a parameter then you get the thangelog only for that tag. As an example:

```shell
kd git-changelog-generator . v1.0.0
```

Assuming there is a git repository in the directory that your are executing the command, the result of the execution will be shown in the console output and you get the changelog of the v1.0.0 tag of the repository

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
