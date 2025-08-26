### Release Process 🚀

We use [`release-please-action`][release-please-action-link] to automate versioning and changelog generation, along with a GitHub workflow that automatically publish the templates to [brickhub.dev][brickhub_link].

### How it works:

- 📌 **On Every Commit to main:**
    - Commits are analyzed using [Conventional Commits][conventional_commits_link].
    - If a version bump is needed, a **release PR** is automatically created or updated by [`release-please-action`][release-please-action-link].
    - The **release PR** includes:
        - An updated `CHANGELOG.md`
        - A version bump in `brick.yaml`

    ##### 💡 Notes

    - Release PR's are created **per template**.
    - The GitHub Action workflow that automates the release process is configured in `.github/workflows/release_please.yaml`
    - release-please settings are defined in `.release-please-config.json` and `.release-please-manifest.json`
    - The release PR can be manually edited before merging.
    - The release PR should be merged **ONLY** when a new release is needed.

<br />

- ✅ **When the Release PR Is Merged:**
    - A new Git tag is created.
    - A GitHub Release is published with the changelog.
    - A new version of the brick is automatically published in [brickhub.dev][brickhub_link].

    #### 💡 Notes
    
    - GitHub Releases are created **per template**.
    - The publishing process is automatically triggered when a version tag is created.
    - The automated publishing workflows to [brickhub.dev][brickhub_link] are defined in `.github/workflows/publish_<template-name>.yaml`

<br />

This document provides a good summary of how it works and how we use it, but we recommend that you also read the official documentation of [Conventional Commits][conventional_commits_link], [Semantic Versioning][sem_ver_link], [Publishing a Brick][brickhub_publishing_link] and [`release-please-action`][release-please-action-link].

[brickhub_link]: https://brickhub.dev/
[brickhub_publishing_link]: https://docs.brickhub.dev/mason-publish
[sem_ver_link]: https://semver.org/
[release-please-action-link]: https://github.com/googleapis/release-please-action
[conventional_commits_link]: https://www.conventionalcommits.org/en/v1.0.0
