# How to contribute

When contributing to this repository, please first discuss the change you wish
to make via issue, email, or any other method with the owners of this repository
before making a change.

Please note we have a [code of conduct](/CODE_OF_CONDUCT.md), please follow it
in all your interactions with the project.

## Requirements

- [Git](https://git-scm.com/downloads)
- [Godot Engine](https://godotengine.org/)

## Getting Started

- Discuss what you want to change in our [Discord](https://discord.gg/Jeuxa44)
- Make sure you have a [GitHub account](https://github.com/signup/free)
- [Create a feature branch](https://gist.github.com/vlandham/3b2b79c40bc7353ae95a)

## Making Changes

- Create a feature branch from where you want to base your work.
  - This is usually the master branch
  - To quickly create a feature branch based on master, run
    `git checkout -b feature/my_feature_name master`. Please avoid working
    directly on the `master` branch
- Make your changes
- Make commits of logical and atomic units (taking note of the below)
- Check for unnecessary whitespace with `git diff --check` before committing
- Make sure your commit messages are in the proper format. If the commit
  addresses an issue filed on Github, start the first line of the commit with
  `GH-` and then the issue number in square brackets (e.g. `[GH-1234]`)
- Make sure your commit message subject line uses the
  [imperative mood](https://en.wikipedia.org/wiki/Imperative_mood)

  ```
      [GH-1234] Add new feature

      Longer description block if needed...
  ```

- Push your changes to your feature branch

```
    git push -u origin feature/my_feature_name
```

## Creating release builds

- If you wish to create distributable release builds for all export targets, you
  need to [tag your commit](https://git-scm.com/book/en/v2/Git-Basics-Tagging).
  Travis-ci will handle the rest and build artifacts will be listed in the
  [releases](https://github.com/sneyed/game-off-2018/releases) section.

## Pull Request Process

- Push your changes to your feature branch if you have not done so already
- [Submit a pull request](https://help.github.com/articles/creating-a-pull-request/)
  to the repository
- Your PR will be reviewed
- If everything looks good and there is no regressions, your PR will be merged

### Summary

- Ensure you have installed all requirements
- Make others aware of what you plan to change in Discord
- Modify the source code in your own feature branch or fork
- Raise a pull request and get it reviewed
- Your PR will be merged to master
