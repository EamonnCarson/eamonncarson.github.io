# Personal Hugo Website

A minimal Hugo setup for personal writing, styled to feel similar to <https://kellerjordan.github.io/>.

## What is included

- `content/articles/`: write your posts here in Markdown.
- `static/css/site.css`: one centralized stylesheet with a 4-color scheme in `:root`.
- Homepage list showing each article's title, date, estimated read time, and summary.
- Header with a light/dark mode toggle and an `About` link (`/about/`).

## Write a new article

Create a file like `content/articles/my-post.md`:

```md
+++
title = "My Post"
date = 2026-02-03T09:00:00-05:00
draft = false
+++

This first paragraph is the summary shown on the homepage.

<!--more-->

The rest of the article goes here.
```

## Customize colors

Edit the CSS variables in `static/css/site.css`:

```css
:root {
  --color-bg: #d4b896;
  --color-text: #4a403a;
  --color-accent: #f4a900;
  --color-muted: #c1666b;
}
```

## Run locally

1. Install Hugo (extended recommended).
2. Start the dev server:

```bash
hugo server -D
```

Then open `http://localhost:1313`.

For Docker/local-network access, use:

```bash
hugo server -D --bind 0.0.0.0 --port 8080
```
