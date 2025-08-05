### 🛠️ Release Process (Automated via `release-please-action`)

We use [`release-please-action`][release-please-action-link] to automate versioning and changelog generation.

- Every commit to `main` is analyzed using [Conventional Commits][conventional_commits_link].
- When a commit indicates a version bump is needed, a **release PR** is automatically created or updated.
- The release PR includes:
  - An updated `CHANGELOG.md`
  - A version bump in `brick.yaml`
- Once the release PR is merged:
  - A new Git tag is created.
  - A GitHub release is published with the changelog.
- Release PR's are created per template.

#### 💡 Notes

- Use `feat`, `fix`, or `BREAKING CHANGE:` in commit messages to trigger version bumps.
- The release PR can be manually edited before merging.
- The GitHub Action is configured in `.github/workflows/release_please.yaml`
- release-please settings are defined in `.release-please-config.json` and `.release-please-manifest.json`

[release-please-action-link]: https://github.com/googleapis/release-please-action