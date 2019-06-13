# Changelog

## v0.7.4 (2019-06-13)

### Build

* Update Auto Release Log adding v0.7.4 info with JPL ([47f33a9](https://github.com/kairops/dc-git-changelog-generator/commit/47f33a9))
* Fix docker image tag extraction ([4ae9c26](https://github.com/kairops/dc-git-changelog-generator/commit/4ae9c26))

### Docs

* Generate v0.7.3 changelog with JPL ([56be7e5](https://github.com/kairops/dc-git-changelog-generator/commit/56be7e5))

## v0.7.3 (2019-06-13)

### Build

* Update Auto Release Log adding v0.7.3 info with JPL ([6cbb9e9](https://github.com/kairops/dc-git-changelog-generator/commit/6cbb9e9))
* Fix mac ghost char typo ([d8eb8c0](https://github.com/kairops/dc-git-changelog-generator/commit/d8eb8c0))
* Calculate next release number in auto-release stage ([e5c93d1](https://github.com/kairops/dc-git-changelog-generator/commit/e5c93d1))
* Revert pipeline to last commit ([8aeaf18](https://github.com/kairops/dc-git-changelog-generator/commit/8aeaf18))
* Update to jpl v3.1.6 and review auto-release ([f90a282](https://github.com/kairops/dc-git-changelog-generator/commit/f90a282))
* Update to jpl v3.0.1 ([0cd72ed](https://github.com/kairops/dc-git-changelog-generator/commit/0cd72ed))
* Promote build in automatic releases ([5a7008d](https://github.com/kairops/dc-git-changelog-generator/commit/5a7008d))
* Fix jpl method name call ([09bd3ca](https://github.com/kairops/dc-git-changelog-generator/commit/09bd3ca))

### Docs

* Generate v0.7.2 changelog with JPL ([7f82b6f](https://github.com/kairops/dc-git-changelog-generator/commit/7f82b6f))

## v0.7.2 (2019-05-22)

### Fix

* Use the right remote url in github+ssh repositories ([52c9037](https://github.com/kairops/dc-git-changelog-generator/commit/52c9037))

### Build

* Update Auto Release Log adding v0.7.2 info with JPL ([0b8bf0c](https://github.com/kairops/dc-git-changelog-generator/commit/0b8bf0c))
* Update to jpl v3.0.0 and add auto release step ([60370ea](https://github.com/kairops/dc-git-changelog-generator/commit/60370ea))

## v0.7.1 (2019-05-17)

### Fix

* Don't show changelog title more than once ([7d6c5f3](https://github.com/kairops/dc-git-changelog-generator/commit/7d6c5f3))

### Build

* Update CHANGELOG.md to v0.7.1 with Red Panda JPL ([769ea99](https://github.com/kairops/dc-git-changelog-generator/commit/769ea99))
* Use latest alpine docker image ([e07159a](https://github.com/kairops/dc-git-changelog-generator/commit/e07159a))

## v0.7.0 (2019-05-16)

### Update

* Add debug option ([17f487b](https://github.com/kairops/dc-git-changelog-generator/commit/17f487b))

### Fix

* Remove unnecesary line break on git system call ([368a3df](https://github.com/kairops/dc-git-changelog-generator/commit/368a3df))

### Build

* Update CHANGELOG.md to v0.7.0 with Red Panda JPL ([96ffaca](https://github.com/kairops/dc-git-changelog-generator/commit/96ffaca))
* Update jpl to v2.9.1 ([29cc4de](https://github.com/kairops/dc-git-changelog-generator/commit/29cc4de))

### Docs

* Update main README ([e3431d4](https://github.com/kairops/dc-git-changelog-generator/commit/e3431d4))

## v0.6.1 (2019-05-13)

### Update

* Refactor tagDate extraction ([dc38767](https://github.com/kairops/dc-git-changelog-generator/commit/dc38767))

### Fix

* Use the right tag date ([00569ca](https://github.com/kairops/dc-git-changelog-generator/commit/00569ca))
* Get the right date for the first release ([02dde8b](https://github.com/kairops/dc-git-changelog-generator/commit/02dde8b))

### Build

* Update CHANGELOG.md to v0.6.1 with Red Panda JPL ([9fe5a19](https://github.com/kairops/dc-git-changelog-generator/commit/9fe5a19))

## v0.6.0 (2019-05-10)

### Breaking

* Convert the project to Docker Command function ([e46fc9c](https://github.com/kairops/dc-git-changelog-generator/commit/e46fc9c))

### Build

* Update CHANGELOG.md to v0.6.0 with Red Panda JPL ([02d7a4c](https://github.com/kairops/dc-git-changelog-generator/commit/02d7a4c))

## v0.5.0 (2019-05-09)

### Update

* Add unrelease section (fixes #2) ([5ca177e](https://github.com/kairops/dc-git-changelog-generator/commit/5ca177e))

### Build

* Update CHANGELOG.md to v0.5.0 with Red Panda JPL ([4a01bc8](https://github.com/kairops/dc-git-changelog-generator/commit/4a01bc8))

## v0.4.1 (2019-05-09)

### Fix

* Make changelogs to commits in the right form (fixes #3) ([d030665](https://github.com/kairops/dc-git-changelog-generator/commit/d030665))

### Build

* Update CHANGELOG.md to v0.4.1 with Red Panda JPL ([f267d5b](https://github.com/kairops/dc-git-changelog-generator/commit/f267d5b))
* Add Jenkinsfile ([425d205](https://github.com/kairops/dc-git-changelog-generator/commit/425d205))

## v0.4.0 (2019-05-09)

### Update

* Add security and deprecated items (fixes #1) ([bccdcd4](https://github.com/kairops/dc-git-changelog-generator/commit/bccdcd4))

### Build

* Update CHANGELOG.md to v0.4.0 with Red Panda JPL ([bb9d12c](https://github.com/kairops/dc-git-changelog-generator/commit/bb9d12c))

## v0.3.0 (2019-05-09)

### New

* Add docker support based on slim image ([4ddb6dd](https://github.com/kairops/dc-git-changelog-generator/commit/4ddb6dd))

### Update

* Use 'tac' command where available instead 'tail -r' ([d18a917](https://github.com/kairops/dc-git-changelog-generator/commit/d18a917))

### Fix

* Remove unsupport options on jplDockerBuild ([2854e38](https://github.com/kairops/dc-git-changelog-generator/commit/2854e38))
* Use jplDockerPush function instead native docker build Jenkins ([024eaf3](https://github.com/kairops/dc-git-changelog-generator/commit/024eaf3))

### Build

* Update CHANGELOG.md to v0.3.0 with Red Panda JPL ([24620d4](https://github.com/kairops/dc-git-changelog-generator/commit/24620d4))
* Fix release confirm stage execution conditional ([a9d7fe4](https://github.com/kairops/dc-git-changelog-generator/commit/a9d7fe4))

## v0.2.0 (2019-05-08)

### Update

* Improve markdown format ([684720c](https://github.com/kairops/dc-git-changelog-generator/commit/684720c))

### Fix

* Include the first tag in the build process ([33753da](https://github.com/kairops/dc-git-changelog-generator/commit/33753da))

### Build

* Update CHANGELOG.md to v0.2.0 with Red Panda JPL ([b578a20](https://github.com/kairops/dc-git-changelog-generator/commit/b578a20))

## v0.1.0 (2019-05-08)

### New

* Initial import ([df01a2e](https://github.com/kairops/dc-git-changelog-generator/commit/df01a2e))

### Upgrade

* Fully functional version ([666c3df](https://github.com/kairops/dc-git-changelog-generator/commit/666c3df))

### Build

* Update CHANGELOG.md to v0.1.0 with Red Panda JPL ([dadd52f](https://github.com/kairops/dc-git-changelog-generator/commit/dadd52f))
* Add Jenkinsfile ([3d4f84d](https://github.com/kairops/dc-git-changelog-generator/commit/3d4f84d))

