# jopika.github.io

Personal GitHub Pages site for Jonathan Budiardjo. The site is intended to showcase projects and hold occasional technical writing.

## Stack

- GitHub Pages
- Jekyll
- `github-pages` gem
- `jekyll-theme-tactile`, with local layout and Sass overrides
- Liquid templates and YAML data files

## Repository Layout

- `_config.yml` - site metadata, theme selection, and GitHub Pages repository settings.
- `index.md` - homepage content and Liquid loops for recent projects and posts.
- `_data/projects.yml` - project entries rendered by the homepage.
- `_posts/` - technical writing and blog posts. Use Jekyll's `YYYY-MM-DD-title.md` filename format.
- `_layouts/` - local page wrappers. `front_page.html` is used by the homepage.
- `_sass/` - theme styles plus local customizations. `block-elements.scss` holds the contact and project card styles.
- `_site/` - generated Jekyll output. It is currently tracked, but source changes should usually be made outside this directory.

## Local Development

Install Ruby and Bundler, then install the project gems:

```sh
bundle install
```

Serve the site locally:

```sh
bundle exec jekyll serve
```

The local site should be available at `http://127.0.0.1:4000`.

If `bundle exec jekyll serve` fails because the Jekyll executable is missing, run `bundle install` first.

## Adding A Project

Add a new item to `_data/projects.yml`:

```yml
- name: Project Name
  language: TypeScript
  date: 2026
  image:
  icon: fa-code
  description: One concise sentence about what the project does.
  sourceLink: https://github.com/jopika/project-name
  liveLink:
```

The homepage currently shows the first three valid project entries from this file. Reorder entries to control what appears in "Recent Projects".

## Adding Writing

Create a Markdown file in `_posts/` using Jekyll's date-prefixed naming convention:

```text
_posts/2026-04-30-post-title.md
```

Use front matter at the top:

```md
---
layout: default
title: "Post Title"
---
```

The homepage currently shows the three most recent posts.

## Deployment

This repository is named for GitHub Pages user-site hosting. Pushing to the publishing branch on GitHub should trigger a Pages build using the `github-pages` gem and `_config.yml`.

## Current Notes

- Several contact links in `index.md` are placeholders.
- The layouts still contain temporary footer text.
- The project uses older Tactile theme styling, so future design work will likely touch `_layouts/`, `_sass/block-elements.scss`, and `index.md` together.
