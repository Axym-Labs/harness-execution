# Embedded LaTeX publications

Store article and project-page sources as LaTeX. During each website build,
`scripts/render-latex-publications.py` converts them with TeX4ht/`make4ht` and
embeds the resulting body fragment in the existing site shell. The generated
HTML is not a standalone document and is not committed.

- Personal website sources: `content/latex/posts/`
- Axym website sources: `src/content/latex/work/`

Begin each source with comment-prefixed YAML front matter, then use the shared
package:

```tex
%---
% title: Example article
% date: 2026-07-15
%---
\documentclass[11pt]{article}
\usepackage{publication-web}
\begin{document}
\section{First section}
Article text.
\end{document}
```

Use the same source for PDF and HTML. For HTML-only markup, keep the PDF branch
empty or supply a plain alternative:

```tex
\ifdefined\HCode
  \ifvmode\IgnorePar\fi\EndP
  \HCode{<details class="publication-interactive"><summary>Explore</summary><p>HTML-only detail.</p></details>}\ShowPar
\fi
```

Native elements such as `details` are the portable default for simple
interaction. More involved interactions belong in a site component referenced
by a stable `data-*` hook, rather than in an inline script.

For figures whose web URL differs from the repository path:

```tex
\publicationfigure[0.9\linewidth]
  {images/result.png}{/images/result.png}
  {Short accessible description}
  {Figure caption.}
```

The renderer preserves the comment front matter, adds the site-specific format
marker requested by the workflow, bundles the P052 web font used by the paper
template, and writes one generated HTML fragment per source.
