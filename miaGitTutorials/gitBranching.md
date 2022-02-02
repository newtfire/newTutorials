# The Basics of Git Branching

![git branch](images/gitBranch.png)

**Table of Contents**
- [The Basics of Git Branching](#the-basics-of-git-branching)
- [Why We Use Git Branches, Explained with Twinkies](#why-we-use-git-branches-explained-with-twinkies)
- [The Terminal/Bash Shell Commands & What They Do](#the-terminalbash-shell-commands--what-they-do)
- [Git Branch Basic Workflow](#git-branch-basic-workflow)
  - [Keeping your branch Up-To-Date with main branch](#keeping-your-branch-up-to-date-with-main-branch)
  - [What is an upstream?](#what-is-an-upstream)
    - [What good is an upstream?](#what-good-is-an-upstream)
    - [The upstream affects git merge and git rebase too](#the-upstream-affects-git-merge-and-git-rebase-too)
    - [The upstream affects git pull](#the-upstream-affects-git-pull)
    - [The upstream affects git status](#the-upstream-affects-git-status)


Using a branching workflow in your coding projects is essential for organizing, tracking, and safely merging your code in any collaborative project setting. This method of project development is used constantly in any real-world development career in the coding, so making git branching and merging second-nature to you is a highly valuable skill. And it's very simple once you get used to it!

Here, we will walk you through the philosophy of git branching and how to incorporate this essential workflow into your GitHub projects.

# Why We Use Git Branches, Explained with Twinkies

![twinkie pg 1](images/twinkieSlides/twinkie1.png)

![twinkie pg 2](images/twinkieSlides/twinkie2.png)

# The Terminal/Bash Shell Commands & What They Do

| Command | Description |
| --- | --- |
| `git branch` | Show all of the branches on your repo, with the branch you're currently on highlighted with an asterisk. `*` THIS COMMAND IS YOUR BEST FRINED. **Always check** which branch you are on **BEFORE** editing any files in the repo AND **before adding/committing/pushing your updates.** |
| `git checkout -b newBranchName` | Create a new branch off of whichever branch in the repo you are currently on. In this example, replace `newBranchName` with a name that includes your **NAME**, and a **BRIEF DESCRIPTION** of what kind of development work you will be doing in this branch. |
|  `git push --set-upstream origin branchName` | Your git bash/terminal will ask you to enter this command the first time you try pushing to a new branch. See a full explanation of an `upstream` in the section below. |
| `git checkout existingBranchName` | Use this command to SWITCH to a different existing branch in the repo. **ALWAYS BE WARY** of what branch you are currently on to ensure you do not commit and push file changes to the wrong branch!!! |
| `git merge main` | Use this command when you are **currently on your own personal development branch** to update your branch any new changes and commits made on the main branch. It's good practice to do this if you see that your branch is quite a few commits behind main. **using `git pull` to update your feature branch with new work in the main branch will not work. It will only pull in changes made on the remote version of your branch.** See the diagram illustrating what this command does in the below section titled *Keeping your branch Up-To-Date with main branch*.|
| `git status` | List all new or modified files |
| `git diff` | Show file differences that haven't been staged |


# Git Branch Basic Workflow
*coming soon*

## Keeping your branch Up-To-Date with main branch

Your git terminal will tell you when your working branch is a couple commits behind main. 

You should always keep your branch up to date with all of the development code committed to main so that you do not run into nasty merge conflicts and development lags/bugs when you eventually merge your branch into main later on.

To do this, you must use `git checkout myBranchName` to ensure you are on your working branch.
Then, use `git merge main` to incorporate the new commits from the main branch into your branch's commit history. **Note: this is not the same thing as merging your branch into the main branch.** 

Illustration from [Atlassian](https://www.atlassian.com/git/tutorials/merging-vs-rebasing):

![Git Merge Main Into Branch](images/gitMergingMainIntoBranch.jpg)




## What is an upstream?
(from [Slack Overflow](https://stackoverflow.com/a/37770744))

An upstream is simply another branch name, usually a remote-tracking branch, associated with a (regular, local) branch.

Every branch has the option of having one (1) upstream set. That is, every branch either has an upstream, or does not have an upstream. No branch can have more than one upstream.

The upstream should, but does not have to be, a valid branch (whether remote-tracking like `origin/B` or local like `main`). That is, if the current branch B has upstream U, git rev-parse U should work. If it does not work—if it complains that U does not exist—then most of Git acts as though the upstream is not set at all. A few commands, like git branch -vv, will show the upstream setting but mark it as "gone".

### What good is an upstream?

If your push.default is set to simple or upstream, the upstream setting will make git push, used with no additional arguments, just work.

That's it—that's all it does for git push. But that's fairly significant, since git push is one of the places where a simple typo causes major headaches.

If your push.default is set to nothing, matching, or current, setting an upstream does nothing at all for git push.

(All of this assumes your Git version is at least 2.0.)
The upstream affects git fetch

If you run git fetch with no additional arguments, Git figures out which remote to fetch from by consulting the current branch's upstream. If the upstream is a remote-tracking branch, Git fetches from that remote. (If the upstream is not set or is a local branch, Git tries fetching origin.)

### The upstream affects git merge and git rebase too

If you run git merge or git rebase with no additional arguments, Git uses the current branch's upstream. So it shortens the use of these two commands.

### The upstream affects git pull

You should never use git pull anyway, but if you do, git pull uses the upstream setting to figure out which remote to fetch from, and then which branch to merge or rebase with. That is, git pull does the same thing as git fetch—because it actually runs git fetch—and then does the same thing as git merge or git rebase, because it actually runs git merge or git rebase.

(You should usually just do these two steps manually, at least until you know Git well enough that when either step fails, which they will eventually, you recognize what went wrong and know what to do about it.)

### The upstream affects git status

This may actually be the most important. Once you have an upstream set, git status can report the difference between your current branch and its upstream, in terms of commits.

If, as is the normal case, you are on branch B with its upstream set to origin/B, and you run git status, you will immediately see whether you have commits you can push, and/or commits you can merge or rebase onto.

This is because git status runs:

`git rev-list --count @{u}..HEAD`: how many commits do you have on `B` that are not on `origin/B`?
`git rev-list --count HEAD..@{u}`: how many commits do you have on `origin/B` that are not on `B`?

Setting an upstream gives you all of these things.




**Table of Contents**
- [The Basics of Git Branching](#the-basics-of-git-branching)
- [Why We Use Git Branches, Explained with Twinkies](#why-we-use-git-branches-explained-with-twinkies)
- [The Terminal/Bash Shell Commands & What They Do](#the-terminalbash-shell-commands--what-they-do)
- [Git Branch Basic Workflow](#git-branch-basic-workflow)
  - [Keeping your branch Up-To-Date with main branch](#keeping-your-branch-up-to-date-with-main-branch)
  - [What is an upstream?](#what-is-an-upstream)
    - [What good is an upstream?](#what-good-is-an-upstream)
    - [The upstream affects git merge and git rebase too](#the-upstream-affects-git-merge-and-git-rebase-too)
    - [The upstream affects git pull](#the-upstream-affects-git-pull)
    - [The upstream affects git status](#the-upstream-affects-git-status)