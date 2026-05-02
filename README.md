# Jonathan Budiardjo Personal Site

Personal portfolio and blog for Jonathan Budiardjo, built with
[Jekyll](https://jekyllrb.com/) and hosted with GitHub Pages.

The site is intentionally data-driven: most homepage and section content lives
in YAML files under `_data/`, while Liquid includes render the repeated section
layouts.

## Tech stack

- Jekyll through the `github-pages` gem
- Liquid templates and includes
- Sass partials compiled through `assets/css/main.scss`
- Small vanilla JavaScript helpers in `assets/js/main.js`
- GitHub Pages compatible plugins:
  - `jekyll-feed`
  - `jekyll-seo-tag`

## Local development

Install Ruby and Bundler, then run:

```bash
bundle install
bundle exec jekyll serve
```

Open `http://localhost:4000`.

To build without starting a server:

```bash
bundle exec jekyll build
```

The generated site is written to `_site/`, which is not committed.

## Project structure

| Path | Purpose |
| --- | --- |
| `_config.yml` | Site metadata, author links, plugins, permalink settings, and homepage section limits |
| `_data/about.yml` | Homepage about text and aside copy |
| `_data/experience.yml` | Work history entries |
| `_data/projects.yml` | Project entries |
| `_data/interests.yml` | Interest entries |
| `_includes/sections/` | Reusable section renderers for homepage and full section pages |
| `_includes/nav.html` | Main navigation |
| `_layouts/default.html` | Base page shell |
| `_layouts/section.html` | Shared layout for full section pages |
| `_layouts/post.html` | Blog post layout |
| `_sass/` | Sass partials imported by `assets/css/main.scss` |
| `_posts/` | Blog posts in Markdown |
| `assets/js/main.js` | Mobile navigation and active link behavior |
| `experience.html`, `projects.html`, `interests.html`, `blog/index.html` | Full listing pages |

## Editing content

Most content changes do not require editing HTML.

### Site metadata and links

Edit `_config.yml` for:

- Site title, tagline, and description
- Canonical URL and repository
- Author email, GitHub, LinkedIn, resume, and calendar links
- Homepage section limits

Placeholder links set to `"#"` are skipped by the templates where applicable.

### About section

Edit `_data/about.yml`:

```yaml
bio: Short primary bio shown in the hero/about area.
aside: Supporting personal note shown beside the bio.
```

### Experience

Edit `_data/experience.yml`. Entries render in the order listed.

```yaml
- company: Company Name
  role: Job Title
  start: "June 2025"
  end: "Present"
  location: Seattle, WA
  description: >-
    Short summary of impact and scope.
  tags:
    - Python
    - Kubernetes
```

Required fields: `company`, `role`, `start`.

Optional fields: `end`, `location`, `description`, `tags`.

If `end` is omitted, the template displays `Present`.

### Projects

Edit `_data/projects.yml`. Entries render in the order listed.

```yaml
- name: Project Name
  language: Python
  status: active
  url: https://github.com/example/project
  description: >-
    Short project summary.
  tags:
    - CLI
    - Automation
```

Required fields: `name`, `language`.

Optional fields: `status`, `url`, `description`, `tags`.

Current status styles expect values such as `active`, `wip`, `maintenance`, or
`archived`.

### Interests

Edit `_data/interests.yml`:

```yaml
- name: Board Games
  note: Optional short note
  description: >-
    Longer description.
```

Required field: `name`.

Optional fields: `note`, `description`.

## Blog posts

Create posts in `_posts/` using Jekyll's date-prefixed filename format:

```text
YYYY-MM-DD-your-title.md
```

Each post needs front matter:

```markdown
---
layout: post
title: "Your Post Title"
description: "Short description shown in post listings."
date: 2026-05-01
---

Your post content in Markdown here.
```

Posts are listed newest first by Jekyll.

## Homepage section limits

The homepage uses the same section includes as the full listing pages, but
limits how many entries are shown before a "more" link appears.

Edit `_config.yml`:

```yaml
section_limits:
  experience: 2
  projects: 3
  interests: 4
  posts: 3
```

The full pages always render all entries:

- `/experience/`
- `/projects/`
- `/interests/`
- `/blog/`

## Styling and behavior

Styles are organized as Sass partials in `_sass/` and imported from
`assets/css/main.scss`.

JavaScript is intentionally minimal. `assets/js/main.js` currently handles:

- Mobile navigation toggling
- Closing the mobile menu after a nav link click
- Highlighting the active section page in the nav

## Deployment

This repository is configured for GitHub Pages. Pushing to the publishing branch
for `jopika.github.io` will build and deploy the site using GitHub Pages.

Before pushing, run:

```bash
bundle exec jekyll build
```
