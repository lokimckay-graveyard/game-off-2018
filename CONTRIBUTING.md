# How to contribute

This page instructs you on how to contribute to this repository.
If you are a beginner with git please check out some of these helpful materials
before continuing:

- [Git - the simple guide](http://rogerdudler.github.io/git-guide/)
- [Git - Basic Branching and Merging](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)
- [About pull requests](https://help.github.com/articles/about-pull-requests/)
- [How to contribute to an open source project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

When contributing to this repository, please first discuss the change you wish
to make via issue, email, or any other method with the owners of this repository
before making a change.

Please note we have a [code of conduct](/CODE_OF_CONDUCT.md), please follow it
in all your interactions with the project.

## Requirements

- [Git](https://git-scm.com/downloads)
- [Godot Engine](https://godotengine.org/)

## Getting Started

1. Discuss what you want to change in our [Discord](https://discord.gg/Jeuxa44)
2. Make sure you have a [GitHub account](https://github.com/signup/free)
3. [Create a feature branch](https://gist.github.com/vlandham/3b2b79c40bc7353ae95a)

## Making Changes

1. Create a feature branch from where you want to base your work.
   - This is usually the master branch
   - To quickly create a feature branch based on master, run
     `git checkout -b feature/my_feature_name master`. Please avoid working
     directly on the `master` branch

2. Make your changes
3. Make commits of logical and atomic units (taking note of the below)
4. Check for unnecessary whitespace with `git diff --check` before committing
5. Make sure your commit messages are in the proper format. If the commit
   addresses an issue filed on Github, start the first line of the commit with
   `GH-` and then the issue number in square brackets (e.g. `[GH-1234]`)
6. Make sure your commit message subject line uses the
   [imperative mood](https://en.wikipedia.org/wiki/Imperative_mood)

    ```
        [GH-1234] Add new feature

        Longer description block if needed...
    ```

7. Push your changes to your feature branch

    ```
        git push -u origin feature/my_feature_name
    ```

## Creating release builds

- If you wish to create distributable release builds for all export targets, you
  need to [tag your commit](https://git-scm.com/book/en/v2/Git-Basics-Tagging).
- Travis-ci will handle the rest and build artifacts will be listed in the
  [releases](https://github.com/sneyed/game-off-2018/releases) section.

## Pull Request Process

1. Push your changes to your feature branch if you have not done so already
1. [Submit a pull request](https://help.github.com/articles/creating-a-pull-request/)
  to the repository
1. Your PR will be reviewed
1. If everything looks good and there is no regressions, your PR will be merged

### Summary

1. Ensure you have installed all requirements
1. Make others aware of what you plan to change in Discord
1. Modify the source code in your own feature branch or fork
1. Raise a pull request and get it reviewed
1. Your PR will be merged to master
