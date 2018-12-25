---
layout: "front_page"
title: Jonathan Budiardjo
---
{% assign PROJECT_LIMIT = 3 %}
{% assign POST_LIMIT = 3 %}
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

<div class="projectSection">

{% assign count = 0 %}
{% for project in site.data.projects %}
{% if project.name != null and count < PROJECT_LIMIT %}
<div class="projectBox">
    <div class="projectImage">
        {% if project.image != null  %}
        <img src="{{ project.image }}">
        {% elsif project.icon != null %}
        <img class="fas {{ project.icon }} fa-6x fa-fw">
        {% else %}
        <img src="http://hdimages.org/wp-content/uploads/2017/03/placeholder-image4.jpg">
        {% endif %}
    </div>
    <div class="projectBody">
        <!-- <a href="{{ project.link }}">{{ project.name }}</a><span>: {{ project.description }}</span> <br> -->
        {{ project.name }} - [{{ project.language }}] <br>
        {% if project.sourceLink != null %}
            <a href="{{ project.sourceLink }}">Source Code</a>
        {% endif %}
        {% if project.liveLink != null %}
            <a href="{{ project.liveLink }}">Live Site</a>
        {% endif %}
        {% if project.sourceLink != null or project.liveLink != null %}
        <br>
        {% endif %}
        {{ project.description }} <br>
    </div>
</div>
{% assign count = count | plus: 1 %}
{% endif %}
{% endfor %}
{% if count >= PROJECT_LIMIT %}
<!-- See more generation -->

{% endif %}

</div>

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
