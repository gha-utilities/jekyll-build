## GHA Jekyll Build
[heading__title]:
  #gha-sass
  "&#x2B06; Top of ReadMe File"


Action for running Bundle Install and Jekyll Build within a Docker container


## [![Byte size of gha-sass][badge__master__gha_sass__source_code]][gha_sass__master__source_code] [![Open Issues][badge__issues__gha_sass]][issues__gha_sass] [![Open Pull Requests][badge__pull_requests__gha_sass]][pull_requests__gha_sass] [![Latest commits][badge__commits__gha_sass__master]][commits__gha_sass__master]


------


#### Table of Contents


- [:arrow_up: Top of ReadMe File][heading__title]

- [:building_construction: Requirements][heading__requirements]

- [:zap: Quick Start][heading__quick_start]

- [&#x1F5D2; Notes][notes]

- [:card_index: Attribution][heading__attribution]

- [:balance_scale: License][heading__license]


------



## Requirements
[heading__requirements]:
  #requirements
  "&#x1F3D7; "


Access to GitHub Actions if using on GitHub, or Docker knowhow if utilizing privately.


___


## Quick Start
[heading__quick_start]:
  #quick-start
  "&#9889; Perhaps as easy as one, 2.0,..."


Reference the code of this repository within your own `workflow`...


```YAML
on:
  push:
    branches:
      - src-pages

jobs:
  jekyll_build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout source branch for building Pages
        uses: actions/checkout@v1
        with:
          ref: src-pages
          fetch-depth: 10

      # Note the following may not be required in future versions of Jekyll Build Actions
      - name: Make build destination directory
        run: mkdir -vp ~/www/repository-name

      - name: Jekyll Build
        uses: gha-utilities/jekyll-build@v0.0.1
        with:
          jekyll_github_token: ${{ secrets.JEKYLL_GITHUB_TOKEN }}
          source: ./
          destination: ~/www/repository-name

      - name: Checkout branch for GitHub Pages
        uses: actions/checkout@v1
        with:
          ref: pr-pages
          fetch-depth: 1
          submodules: true

      - name: Copy built site files into Git branch
        run: cp -r ~/www/repository-name ./

      - name: Add and Commit changes to pr-pages branch
        run: |
          git config --local user.email 'action@github.com'
          git config --local user.name 'GitHub Action'
          git add -A .
          git commit -m 'Updates compiled site files'

      - name: Push changes
        uses: ad-m/github-push-action@master
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          branch: pr-pages

      - name: Initialize Pull Request
        uses: gha-utilities/init-pull-request@v0.0.1
        with:
          pull_request_token: ${{ secrets.GITHUB_TOKEN }}
          head: pr-pages
          base: gh-pages
          title: 'Updates site files from latest Actions build'
          body: >
            Perhaps a multi-line description
            about latest features and such.
```


___


## Notes
[notes]:
  #notes
  "&#x1F5D2; Additional notes and links that may be worth clicking in the future"


The [new](https://github.com/settings/tokens/new) `JEKYLL_GITHUB_TOKEN` should have `public_repo` permissions, be assigned within your project's Secrets Settings, eg. `https://github.com/<maintainer>/<repository>/settings/secrets`, and generally is only required if utilizing the `github-metadata` from Jekyll.


------


To pass compiled site files to another Workflow utilize the Upload and Download Actions from GitHub...


**`.github/workflows/jekyll_build.yml`**


```YAML
on:
  push:
    branches:
      - src-pages

jobs:
  jekyll_build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout source branch for building Pages
        uses: actions/checkout@v1
        with:
          ref: src-pages
          fetch-depth: 10

      - name: Make build destination directory
        run: mkdir -vp ~/www/repository-name

      - name: Jekyll Build
        uses: gha-utilities/jekyll-build@v0.0.1
        with:
          source: ./
          destination: ~/www/repository-name

      - name: Upload Built Pages
        uses: actions/upload-artifact@v1.0.0
        with:
          name: Complied-Jekyll-Pages
          path: ~/www/repository-name
```


**`.github/workflows/open_pull_request.yml`**


```YAML
on:
  push:
    branches:
      - src-pages

jobs:
  open_pull_request:
    needs: [jekyll_build]
    runs-on: ubuntu-latest

    steps:
      - name: Checkout branch for GitHub Pages
        uses: actions/checkout@v1
        with:
          ref: gh-pages
          fetch-depth: 1
          submodules: true

      - name: Download Compiled Pages
        uses: actions/upload-artifact@v1.0.0
        with:
          name: Complied-Jekyll-Pages
          path: ./

      - name: Add and Commit changes to pr-pages branch
        run: |
          git config --local user.email 'action@github.com'
          git config --local user.name 'GitHub Action'
          git add -A .
          git commit -m 'Updates compiled site files'

      - name: Push changes
        uses: ad-m/github-push-action@master
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          branch: pr-pages

      - name: Initialize Pull Request
        uses: gha-utilities/init-pull-request@v0.0.1
        with:
          pull_request_token: ${{ secrets.GITHUB_TOKEN }}
          head: pr-pages
          base: gh-pages
          title: 'Updates site files from latest Actions build'
          body: >
            Perhaps a multi-line description
            about latest features and such.
```


___


## Attribution
[heading__attribution]:
  #attribution
  "&#x1F4C7; Resources that where helpful in building this project so far."


- [Bundler -- Bundler Docker Guide](https://bundler.io/v2.0/guides/bundler_docker_guide.html)

- [GitHub -- Workflow Syntax for GitHub Actions](https://help.github.com/en/articles/workflow-syntax-for-github-actions)

- [Jekyll -- `github-metadata` Authentication](https://github.com/jekyll/github-metadata/blob/master/docs/authentication.md)


___


## License
[heading__license]:
  #license
  "&#x2696; Legal bits of Open Source software"


Legal bits of Open Source software


```
Jekyll Build GitHub Actions documentation
Copyright (C) 2019  S0AndS0

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation; version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```



[badge__commits__gha_sass__master]:
  https://img.shields.io/github/last-commit/scss-utilities/gha-sass/master.svg

[commits__gha_sass__master]:
  https://github.com/scss-utilities/gha-sass/commits/master
  "&#x1F4DD; History of changes on this branch"


[gha_sass__community]:
  https://github.com/scss-utilities/gha-sass/community
  "&#x1F331; Dedicated to functioning code"


[badge__issues__gha_sass]:
  https://img.shields.io/github/issues/scss-utilities/gha-sass.svg

[issues__gha_sass]:
  https://github.com/scss-utilities/gha-sass/issues
  "&#x2622; Search for and _bump_ existing issues or open new issues for project maintainer to address."


[badge__pull_requests__gha_sass]:
  https://img.shields.io/github/issues-pr/scss-utilities/gha-sass.svg

[pull_requests__gha_sass]:
  https://github.com/scss-utilities/gha-sass/pulls
  "&#x1F3D7; Pull Request friendly, though please check the Community guidelines"


[badge__master__gha_sass__source_code]:
  https://img.shields.io/github/repo-size/scss-utilities/gha-sass

[gha_sass__master__source_code]:
  https://github.com/scss-utilities/gha-sass
  "&#x2328; Project source code!"
