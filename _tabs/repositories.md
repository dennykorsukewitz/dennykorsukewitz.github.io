---
layout: page
icon: fa fa-cubes
order: 1
---

<div class='repository'>
{% for repository in site.data.repositories %}
    <a href="../{{ repository }}" >
        <img alt="{{ repository }}" class="github-repository" src="https://ghrs.vercel.app/api/pin/?username=dennykorsukewitz&repo={{ repository }}&theme=transparent" />
    </a>
{% endfor %}
</div>
