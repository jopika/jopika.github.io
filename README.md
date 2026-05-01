# Jonathan Budiardjo — Personal Site

Personal portfolio and blog, built with [Jekyll](https://jekyllrb.com/) and hosted on GitHub Pages.

## Running locally

```bash
bundle install
bundle exec jekyll serve
```

Then visit `http://localhost:4000`.

## Editing content

Most content lives in YAML data files — no HTML required.

| File | What to edit |
|------|-------------|
| `_config.yml` | Name, email, GitHub, LinkedIn, section limits |
| `_data/experience.yml` | Work history |
| `_data/projects.yml` | Projects |
| `_data/interests.yml` | Interests |
| `_includes/sections/about.html` | About / bio text |

## Adding a blog post

Create a file in `_posts/` named `YYYY-MM-DD-your-title.md`:

```markdown
---
layout: post
title: "Your Post Title"
description: "Short description shown in post listings."
date: 2025-01-15
---

Your post content in Markdown here.
```

## Adjusting homepage truncation

In `_config.yml`, change the `section_limits` values to control how many items each section shows on the homepage before the "View all" link appears:

```yaml
section_limits:
  experience: 2   # show 2 jobs on homepage
  projects: 3     # show 3 projects on homepage
  interests: 4    # show 4 interests on homepage
  posts: 3        # show 3 posts on homepage
```
