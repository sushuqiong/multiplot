# Release Process

Use this lightweight process when publishing a new version of `multiplot`.

## 1. Update package files

- update `README.md` if exported behavior, styles, or usage changed
- update `CHANGELOG.md`
- update package files, tests, vignettes, docs, or manuscript-support files as needed

## 2. Prepare release notes

Start from:

- `.github/release-template.md`

Keep the note concrete and package-facing.

## 3. Structure to preserve

A good release note for this repo usually includes:

1. one-sentence summary
2. highlights
3. added
4. improved
5. fixed
6. who this helps
7. recommended next step

## 4. Good style for this repo

- distinguish package behavior from manuscript wording changes
- mention demo or verification changes when they affect interpretation
- avoid claiming pixel-perfect reproduction when the package documents approximation
- mention tests, checks, or archive updates when they matter

## 5. Example command flow

```powershell
git add .
git commit -m "Describe the release work"
git push origin main
gh release create vX.Y.Z --title "vX.Y.Z - Short release title" --notes-file release-notes.md
```
