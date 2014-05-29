## any-tap.rb: `brew tap` for everything!

# NOTICE 2014-05-06

Homebrew recently changed how it structures `Library/Taps`. As a result,
you may have seen warnings when updating `brew`. The warning can sound
scary, but the good news is that the fix is pretty simple. For details,
please see [my comment here on a related issue][issue].

[issue]: https://github.com/telemachus/homebrew-anytap/issues/3#issuecomment-42294369

## What is `brew anytap`?

It's an [external command][ec] for [Homebrew][brew]. It is meant to be
a replacement for the built-in [`brew tap`][bt] command. That command has
certain limitations, but because of backwards compatibility, it's hard to
update.

This command scratches my itch. I wanted a souped-up version of `brew tap`.
I have freely borrowed (ahem, stolen) code from the existing `brew tap`
command. I thank all the people who worked on that.

[ec]: https://github.com/mxcl/homebrew/wiki/External-Commands
[brew]: https://github.com/mxcl/homebrew
[bt]: https://github.com/mxcl/homebrew/wiki/brew-tap

## Installation

+ The easiest thing is (ironically?) to use `brew tap`:

        brew tap telemachus/anytap
        brew install brew-any-tap

  That will install `brew any-tap` and `brew any-untap`. See below for
  usage notes on both.
+ If you prefer, however, you can simply clone this repository and then
  copy `brew-any-tap.rb` and `brew-any-untap.rb` anywhere in your `$PATH`.

  If you do that, `brew` will automatically be able to pick up the commands
  and do the right thing with them.

## Usage

+ `brew any-tap`
    + `brew any-tap`: List currently installed taps
    + `brew any-tap -h|-?|--help`: Get usage
    + `brew any-tap -r|--repair`: Check all symlinks and remove orphans
    + `brew any-tap user name URL`: Clone repo at URL as 'user/{homebrew-}name'
      The prefix 'homebrew-' will be added if not given in order to conform
      with what other `brew` commands expect.
+ `brew any-untap`
    + `brew any-untap -h|-?|--help`: Get usage
    + `brew any-untap`: List currently installed taps
    + `brew any-untap name1 [name2 name3 ...]`: Untap one or more taps
+ The key difference between `brew tap` and `brew any-tap` is that `brew
  any-tap` will attempt to tap *any* URL that you give it. You can tap
  private repositories, things not on GitHub, things on disc rather than
  online anywhere, and things that have any naming conventions.

  The price you pay is that you must be more explicit because `brew
  any-tap` and `brew any-untap` don't make any assumptions. To tap a new
  repository using `brew any-tap` requires three arguments. The first two
  are combined to create the directory structure that `brew` expects (more
  on this below), and the last is the URL of repo that you want to clone.
  `brew any-tap` will combine the first two arguments and check if there's
  a directory at `HOMEBREW_LIBRARY/"Taps/#{arg1}/homebrew-#{arg2}"`.  If
  such a directory already exists, the tap aborts. Otherwise, `brew
  any-tap` combines the arguments to run the following command:

        git clone arg3 HOMEBREW_LIBRARY/"Taps/#{arg1}/homebrew-#{arg2}"

  To make this a bit more concrete, here's a call and what it would do:

        brew any-tap telemachus myjunk https://telemachus@bitbucket.org/telemachus/brew.git
        -- Assuming it doesn't yet exist
        git clone https://telemachus@bitbucket.org/telemachus/brew.git HOMEBREW_LIBRARY/Taps/telemachus/homebrew-myjunk

  You might wonder why 'homebrew-' is added to the second argument.
  Unfortunately, other `brew` commands---in particular `brew
  install`---assume that all taps have 'homebrew-' in their name. In order
  to work smoothly with `brew` as a whole, `brew any-tap` will add
  'homebrew-' to `arg2` if it's not already there.

## Historical note

When `brew tap` was first created, all taps were added directly below the
`Taps` directory, but after a recent change, they are now added to
subdirectories, according to the username of the repo owner on GitHub.
That is, all new taps exist at `Taps/username/homebrew-reponame`. As of
version 0.0.9, `brew any-tap` uses this same structure in order to be fully
compatible with the rest of `brew`.

## Contributors

+ [ipmcc](https://github.com/ipmcc)
+ [Ivan Andrus](https://github.com/gvol)
+ [Mike English](https://github.com/englishm)

## Contributing

Fork, edit and pass me a pull request. Nothing more formal than that, but
please do let me know *why* the change makes sense. Thanks.
