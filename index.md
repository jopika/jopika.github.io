---
layout: "front_page"
title: Jonathan Budiardjo
---
{% assign POST_LIMIT = 3 %}
{% assign PROJECT_GRID_COLUMNS = site.project_grid.columns | default: 3 %}
{% assign PROJECT_GRID_INITIAL_ROWS = site.project_grid.initial_rows | default: 1 %}
{% assign PROJECT_GRID_REVEAL_ROWS = site.project_grid.reveal_rows | default: 1 %}
{% assign PROJECT_INITIAL_COUNT = PROJECT_GRID_COLUMNS | times: PROJECT_GRID_INITIAL_ROWS %}
{% assign PROJECT_REVEAL_COUNT = PROJECT_GRID_COLUMNS | times: PROJECT_GRID_REVEAL_ROWS %}
My name is Jonathan Budiardjo, and I'm a Computer Engineer currently studying at the University of British Columbia

## Contact me
<blockquote class="contactBox">
<table>
    <tr> 
        <td>Email</td>
        <td><a href="mailto:j.budiardjo@gmail.com">j.budiardjo@gmail.com</a></td> 
    </tr>
    <tr>
        <td>Github</td>
        <td><a href="https://github.com/jopika">https://github.com/Jopika</a></td>
    </tr>
    <tr>
        <td>Resume</td>
        <td><a href="https://www.google.com">Hello</a></td>
    </tr>
    <tr>
        <td>LinkedIn</td>
        <td><a href="https://www.google.com">Hello</a></td>
    </tr>
    <tr>
        <td>Calendar</td>
        <td><a href="https://www.google.com">Hello</a></td>
    </tr>
</table>
</blockquote>

## Recent Projects

<div class="projectSection" style="--project-grid-columns: {{ PROJECT_GRID_COLUMNS }};">

{% assign sorted_projects = site.data.projects | sort: "weight" | reverse %}
{% for project in sorted_projects %}
{% if project.name != null %}
<article class="projectBox{% if project.image == null or project.image == "" %}{% if project.icon == null or project.icon == "" %} projectBoxNoImage{% endif %}{% endif %}{% if forloop.index > PROJECT_INITIAL_COUNT %} projectBoxHidden{% endif %}" data-project-card data-project-index="{{ forloop.index0 }}">
    {% assign project_href = "#" %}
    {% if project.sourceLink != null and project.sourceLink != "" %}
        {% assign project_href = project.sourceLink %}
    {% elsif project.liveLink != null and project.liveLink != "" %}
        {% assign project_href = project.liveLink %}
    {% endif %}
    {% if project.image != null and project.image != "" %}
    <a class="projectImage" href="{{ project_href }}" aria-label="{{ project.name }}">
        <img src="{{ project.image }}" alt="{{ project.name }} project image">
    </a>
    {% elsif project.icon != null and project.icon != "" %}
    <div class="projectImage projectImageIcon" aria-hidden="true">
        <i class="fas {{ project.icon }}"></i>
    </div>
    {% endif %}
    <div class="projectBody">
        <h3>{{ project.name }}</h3>
        <div class="projectMeta">
            {% if project.language != null and project.language != "" %}
            <span>{{ project.language }}</span>
            {% endif %}
            {% if project.liveLink != null and project.liveLink != "" %}
            <a href="{{ project.liveLink }}">Live</a>
            {% endif %}
            {% if project.sourceLink != null and project.sourceLink != "" %}
            <a class="projectCodeLink" href="{{ project.sourceLink }}" aria-label="{{ project.name }} source code" title="Source code">
                <i class="fas fa-code-branch" aria-hidden="true"></i>
            </a>
            {% endif %}
        </div>
        <p>{{ project.description }}</p>
    </div>
</article>
{% endif %}
{% endfor %}

</div>

{% assign project_count = site.data.projects | size %}
{% if project_count > PROJECT_INITIAL_COUNT %}
<button class="projectMoreButton" type="button" data-project-more data-project-reveal-count="{{ PROJECT_REVEAL_COUNT }}">
    More Projects
</button>
{% endif %}

<script>
(function () {
    var moreButton = document.querySelector('[data-project-more]');
    if (!moreButton) {
        return;
    }

    var revealCount = parseInt(moreButton.getAttribute('data-project-reveal-count'), 10);
    var hiddenCards = function () {
        return Array.prototype.slice.call(document.querySelectorAll('[data-project-card].projectBoxHidden'));
    };

    moreButton.addEventListener('click', function () {
        hiddenCards().slice(0, revealCount).forEach(function (card) {
            card.classList.remove('projectBoxHidden');
        });

        if (hiddenCards().length === 0) {
            moreButton.remove();
        }
    });
})();
</script>

## Recent Posts
{% for post in site.posts limit:POST_LIMIT %}
<p>
    {{ post.title }} -
    {{ post.excerpt }}
</p>
{% endfor %}



<!-- ## Welcome to GitHub Pages

You can use the [editor on GitHub](https://github.com/jopika/jopika.github.io/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/jopika/jopika.github.io/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
 -->
